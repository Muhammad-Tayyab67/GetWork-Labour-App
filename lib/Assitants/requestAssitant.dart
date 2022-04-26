// ignore: file_names
// ignore_for_file: non_constant_identifier_names, file_names, duplicate_ignore

import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssitant {
  static Future<dynamic> getRequest(String Url) async {
    // ignore: unused_local_variable
    http.Response response = await http.get(Uri.parse(Url));
    try {
      if (response.statusCode == 200) {
        String JsonData = response.body;
        var decode = jsonDecode(JsonData);
        return decode;
      } else {
        return "failed";
      }
    } catch (exp) {
      return "failed";
    }
  }
}
