import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_models_simple.dart';

/// Service for handling authentication-related API calls and token management.
class AuthService {
  final Dio _dio;
  static const String baseUrl = 'http://localhost:4000/api';

  AuthService()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        ));

  /// Registers a new user.
  Future<Map<String, dynamic>> signup(SignupRequest request) async {
    try {
      final response = await _dio.post('/auth/signup', data: request.toJson());
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'error': e.response?.data['message'] ?? "Erreur lors de l'inscription",
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Erreur inconnue: ${e.toString()}',
      };
    }
  }

  /// Verifies OTP and returns an AuthResponse if successful.
  Future<Map<String, dynamic>> verifyOtp(VerifyOtpRequest request) async {
    try {
      final response =
          await _dio.post('/auth/verify-otp', data: request.toJson());
      final authResponse = AuthResponse.fromJson(response.data);
      await _saveTokens(authResponse.accessToken, authResponse.refreshToken);
      return {
        'success': true,
        'data': authResponse,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'error': e.response?.data['message'] ?? 'Code OTP invalide',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Erreur inconnue: ${e.toString()}',
      };
    }
  }

  /// Signs in a user and returns an AuthResponse if successful.
  Future<Map<String, dynamic>> signin(SigninRequest request) async {
    try {
      final response = await _dio.post('/auth/signin', data: request.toJson());
      final authResponse = AuthResponse.fromJson(response.data);
      await _saveTokens(authResponse.accessToken, authResponse.refreshToken);
      return {
        'success': true,
        'data': authResponse,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'error':
            e.response?.data['message'] ?? 'Email ou mot de passe incorrect',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Erreur inconnue: ${e.toString()}',
      };
    }
  }

  /// Signs out the current user and clears tokens.
  Future<void> signout() async {
    try {
      final refreshToken = await _getRefreshToken();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await _dio.post('/auth/signout', data: {'refreshToken': refreshToken});
      }
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
    } finally {
      await _clearTokens();
    }
  }

  /// Refreshes the access token using the refresh token.
  Future<bool> refreshToken() async {
    try {
      final refreshToken = await _getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) return false;

      final response = await _dio.post('/auth/refresh', data: {
        'refreshToken': refreshToken,
      });

      final newAccessToken = response.data['accessToken'] as String?;
      final newRefreshToken = response.data['refreshToken'] as String?;

      if (newAccessToken == null || newRefreshToken == null) {
        print('Tokens manquants dans la réponse refresh');
        return false;
      }

      await _saveTokens(newAccessToken, newRefreshToken);
      return true;
    } catch (e) {
      print('Erreur refresh token: $e');
      return false;
    }
  }

  /// Checks if the user is currently logged in.
  Future<bool> isLoggedIn() async {
    final token = await _getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Gets the current authenticated user, or null if not available.
  Future<User?> getCurrentUser() async {
    try {
      final token = await _getAccessToken();
      if (token == null || token.isEmpty) return null;

      final response = await _dio.get('/auth/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return User.fromJson(response.data);
    } catch (e) {
      print('Erreur récupération utilisateur: $e');
      return null;
    }
  }

  // --- Private token management methods ---

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<String?> _getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  Future<void> _clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
}
