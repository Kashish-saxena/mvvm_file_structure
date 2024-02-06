import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DeleteApiService {
  Future<bool> deleteUser(int userId) async {
    try {
      Response response = await http.delete(
        Uri.parse('https://gorest.co.in/public/v2/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer a9a486e9e05ae8f3998761fba962fa5c8bdfd58b227d425373b4566717afd33c',
        },
      );
      if (response.statusCode == 204) {
        log('User deleted successfully');
        return true;
      } else {
        log('Error response: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error in deleting user $e');
      return false;
    }
  }
}
