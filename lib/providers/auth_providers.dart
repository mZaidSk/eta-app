import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

// Auth Service
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Auth State
class AuthState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? profile;

  const AuthState({this.isLoading = false, this.error, this.profile});

  AuthState copyWith(
      {bool? isLoading, String? error, Map<String, dynamic>? profile}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      profile: profile ?? this.profile,
    );
  }
}

// Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService service;
  AuthNotifier(this.service) : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    final success = await service.login(email, password);
    if (success) {
      await loadProfile();
    } else {
      state = state.copyWith(isLoading: false, error: "Login failed");
    }
  }

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, error: null);
    final profile = await service.getProfile();
    if (profile != null) {
      state = state.copyWith(isLoading: false, profile: profile);
    } else {
      state = state.copyWith(isLoading: false, error: "Profile error");
    }
  }

  Future<void> logout() async {
    await service.logout();
    state = const AuthState();
  }
}

// Provider
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final service = ref.read(authServiceProvider);
  return AuthNotifier(service);
});
