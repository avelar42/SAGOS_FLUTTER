import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/service/api_status.dart';
import 'package:sagos_mobile/service/customer_service.dart';

class CustomerViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Customer> _customerListModel = [];

  CustomerViewModel() {
    getCustomers();
  }

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
      _customerListModel.add(Customer(
          nome: 'TESTE',
          sobrenome: 'sobrenome',
          telefone: 'telefone',
          cpf: 'cpf',
          dataNascimento: DateTime.now()));
      // _customerListModel.add(Customer(
      //     nome: customerValue['name'],
      //     cpf: customerValue['CPF'],
      //     dataNascimento: customerValue['dataNascimento'],
      //     sobrenome: customerValue['sobrenome'],
      //     telefone: customerValue['telefone']));
    });
  }

  getCustomers() async {
    setLoading(true);
    var response = await CustomerService.getCustomers();
    if (response is Success) {
      //Map<String, dynamic> data = jsonDecode(response);
      setCustomerListModel(response.response);
    }
    if (response is Failure) {
      print(response.errorResponse);
    }
    setLoading(false);
  }

  saveCustomer(Map<String, Object> data) async {
    //setLoading(true);
    final customer = Customer(
        nome: data['nome'] as String,
        sobrenome: data['sobrenome'] as String,
        cpf: data['CPF'] as String,
        telefone: data['telefone'] as String,
        dataNascimento: data['dataNascimento'] as DateTime);
    var response = await CustomerService.saveCustomerService(customer);
    //setLoading(false);
  }
}