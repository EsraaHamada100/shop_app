class LoginModel{
  late bool status;
  late String? message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'] ;
    message = json['message'];
    data = (json['data'] != null)?UserData.fromJson(json['data']):null;
  }
}

class UserData {
  // "id": 1696,
  // "name": "Esraa Mostfa",
  // "email": "esraa@gmail.com",
  // "phone": "01123314509",
  // "image": "https://student.valuxapps.com/storage/uploads/users/KXzucnAfWE_1625423845.jpeg",
  // "points": 79230,
  // "credit": 19807.5,
  // "token":
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late double credit;
  late String token;

  // named constructor .you can add it and add a normal constructor
  // in the same time

  UserData.fromJson(Map<String, dynamic> json){

    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'].toDouble();
    token = json['token'];
  }

}