class Beneficiary {
  /// id[String]: Can be phone number for topUp
  String? id;

  /// nickName[String]: Name for representing number holder.
  String? nickName;

  Beneficiary({this.id, this.nickName});

  Beneficiary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickName = json['nickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nickName'] = nickName;
    return data;
  }
}
