import 'package:flutter/material.dart';
import 'package:sagos_mobile/model/asset.dart';
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/service/api_status.dart';
import 'package:sagos_mobile/service/customer_service.dart';

class CustomerViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Customer> _customerListModel = [];

  //GETTERS
  bool get loading => _loading;
  List<Customer> get customerListModel => _customerListModel;

  //SETTERS
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCustomerListModel(Map<String, dynamic> customerListModel) {
    customerListModel.forEach((customerId, customerValue) {
      if (customerValue['dataNascimento'] == '') {
        customerValue['dataNascimento'] = null;
      }
      _customerListModel.add(Customer(
          id: customerId,
          nome: customerValue['nome'],
          sobrenome: customerValue['sobrenome'],
          telefone: customerValue['telefone'],
          cpf: customerValue['CPF'],
          dataNascimento: customerValue['dataNascimento'] != null
              ? DateTime.parse(customerValue['dataNascimento'])
              : null,
          assets: customerValue['assets'] != null
              ? (customerValue['assets'] as List<dynamic>).map((asset) {
                  return Asset(
                      id: asset['id'],
                      descricao: asset['descricao'],
                      codigo: asset['codigo']);
                }).toList()
              : null));
    });
  }

  getCustomers() async {
    setLoading(true);
    var response = await CustomerService.getCustomers();
    if (response is Success) {
      //Map<String, dynamic> data = jsonDecode(response);
      if (_customerListModel.isNotEmpty) {
        _customerListModel = [];
      }
      setCustomerListModel(response.response);
    }
    if (response is Failure) {
      print(response.errorResponse);
    }
    setLoading(false);
  }

  saveCustomer(Map<String, Object> data) async {
    await setLoading(true);
    final customer = CustomerMapToObjectWithoutId(data);
    var response = await CustomerService.saveCustomerService(customer);
    customer.id = response.toString();
    _customerListModel.add(customer);
    await setLoading(false);
  }

  saveAsset(Map<String, Object> data) async {
    await setLoading(true);
    var index =
        _customerListModel.indexWhere((c) => c.id == data['customerId']);
    var customer = _customerListModel[index];
    var assetLenght = customer.assets?.length;
    var asset = AssetMapToObject(data, assetLenght ?? 0);
    customer.assets ?? (customer.assets = <Asset>[]);
    customer.assets?.add(asset);
    var response = await CustomerService.saveCustomerService(customer);
    await setLoading(false);
  }

  Future<void> removeCustomer(Customer customer) async {
    var index = _customerListModel.indexWhere((c) => c.id == customer.id);
    if (index >= 0) {
      setLoading(true);
      var response = await CustomerService.removeCustomerService(customer);
      if (response == true) {
        _customerListModel.remove(customer);
        setLoading(false);
      } else {
        setLoading(false);
      }
    }
  }

  updateCustomer(Map<String, Object> data) async {
    final customer = CustomerMapToObjectWithId(data);
    var index = _customerListModel.indexWhere((c) => c.id == customer.id);
    if (index >= 0) {
      setLoading(true);
      var response = await CustomerService.saveCustomerService(customer);
      _customerListModel[index] = customer;
      setLoading(false);
    }
  }

  int getItensCount() {
    return _customerListModel.length;
  }

  Customer CustomerMapToObjectWithoutId(Map<String, Object> data) {
    final customer = Customer(
        id: '',
        nome: data['nome'] as String,
        sobrenome: data['sobrenome'] as String,
        cpf: data['CPF'] != null ? data['CPF'].toString() : '',
        telefone: data['telefone'] != null ? data['telefone'].toString() : '',
        dataNascimento: data['dataNascimento'] != null
            ? DateTime.parse(data['dataNascimento'].toString())
            : null);
    return customer;
  }

  Customer CustomerMapToObjectWithId(Map<String, Object> data) {
    final customer = Customer(
        id: data['id'] as String,
        nome: data['nome'] as String,
        sobrenome: data['sobrenome'] as String,
        cpf: data['CPF'] as String,
        telefone: data['telefone'] as String,
        dataNascimento: data['dataNascimento'] != ""
            ? DateTime.parse(data['dataNascimento'].toString())
            : null);
    return customer;
  }

  Asset AssetMapToObject(Map<String, Object> data, int? assetLenght) {
    final asset = Asset(
        id: assetLenght.toString(),
        descricao: data['descricao'] as String,
        codigo: data['codigo'] as String,
        identificacao: data['identificacao'] as String);
    return asset;
  }

  Customer getCustomer(String customerId) {
    var index = _customerListModel.indexWhere((c) => c.id == customerId);
    return _customerListModel[index];
  }
}
