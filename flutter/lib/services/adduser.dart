import 'package:app5/helper/api.dart';
import 'package:app5/models/usermodel.dart';

class Addusers {
  Future<User> adduser({
    required String? name,
    required String? email,
    required String? speicheal,
    required String? pharmecyName,
    required String? location,
    required String? number,
    required String? password,
    required String? confirmpassword,
  }) async {
    Map<String, dynamic> data =
        // ignore: missing_required_param
        await Api().post(url: 'http://10.0.2.2:8000/api/register', body: {
      'name': name,
      'number': number,
      'email': email,
      'speicheal': speicheal,
      'pharmecy_name': pharmecyName,
      'location': location,
      'password': password,
      
    });

    return User.fromJson(data);
  }
}
