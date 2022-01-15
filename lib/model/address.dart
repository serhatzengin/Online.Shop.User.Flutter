class AddressModel {
  late String name;
  late String phoneNumber;
  late String cFlatHomeNumber;
  late String city;
  late String state;
  late String postaCode;
  AddressModel({
    required this.name,
    required this.phoneNumber,
    required this.cFlatHomeNumber,
    required this.city,
    required this.state,
    required this.postaCode,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    cFlatHomeNumber = json['cFlatHomeNumber'];
    city = json['city'];
    state = json['state'];
    postaCode = json['postaCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['cFlatHomeNumber'] = cFlatHomeNumber;
    data['city'] = city;
    data['state'] = state;
    data['postaCode'] = postaCode;
    return data;
  }
}
