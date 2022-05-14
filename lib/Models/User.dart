class UserModel {
  late String id;
  late String name;
  late String image;
  late String email;
  late String phone;
  late String address;
  late String cv;
  late String type;
  UserModel(
      {required this.id, required this.name, required this.image,required this.cv,required this.email ,required this.address, required this.phone,required this.type});

  UserModel.fromJson(Map <String, dynamic> map)
  {
    if (map == null) {
      return;
    }
    else {
      id = map['id'];
      name = map['name'];
      email = map['email'];
      phone= map['phone'];
      address= map['address'];
      type = map['type'];
      cv=map['cv'];
      image=map['image'];
    }
  }

  toJson()
  {
    return {
      'id':id,
      'name' : name,
      'email' : email,
      'phone' : phone,
      'address' : address,
      'type' : type,
      'cv':cv,
      'image':image,
    };
  }

}