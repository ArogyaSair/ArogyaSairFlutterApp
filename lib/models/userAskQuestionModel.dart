// ignore_for_file: non_constant_identifier_names, file_names

class UserAskQuestionModel {
  late String password;
  late String UserId;
  late String dateTime;

  UserAskQuestionModel(this.password, this.UserId, this.dateTime);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'Question': password,
        'UserId': UserId,
        'DateTime': dateTime,
      };

  factory UserAskQuestionModel.fromJson(Map<String, dynamic> v) {
    return UserAskQuestionModel(
      v["Question"],
      v["UserId"],
      v["DateTime"],
    );
  }
}
