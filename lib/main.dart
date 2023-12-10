import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/utils/routes.dart';
import 'package:integrapracas/views/change_user_data.dart';
import 'package:integrapracas/views/change_password.dart';
import 'package:integrapracas/views/select_comment_category.dart';
import 'package:integrapracas/views/home.dart';
import 'package:integrapracas/views/new_maintenance.dart';
import 'package:integrapracas/views/register.dart';
import 'package:integrapracas/views/new_event.dart';
import 'package:integrapracas/views/new_suggestion.dart';
import 'package:integrapracas/views/plaza_info.dart';
import 'package:integrapracas/views/login.dart';
import 'package:integrapracas/views/forgot_my_password.dart';
import 'package:integrapracas/views/user_comments.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF3D3129), //Marrom
        backgroundColor: Color(0xFFF5F1E0), //Bege
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0XFF7A9337)))),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF3D3129),
          titleTextStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      routes: {
        AppRoutes.LOGIN: (context) => LoginView(),
        AppRoutes.REGISTER: (context) => RegisterView(),
        AppRoutes.CHANGE_USER_DATA: (context) => ChangeUserDataView(),
        AppRoutes.FORGOT_MY_PASSWORD: (context) => ForgotMyPasswordView(),
        AppRoutes.CHANGE_PASSWORD: (context) => ChangePasswordView(),
        AppRoutes.HomeView: (context) => HomeView(),
        AppRoutes.PLAZA_INFO: (context) => PlazaInfoView(),
        AppRoutes.SELECT_CATEGORY: (context) => SelectCommentCategoryView(),
        AppRoutes.ADD_SUGGESTION: (context) => NewSuggestionView(),
        AppRoutes.ADD_EVENT: (context) => NewEventView(),
        AppRoutes.ADD_MAINTENANCE: (context) => NewMaintenanceView(),
        AppRoutes.USER_COMMENTS: (context) => UserCommentsView()
      },
    );
  }
}
