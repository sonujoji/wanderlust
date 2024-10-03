import 'package:hive/hive.dart';
import 'package:wanderlust/models/user.dart';

class UserService {
  Box<User>? _userBox;

  Future<void> openBox() async {
    _userBox = await Hive.openBox('UserBox');
  }

  Future<void> closeBox() async {
    await _userBox!.close();
  }

  Future<void> addUser(User user) async {
    if (_userBox == null) {
      await openBox();
    }
    await _userBox!.add(user);
  }

  Future<List<User>> getUserData() async {
    if (_userBox == null) {
      await openBox();
    }
    return _userBox!.values.toList();
  }

  Future<void> updateUser(int index, User user) async {
    if (_userBox == null) {
      await openBox();
    }
    await _userBox!.putAt(index, user);
  }

  Future<void> deleteUser(int index) async {
    if (_userBox == null) {
      await openBox();
    }
    await _userBox!.deleteAt(index);
  }

  // Future<void> getUserByIndex(int index) async {
  //   if (_userBox == null) {
  //     await openBox();
  //   }
  //   if (index >= 0 && index < _userBox!.length) {
  //     await _userBox!.getAt(index);
  //   }
  // }
}
