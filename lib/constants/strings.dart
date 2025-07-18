import 'package:elbaraa/constants/app_theme.dart';
import 'package:flutter/cupertino.dart';


final URL = 'https://elbaraa.com/backend';
final baseUrl = URL+'/api';
final imagesUrls= URL+'/public/img/';
const characterDetailsScreen = '/character_details';

final singleTheme = AppTheme.values[0];

const ProductDetailsScreen = '/product_details';
const profileScreen = '/profile_screen';
const UsersScreen = '/users_screen';

const primaryColor = Color.fromRGBO(0, 197, 105, 1);
const greenPriceColor = Color.fromARGB(255, 18, 243, 138);

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;

const defaultBorderColor = Color.fromARGB(255, 226, 226, 226);

const kTextGreen = Color(0xFF1E8D4B);

const kDefaultIconColor = Color.fromARGB(255, 255, 54, 114);
const kLightIconColor = Color.fromARGB(255, 253, 137, 172);

const softTextOrange = Color.fromARGB(255, 245, 165, 90);

const defaultBackgroundColor = Color.fromARGB(255, 246, 246, 246);

const gradientColors = [
  Color.fromARGB(255, 255, 255, 255),
  Color.fromRGBO(0, 197, 105, 0.301),
  Color.fromRGBO(0, 197, 105, 1),
];


const String homeScreen = '/home_screen';
const String loginScreen = '/login_screen';
const String controlViewScreen = '/control_view';
const String cartScreen = '/cart_screen';
const String settingScreen = '/setting_screen';
const String editProfileScreen = '/edit_profile_screen';
const String productDetailsScreen = '/product_details_screen';
const String chatMessagesScreen = '/chat_messages_screen';
const String splashScreen = '/';
const String subscripToPlanScreen = '/subscrip_to_plan_screen';







final Map<double, String> timeOptions = {
  0.25: 'quarter_of_an_hour',
  0.333: 'third_of_an_hour',
  0.5: 'half_an_hour',
  0.666: 'one_hour_to_telt', // This looks like a typo, maybe 'one_hour_to_tell'?
  0.75: 'three_quarters_of_an_hour',
  1.0: 'one_hour', // It's good practice to use 1.0 for double keys
  1.25: 'one_and_quarter_hour',
  1.333: 'one_and_third_hour',
  1.5: 'one_and_half_hour',
  1.75: 'one_and_three_quarters_hour',
  2.0: 'two_hours',
  2.5: 'two_and_half_hours',
  3.0: 'three_hours',
};