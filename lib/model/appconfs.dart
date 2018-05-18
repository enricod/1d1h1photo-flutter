


class AppConfs {
  String appToken = '';
  String username;
  String email;

  AppConfs();

  AppConfs.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        appToken = json['appToken'],
        email = json['email'];


  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'appToken': appToken,
        'email': email
      };
}