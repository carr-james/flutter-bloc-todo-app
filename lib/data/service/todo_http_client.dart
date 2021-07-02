import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class TodoHttpClient {
  final baseUrl = "http://10.0.2.2:3000";

  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await get(Uri.parse(baseUrl + "/todos"))
          .timeout(const Duration(seconds: 2));
      return jsonDecode(response.body) as List;
    } on TimeoutException catch (e) {
      print('Timed out...');
      return Future.value([]);
    } catch (e) {
      print('Error: $e');
      return Future.value([]);
    }
  }

  Future<bool> patchTodo(int id, Map<String, String> patchObj) async {
    try {
      await patch(Uri.parse(baseUrl + "/todos/$id"))
          .timeout(const Duration(seconds: 2));
      return true;
    } on TimeoutException catch (e) {
      print('Timed out...');
      return Future.value(false);
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
