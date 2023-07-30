import 'package:http/http.dart' as http;

postData() async{
  var response= http.post(Uri.parse("http://172.16.2.222:8080/bitrupee/api/wutxo/1"),
  body:{"_id":1});
  print(response.body);
}