class LoginResponseModel {
  late final String token;
  late final String error;

  LoginResponseModel({required this.token, required this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        token: json["token"] != null ? json["token"] : "",
        error: json["error"] != null ? json["error"] : "");
  }
}

class LoginRequestModel {
  String id;
  String password;

  LoginRequestModel(
    this.id,
    this.password,
  );

  Map<String, String> toJson() {
    Map<String, String> map = {
      'username': this.id,
      'password': this.password,
    };
    return map;
  }
}
