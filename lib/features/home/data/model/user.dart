///
/// Profile Model Contain.
/// 1. name: `String` profile or nickName -.
/// 2. totalBalance: `double` Total available Balance in wallet - default `0.0`.
/// 3. accountStatus: `bool` indicate is account is verified - default `true`.
/// 4. id: `String` is register phone number.
///
class User {
  String? id;
  String? name;
  double? totalBalance;
  bool? accountStatus;

  User({
    this.id,
    this.name,
    this.totalBalance,
    this.accountStatus,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalBalance = json['totalBalance'] ?? 0.0;
    accountStatus = json['accountStatus'] ?? true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['totalBalance'] = totalBalance;
    data['accountStatus'] = accountStatus;
    return data;
  }
}
