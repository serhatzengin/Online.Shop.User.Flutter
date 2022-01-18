class AddressModel {
  String? name;
  String? phoneNumber;
  String? flatNumber;
  String? city;
  String? state;
  String? postaCode;
  AddressModel({
    required this.name,
    required this.phoneNumber,
    required this.flatNumber,
    required this.city,
    required this.state,
    required this.postaCode,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    flatNumber = json['flatNumber'];
    city = json['city'];
    state = json['state'];
    postaCode = json['postaCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['flatNumber'] = flatNumber;
    data['city'] = city;
    data['state'] = state;
    data['postaCode'] = postaCode;
    return data;
  }
}
