import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account {
  @HiveField(0)
  String? key;

  @HiveField(1)
  String? type;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? password;

  @HiveField(5)
  bool? isSingle;

  @HiveField(6)
  bool? isFavorite;

  Account({
    this.key = "",
    this.type,
    this.name,
    this.email,
    this.password,
    this.isSingle = false,
    this.isFavorite,
  }) {
  
    if (this.isSingle ?? false) {
      this.email = "";
    }
  }

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      key: json['key'],
      type: json['type'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      isSingle: json['isSingle'],
      isFavorite: json['isFavorite']);

  Map<String, dynamic> toJson() => {
        'key': key,
        'type': type,
        'name': name,
        'email': email,
        'password': password,
        'isSingle': isSingle,
        'isFavorite': isFavorite
      };

  Account copyWith(
      {String? key,
      String? type,
      String? name,
      String? email,
      String? password,
      bool? isSingle,
      bool? isFavorite}) {
    return Account(
        key: key ?? this.key,
        type: type ?? this.type,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        isSingle: isSingle ?? this.isSingle,
        isFavorite: isFavorite ?? this.isFavorite);
  }
}
