const String fID = "ID";
const String fname = "Name";
const String femail = "Email";
const String fpassword = "Password";
const String fgender = "Gender";
const String fbirthDate = "Birthdate";
const String fdateCreated = "Datecreated";

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  int? gender;
  DateTime? birthDate;
  DateTime? dateCreated;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.gender,
    this.birthDate,
    this.dateCreated,
  });

  UserModel fromJson(Map<String, dynamic> json) => UserModel(
        id: json[fID],
        name: json[fname],
        email: json[femail],
        password: json[fpassword],
        gender: json[fgender],
        birthDate: json[fbirthDate],
      );

  Map<String, dynamic> get toJson => {
        fID: id,
        fname: name,
        femail: email,
        fpassword: password,
        fgender: gender,
        fbirthDate: birthDate,
      };
}
