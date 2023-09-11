import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://';

  var token;

  getapiURL() {
    return _url;
  }


  postData(data, apiUrl) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    token = localStorage.getString('token');
    var fullUrl = _url + apiUrl;
    Uri url = Uri.parse(fullUrl);
    print(url.toString());
    return await http.post(url, body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    Uri url = Uri.parse(fullUrl);
    return await http.get(url, headers: _setHeaders());
  }


  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Connection': 'keep-alive',
      };
}
