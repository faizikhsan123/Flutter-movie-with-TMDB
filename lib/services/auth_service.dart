import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';
import 'storage_keys.dart';

class AuthService {
  final GetStorage _box = GetStorage();

  List<UserModel> _getAllUsers() {
    final List? raw = _box.read(StorageKeys.users);
    if (raw == null) return [];
    return raw
        .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> _saveAllUsers(List<UserModel> users) async {
    final raw = users.map((u) => u.toJson()).toList();
    await _box.write(StorageKeys.users, raw);
  }

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final users = _getAllUsers();

    final emailExists = users.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );
    if (emailExists) {
      return 'Email is already registered';
    }

    final newUser = UserModel(name: name, email: email, password: password);
    users.add(newUser);
    await _saveAllUsers(users);

    return null;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final users = _getAllUsers();

    final user = users.firstWhereOrNull(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );

    if (user == null) {
      return 'Email not found, please register first';
    }
    if (user.password != password) {
      return 'Incorrect password';
    }

    await _box.write(StorageKeys.currentUser, user.toJson());
    await _box.write(StorageKeys.isLoggedIn, true);

    return null;
  }

  Future<void> logout() async {
    await _box.write(StorageKeys.isLoggedIn, false);
    await _box.remove(StorageKeys.currentUser);
  }

  bool isLoggedIn() {
    return _box.read(StorageKeys.isLoggedIn) ?? false;
  }

  UserModel? getCurrentUser() {
    final raw = _box.read(StorageKeys.currentUser);
    if (raw == null) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(raw));
  }
}

extension _FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
