

import 'package:shopping/services/databaseHelper.dart';
import 'package:shopping/services/queries/userQueries.dart';

class UserController{
  final UserQueries userQueries = UserQueries();
  var client = DatabaseHelper.client.value;

  Future<bool> addUser(String name, String email, String psw, String tel)async {
    bool isAdded = false;
    var query = await client.mutate(
        userQueries.addUser(name, email, psw, tel));
    print(query);
    if(query.data!['insert_SP_user']['userId'] != null){
      isAdded = true;
    }

     print(query);
    return isAdded;
  }

}