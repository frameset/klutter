class Server {
  String name;
  String url;
  String username;
  String password;
  String key;

  Server({
    required this.name,
    required this.url,
    required this.password,
    required this.username,
    required this.key,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
        name: json['name'] as String,
        url: json['url'] as String,
        username: json['username'] as String,
        password: json['password'] as String,
        key: json['key'] as String);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name.toString();
    data['url'] = this.url.toString();
    data['username'] = this.username.toString();
    data['password'] = this.password.toString();
    data['key'] = this.key.toString();
    return data;
  }
}
