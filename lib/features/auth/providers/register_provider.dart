import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:croptrack/features/auth/data/auth_repository.dart';

class RegisterNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  RegisterNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    state = const AsyncValue.loading();

    try {
      await _authRepository.registerUser(email, password, username);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

final registerProvider =
    StateNotifierProvider<RegisterNotifier, AsyncValue<void>>(
  (ref) => RegisterNotifier(ref.watch(authRepositoryProvider)),
);
