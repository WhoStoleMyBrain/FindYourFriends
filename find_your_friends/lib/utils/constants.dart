import 'package:flutter/services.dart';

class Constants {
  //colors
  static const kPrimaryColor = Color(0xFFFFFFFF);
  static const kGreyColor = Color(0xFFEEEEEE);
  static const kBlackColor = Color(0xFF000000);
  static const kDarkGreyColor = Color(0xFF9E9E9E);
  static const kDarkBlueColor = Color(0xFF6057FF);
  static const kBorderColor = Color(0xFFEFEFEF);

  //text
  static const title = "Google Sign In";
  static const textIntro = "Growing your \n business is ";
  static const textIntroDesc1 = "easier \n ";
  static const textIntroDesc2 = "then you think!";
  static const textSmallSignUp = "Sign up takes only 2 minutes!";
  static const textSignIn = "Sign In";
  static const textSignUpBtn = "Sign Up";
  static const textStart = "Get Started";
  static const textSignInTitle = "Welcome back!";
  static const textRegister = "Register Below!";
  static const textSmallSignIn = "You've been missed!";
  static const textSignInGoogle = "Sign In With Google";
  static const textAcc = "Don't have an account? ";
  static const textSignUp = "Sign Up here";
  static const textSignUpAcc = "Already Have An Account? ";
  static const textSignInInstead = "Sign In Instead";
  static const textHome = "Home";
  static const textNoData = "No Data Available!";
  static const textFixIssues = "Please fill the data correctly!";
  static const textCreateGroup = "Create your own group!";
  static const textCreateGroupButton = "Create Group";

  //navigate
  static const signInNavigate = '/sign-in';
  static const signUpNavigate = '/sign-up';
  static const homeNavigate = '/home';

  static const statusBarColor = SystemUiOverlayStyle(
      statusBarColor: Constants.kPrimaryColor,
      statusBarIconBrightness: Brightness.dark);

  // firebase paths
  static const fbUserGroups = "UserGroups";
  static const fbGroupUsers = "GroupUsers";
  static const fbLocation = "location";
  static const fbUsers = "Users";
  static const fbGroups = "Groups";
  static const fbUsernames = "usernames";
  static const fbOldUsers = "users";
}
