class SaveUserResponse {
  bool? success;
  String? apiToken;

  SaveUserResponse({this.success, this.apiToken});

  SaveUserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    apiToken = json['api_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['api_token'] = this.apiToken;
    return data;
  }
}
