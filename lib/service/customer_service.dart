import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/service/api_status.dart';

import '../utils/constants.dart';

class CustomerService {
  static Future<Object> getCustomers() async {
    try {
      var url = Uri.parse('${URL_BASE}/.json');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return Success(code: 200, response: data);
      } else {
        throw Exception();
      }
      //   return Failure(code: INVALID_RESPONSE, errorResponse: 'Invalid Response');
      // } on HttpException {
      //   return Failure(
      //       code: NO_INTERNET, errorResponse: 'No Internet Connection');
      // } on FormatException {
      //   return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Response');
    }
  }
}
