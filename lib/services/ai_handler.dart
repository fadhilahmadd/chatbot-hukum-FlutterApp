import 'dart:convert';
import 'package:http/http.dart' as http;

class AIHandler {
  Future<String> getResponse(String message) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/get'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'msg': message}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['answer'].trim();
      }

      return 'Terjadi kesalahan';
    } catch (e) {
      return 'Respon Buruk';
    }
  }
}
