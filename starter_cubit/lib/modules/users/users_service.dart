import 'package:starter_cubit/data/network/api.dart';
import 'package:starter_cubit/models/user.dart';

class UsersService {
  Future<List<User>?> fetch([String? query, int? page]) async {
    try {
      final res = await Api.users(query, page);

      if (res is Map && res.containsKey('data')) {
        final data = res['data'];

        if (data is List) {
          return data.map<User>((u) => User.fromJson(u)).toList();
        }
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}
