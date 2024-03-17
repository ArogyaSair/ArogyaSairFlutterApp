// ignore_for_file: non_constant_identifier_names, file_names

class UserAskQuestionModel {
  late String password;
  late String UserId;

  UserAskQuestionModel(this.password, this.UserId);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'Question': password,
        'UserId': UserId,
      };

  factory UserAskQuestionModel.fromJson(Map<String, dynamic> v) {
    return UserAskQuestionModel(
      v["Question"],
      v["UserId"],
    );
  }
}
