import 'dart:convert';

import 'package:http/http.dart' as http;

class APICall {
  // AIzaSyC6yNtdqyNYlin0XHr0QXbKM94grrmWRto
  final apiBaseUri = "https://connectana.app/api";

  Future<dynamic> getRequest(String endPoint) async {
    var apiUrl = Uri.parse(apiBaseUri + endPoint);
    print("$apiBaseUri$endPoint");
    try {
      final apiResponse = await http.get(apiUrl);
      if (apiResponse.statusCode == 200) {
        final finalResponse = json.decode(apiResponse.body);
        print("decode ${json.decode(apiResponse.body)} ");
        return finalResponse;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> postRequest(String endPoint, dynamic postData) async {
    var apiUrl = Uri.parse(
      apiBaseUri + endPoint,
    );
    print("$apiBaseUri$endPoint");
    print(json.encode(postData));
    //encoded Data
    try {
      final apiResponse = await http.post(apiUrl,
          headers: {'Content-type': 'application/json'},
          body: json.encode(postData));
      // print("apiResponse $apiResponse");
      print("decode1234 ${json.decode(apiResponse.body)} ");
      final finalResponse = json.decode(apiResponse.body);
      return finalResponse;
    } catch (error) {
      print("Error12345 $error");
      throw error;
    }
  }
}
