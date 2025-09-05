import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:social_spot/models/auth_models_simple.dart';
import 'package:social_spot/services/auth.service.dart';
import 'dart:convert';
import 'package:dio/dio.dart'; // Only for error extraction
import 'package:social_spot/models/auth_models_simple.dart';

// AuthState: Represents the authentication state for the app

sealed class AuthState {
  const AuthState();
  const factory AuthState.initial() = InitialState;
  const factory AuthState.loading() = LoadingState;
  const factory AuthState.authenticated({
    required String accessToken,
    required String refreshToken,
    required User? user,
  }) = AuthenticatedState;
  const factory AuthState.unauthenticated() = UnauthenticatedState;
  const factory AuthState.error(String message) = ErrorState;
}

class InitialState extends AuthState {
  const InitialState();
}

class LoadingState extends AuthState {
  const LoadingState();
}

class AuthenticatedState extends AuthState {
  final String accessToken;
  final String refreshToken;
  final User? user;
  const AuthenticatedState({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
}

class UnauthenticatedState extends AuthState {
  const UnauthenticatedState();
}

class ErrorState extends AuthState {
  final String message;
  const ErrorState(this.message);
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthNotifier(this.authService) : super(const AuthState.initial()) {
    loadAuthState();
  }

  // Loads authentication state from local storage
  Future<void> loadAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? '';
      final refreshToken = prefs.getString('refresh_token') ?? '';
      final userJson = prefs.getString('user');
      User? user;
      if (userJson != null) {
        user = User.fromJson(jsonDecode(userJson));
      }
      if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
        state = AuthState.authenticated(
          accessToken: accessToken,
          refreshToken: refreshToken,
          user: user,
        );
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = const AuthState.unauthenticated();
    }
  }

  // Handles user signup
  Future<void> signup(SignupRequest request) async {
    try {
      state = const AuthState.loading();
      final response = await authService.signup(request);
      if (response['success'] == true) {
        state = const AuthState.unauthenticated();
      } else {
        throw Exception(response['error'] ?? "Erreur lors de l'inscription");
      }
    } catch (e) {
      state = AuthState.error(_extractErrorMessage(e));
    }
  }

  // Handles OTP verification
  Future<void> verifyOtp(VerifyOtpRequest request) async {
    try {
      state = const AuthState.loading();
      final response = await authService.verifyOtp(request);
      if (response['success'] == true) {
        state = const AuthState.unauthenticated();
      } else {
        throw Exception(response['error'] ?? 'Code OTP invalide');
      }
    } catch (e) {
      state = AuthState.error(_extractErrorMessage(e));
    }
  }

  // Handles user sign-in
  Future<void> signin(SigninRequest request) async {
    try {
      state = const AuthState.loading();
      final response = await authService.signin(request);
      if (response['success'] == true && response['data'] is AuthResponse) {
        final authResponse = response['data'] as AuthResponse;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', authResponse.accessToken);
        await prefs.setString('refresh_token', authResponse.refreshToken);
        await prefs.setString('user', jsonEncode(authResponse.user.toJson()));
        state = AuthState.authenticated(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
          user: authResponse.user,
        );
      } else {
        throw Exception(response['error'] ?? 'Format de réponse invalide');
      }
    } catch (e) {
      state = AuthState.error(_extractErrorMessage(e));
    }
  }

  // Handles user logout
  Future<void> logout() async {
    try {
      final currentState = state;
      if (currentState is AuthenticatedState) {
        await authService.signout();
      }
    } catch (_) {
      // Ignore errors on signout
    } finally {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      state = const AuthState.unauthenticated();
    }
  }

  // Handles token refresh
  Future<void> refreshTokenAction() async {
    try {
      final currentState = state;
      if (currentState is AuthenticatedState) {
        final success = await authService.refreshToken();
        if (success) {
          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('access_token') ?? '';
          final refreshToken = prefs.getString('refresh_token') ?? '';
          final userJson = prefs.getString('user');
          User? user;
          if (userJson != null) {
            user = User.fromJson(jsonDecode(userJson));
          }
          state = AuthState.authenticated(
            accessToken: accessToken,
            refreshToken: refreshToken,
            user: user,
          );
        }
      }
    } catch (_) {
      await logout();
    }
  }

  // Extracts error messages from Dio or generic errors
  String _extractErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.response?.data is Map) {
        return error.response?.data['message'] ?? 'Erreur de connexion';
      }
      return error.message ?? 'Erreur de connexion';
    }
    return error.toString();
  }
}

// Riverpod provider for AuthNotifier
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = AuthService();
  return AuthNotifier(authService);
});
