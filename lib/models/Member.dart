class Member {
  String id;
  String username;
  String email;
  String password;
  String number;
  String country;
  int balance;
  String active;
  int iV;

  Member(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.number,
      this.country,
      this.balance,
      this.active,
      this.iV});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    number = json['number'];
    country = json['country'];
    balance = json['balance'];
    active = json['active'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['number'] = this.number;
    data['country'] = this.country;
    data['balance'] = this.balance;
    data['active'] = this.active;
    data['__v'] = this.iV;
    return data;
  }
}
