import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestResult {
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

const PROTOCOL = 'http';
//const DOMAIN = '192.168.188.85:8000';
const DOMAIN = '192.168.178.37:8000';

Future<RequestResult> http_get(String route, [dynamic data]) async {
  var dataStr = jsonEncode(data);
  var url = "$PROTOCOL://$DOMAIN/$route?data=$dataStr";
  var result = await http.get(Uri.parse(url));
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_post(String route, [dynamic data]) async {
  var dataStr = jsonEncode(data);
  var url = "$PROTOCOL://$DOMAIN/$route";
  var result = await http.post(Uri.parse(url),
      body: dataStr, headers: {"Content-Type": "application/json"});
  return RequestResult(true, jsonDecode(result.body));
}
