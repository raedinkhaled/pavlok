import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pavlok/models/userModel.dart';
import 'package:pavlok/utils/api_service.dart';

part 'user_state.dart';

// Events
abstract class UserEvent {}

class RegisterEvent extends UserEvent {
  final String email;
  final String password;

  RegisterEvent(this.email, this.password);
}

class LoginEvent extends UserEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class GetUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final String token;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final double? weight;
  final double? height;

  UpdateUserEvent({
    required this.token,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.weight,
    this.height,
  });
}

class LogoutEvent extends UserEvent {}

// Cubit
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());

  final ApiService _apiService = ApiService();

  Future<void> performUserAction(UserEvent event) async {
    try {
      emit(UserLoadingState());

      if (event is RegisterEvent) {
        final response =
            await _apiService.registerUser(event.email, event.password);
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (response.statusCode == 201 && responseBody.containsKey('user')) {
          final userJson = responseBody['user'];
          final user = User.fromJson(userJson);
          _apiService.saveUserData(user); // Save user data locally (if needed)
          emit(UserLoadedState(user)); // Emit success state
        } else {
          // Handle different types of errors (e.g., validation errors)
          emit(UserErrorState('Registration failed'));
        }
      } else if (event is LoginEvent) {
        final response =
            await _apiService.loginUser(event.email, event.password);
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (response.statusCode == 200 && responseBody.containsKey('user')) {
          final user = User.fromJson(responseBody['user']);
          _apiService.saveUserData(user); // Save user data locally
          emit(UserLoadedState(user));
        } else {
          emit(UserErrorState('Invalid response from server'));
        }
      } else if (event is GetUserEvent) {
        User? user = await _apiService.checkLoginStatus();
        final response = await _apiService.getUser(user!.token);
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (response.statusCode == 200 && responseBody.containsKey('user')) {
          final user = User.fromJson(responseBody['user']);
          _apiService.saveUserData(user); // Save user data locally
          emit(UserInfoLoadedState(user));
        } else {
          emit(UserErrorState('Invalid response from server'));
        }
      } else if (event is UpdateUserEvent) {
        final response = await _apiService.updateUser(
          event.token,
          username: event.username,
          email: event.email,
          firstName: event.firstName,
          lastName: event.lastName,
        );

        // Handle response
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (response.statusCode == 200 && responseBody.containsKey('user')) {
          final updatedUser = User.fromJson(responseBody['user']);
          _apiService
              .saveUserData(updatedUser); // Save updated user data locally
          emit(UserUpdatedState(updatedUser));
        } else {
          emit(UserErrorState('Invalid response from server'));
        }
      } else if (event is LogoutEvent) {
        _apiService.clearUserData(); // Clear user data locally
        emit(UserInitialState());
      }
    } catch (e) {
      emit(UserErrorState('Error: $e'));
    }
  }

  // Helper method to check login status
  Future<void> checkLoginStatus() async {
    final user = await _apiService.checkLoginStatus();
    if (user != null) {
      emit(UserLoadedState(user));
    } else {
      emit(UserInitialState());
    }
  }
}
