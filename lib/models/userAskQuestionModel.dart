// ignore_for_file: non_constant_identifier_names, file_names

class UserAskQuestionModel {
  late String password;
  late String UserId;
  late String dateTime;
  late String Status;

  UserAskQuestionModel(this.password, this.UserId, this.dateTime, this.Status);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'Question': password,
        'UserId': UserId,
        'DateTime': dateTime,
        'Status': Status,
      };

  factory UserAskQuestionModel.fromJson(Map<String, dynamic> v) {
    return UserAskQuestionModel(
      v["Question"],
      v["UserId"],
      v["DateTime"],
      v["Status"],
    );
  }
}
