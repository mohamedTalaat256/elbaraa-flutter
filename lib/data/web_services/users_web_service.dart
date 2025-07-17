import 'package:dio/dio.dart';
import 'package:elbaraa/utils/dio_client/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UsersWebService {

late Dio dio;
late SharedPreferences sharedPreferences;

  UsersWebService(){
     dio = DioClient().instance;
  }


  


/*   Future<List> getChatMessages(String secondPersonId) async{
    sharedPreferences = await SharedPreferences.getInstance();
    int? userId = await sharedPreferences.getInt("userid");

    print('sender_id: '+userId.toString());
     try {
      Response response = await dio.get('/messages?user_id=' + userId.toString()+'&second_person_id='+secondPersonId);
     
     
     
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  } */

  Future<List> getUsers() async{
     int? userId = await sharedPreferences.getInt("userid"); 
     try {

      Response response = await dio.get('/users?user_id=${userId}');
      return response.data['data'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}