import 'dart:convert';

class ReqResLogin {
  String token;
  String error;

  ReqResLogin({
    this.token,
    this.error,
  });

  factory ReqResLogin.fromJson(String str) => ReqResLogin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReqResLogin.fromMap(Map<String, dynamic> json) => ReqResLogin(
    token: json["token"],
    error: json["error"],
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "error": error,
  };
}
