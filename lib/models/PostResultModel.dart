part of 'Models.dart';

class PostResult {
  String id;
  String name;
  String job;

  PostResult({this.id, this.name, this.job});

  factory PostResult.createPostResult(Map<String, dynamic> json) {
    return PostResult(id: json['id'], name: json['name'], job: json['job']);
  }

  static Future<PostResult> connectToAPI(String name, String job) async {
    String apiUrl = "https://reqres.in/api/users";

    var apuResult = await http.post(apiUrl, body: {"name": name, "job": job});

    var jsonObject = json.decode(apuResult.body);

    return PostResult.createPostResult(jsonObject);
  }
}

class GetResult {
  String email;
  String name;

  GetResult({this.email, this.name});

  factory GetResult.createUser(Map<String, dynamic> json) {
    return GetResult(email: json['email'], name: json['first_name']);
  }

  static Future<GetResult> connectAPI(String id) async {
    String apiURL = 'https://reqres.in/api/users/' + id;

    var apiResult = await http.get(apiURL);

    var jsonObject = json.decode(apiResult.body);

    var userData = (jsonObject as Map<String, dynamic>)['data'];

    return GetResult.createUser(userData);
  }
}
