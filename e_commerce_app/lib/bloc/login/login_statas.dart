abstract class UserLoginStates {}

class UserLoginIntialState extends UserLoginStates {}

class UserLoginLoadingState extends UserLoginStates {}

class UserLoginSuccessState extends UserLoginStates {}

class UserLoginErrorState extends UserLoginStates {
  final String errorMessage;
  UserLoginErrorState({this.errorMessage});
}
