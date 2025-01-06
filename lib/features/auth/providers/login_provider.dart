import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:croptrack/features/auth/data/auth_repository.dart';

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  LoginNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      await _authRepository.loginUser(email, password);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<void>>(
  (ref) => LoginNotifier(ref.watch(authRepositoryProvider)),
);
