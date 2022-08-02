class RegisterModel {
  late bool status;
  late String message;
  Data? data;

  RegisterModel({required this.status, required this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}

class Data {
  late String name;
  late String email;
  late String phone;
  late int id;
  late String image;
  late String token;

  Data({required this.name, required this.email, required this.phone, required this.id, required this.image, required this.token});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   data['email'] = this.email;
  //   data['phone'] = this.phone;
  //   data['id'] = this.id;
  //   data['image'] = this.image;
  //   data['token'] = this.token;
  //   return data;
  // }
}