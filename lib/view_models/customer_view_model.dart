import 'package:flutter/material.dart';
import 'package:sagos_mobile/model/address.dart';
import 'package:sagos_mobile/model/asset.dart';
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/service/api_status.dart';
import 'package:sagos_mobile/service/customer_service.dart';
import 'package:uuid/uuid.dart';

class CustomerViewModel extends ChangeNotifier {
  String _token;
  bool _loading = false;
  List<Customer> _customerListModel = [];

  CustomerViewModel(this._token, this._customerListModel);

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
                      identificacao: asset['identificacao'],
                      ativo: asset['ativo']);
                }).toList()
              : null,
          address: customerValue['address'] != null
              ? (customerValue['address'] as List<dynamic>).map((address) {
                  return Address(
                      id: address['id'],
                      rua: address['rua'],
                      numero: 180,
                      cep: address['cep'],
                      bairro: address['bairro'],
                      cidade: address['cidade']);
                }).toList()
              : null));
    });
  }

  getCustomers() async {
    setLoading(true);
    var response = await CustomerService.getCustomers(_token);
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
    var response = await CustomerService.saveCustomerService(_token, customer);
    customer.id = response.toString();
    _customerListModel.add(customer);
    await setLoading(false);
  }

  saveAsset(Map<String, Object> data) async {
    await setLoading(true);
    var customerIndex =
        _customerListModel.indexWhere((c) => c.id == data['customerId']);
    var customer = _customerListModel[customerIndex];
    if (customer != null) {
      var asset = AssetMapToObject(data);
      customer.assets ?? (customer.assets = <Asset>[]);
      var assetIndex =
          customer.assets?.indexWhere((a) => a.id == data['id'].toString());
      if (assetIndex! >= 0) {
        var asset = customer.assets![assetIndex] as Asset;
        asset.id = data['id'].toString();
        asset.ativo = asset.ativo;
        asset.descricao = data['descricao'].toString();
        asset.identificacao = data['identificacao'].toString();

        customer.assets![assetIndex] = asset;
      } else {
        customer.assets?.add(asset);
      }
      var response =
          await CustomerService.saveCustomerService(_token, customer);
    }
    await setLoading(false);
  }

  saveAddress(Map<String, Object> data) async {
    await setLoading(true);
    var customerIndex =
        _customerListModel.indexWhere((c) => c.id == data['customerId']);
    var customer = _customerListModel[customerIndex];
    if (customer != null) {
      var address = AddressMapToObject(data);
      customer.address ?? (customer.address = <Address>[]);
      var addressIndex =
          customer.address?.indexWhere((a) => a.id == data['id'].toString());
      if (addressIndex! >= 0) {
        var address = customer.address![addressIndex] as Address;
        address.id = data['id'].toString();
        address.cep = data['cep'].toString();
        address.rua = data['rua'].toString();
        address.numero = int.parse(data['numero'].toString());
        address.bairro = data['bairro'].toString();
        address.cidade = data['cidade'].toString();

        customer.address![addressIndex] = address;
      } else {
        customer.address?.add(address);
      }
      var response =
          await CustomerService.saveCustomerService(_token, customer);
    }
    await setLoading(false);
  }

  Future<void> removeCustomer(Customer customer) async {
    var index = _customerListModel.indexWhere((c) => c.id == customer.id);
    if (index >= 0) {
      setLoading(true);
      var response =
          await CustomerService.removeCustomerService(_token, customer);
      if (response == true) {
        _customerListModel.remove(customer);
        setLoading(false);
      } else {
        setLoading(false);
      }
    }
  }

  Future<void> removeAsset(Asset asset, String customerid) async {
    setLoading(true);
    var index = _customerListModel.indexWhere((c) => c.id == customerid);
    var costumer = _customerListModel[index];
    if (costumer != null) {
      costumer.assets!.remove(asset);
      var response =
          await CustomerService.saveCustomerService(_token, costumer);
      _customerListModel.remove(asset);
    }
    setLoading(false);
  }

  Future<void> changeAssetStatus(Asset asset, String customerid) async {
    setLoading(true);
    var customerIndex =
        _customerListModel.indexWhere((c) => c.id == customerid);
    var customer = _customerListModel[customerIndex];
    if (customer != null) {
      var assetIndex = customer.assets!.indexWhere((a) => a.id == asset.id);
      var assetValue = customer.assets![assetIndex];
      if (asset != null) {
        asset.ativo = !asset.ativo;
        var response =
            await CustomerService.saveCustomerService(_token, customer);
      }
    }
    setLoading(false);
  }

  Future<void> removeAddress(Address address, String customerid) async {
    setLoading(true);
    var index = _customerListModel.indexWhere((c) => c.id == customerid);
    var costumer = _customerListModel[index];
    if (costumer != null) {
      costumer.address!.remove(address);
      var response =
          await CustomerService.saveCustomerService(_token, costumer);
      costumer.address!.remove(address);
    }
    setLoading(false);
  }

  updateCustomer(Map<String, Object> data) async {
    final customer = CustomerMapToObjectWithId(data);
    var index = _customerListModel.indexWhere((c) => c.id == customer.id);
    if (index >= 0) {
      setLoading(true);
      var response =
          await CustomerService.saveCustomerService(_token, customer);
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

  Asset AssetMapToObject(Map<String, Object> data) {
    final asset = Asset(
        id: data['id'] != "" ? data['id'].toString() : Uuid().v1().toString(),
        ativo: true,
        descricao: data['descricao'] as String,
        identificacao: data['identificacao'] as String);
    return asset;
  }

  Address AddressMapToObject(Map<String, Object> data) {
    final address = Address(
        id: data['id'] != "" ? data['id'].toString() : Uuid().v1().toString(),
        rua: data['rua'].toString(),
        numero: int.parse(data['numero'].toString()),
        bairro: data['bairro'].toString(),
        cep: data['cep'].toString(),
        cidade: data['cidade'].toString());
    return address;
  }

  Customer getCustomer(String customerId) {
    var index = _customerListModel.indexWhere((c) => c.id == customerId);
    return _customerListModel[index];
  }
}
