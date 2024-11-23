import 'dart:async';

import 'package:app5/helper/api.dart';
import 'package:app5/models/loginmodel.dart';

class Loginservice {
  Future<Login> loginservic({
    String? token,
    required String number,
    required String password,
  }) async {
    Map<String, dynamic> data =
        // ignore: missing_required_param
        await Api().post(url: 'http://10.0.2.2:8000/api/login', body: {
      'number': number,
      'password': password,
    });
    
    return Login.fromJson(data);
  }
}
