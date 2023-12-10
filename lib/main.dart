import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/themes/appcolors.dart';
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
        primaryColor: AppColors.brown,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.green))),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.brown,
          titleTextStyle: TextStyle(color: AppColors.white),
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        colorScheme: Theme.of(context).colorScheme.copyWith(background: AppColors.beige),
      ),
      routes: {
        AppRoutes.LOGIN: (context) => LoginView(),
        AppRoutes.REGISTER: (context) => RegisterView(),
        AppRoutes.CHANGE_USER_DATA: (context) => ChangeUserDataView(),
        AppRoutes.FORGOT_MY_PASSWORD: (context) => ForgotMyPasswordView(),
        AppRoutes.CHANGE_PASSWORD: (context) => ChangePasswordView(),
        AppRoutes.HOME_VIEW: (context) => HomeView(),
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
