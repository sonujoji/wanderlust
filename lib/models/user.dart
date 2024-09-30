import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String password;

  @HiveField(3)
  late int phone;

  @HiveField(4)
  late String? profileImage;

  User({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    this.profileImage,
  });
}
