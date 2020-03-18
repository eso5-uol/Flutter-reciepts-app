

class User {
  final String uid;
  final String email;
  final String fullName;
  final String managerId;


  User({this.uid, this.email, this.fullName, this.managerId});

  User.fromData(Map<String, dynamic> data):
      uid = data['uid'], email= data['email'], fullName = data['fullName'], managerId = data['managerId'];

  Map<String, dynamic> toJson(){
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'managerId': managerId,
    };
  }
  
}