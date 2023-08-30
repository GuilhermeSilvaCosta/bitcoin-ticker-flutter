import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

  Future<dynamic> getData(String url, Map<String, String> headers) async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

}