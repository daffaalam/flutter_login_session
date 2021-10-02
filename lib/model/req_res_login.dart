import 'dart:convert';

class ReqResLogin {
  String? token;
  String? error;

  ReqResLogin({
    this.token = "",
    this.error = "",
  });

  factory ReqResLogin.fromJson(String str) {
    return ReqResLogin.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ReqResLogin.fromMap(Map<String, dynamic> json) {
    return ReqResLogin(
      token: json["token"],
      error: json["error"],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "token": token,
      "error": error,
    };
  }
}
