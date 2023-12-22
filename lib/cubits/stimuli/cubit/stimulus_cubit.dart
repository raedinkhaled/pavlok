import 'dart:convert';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pavlok/models/stimulusModel.dart';
import 'package:pavlok/models/userModel.dart';
import 'package:pavlok/utils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'stimulus_state.dart';

abstract class StimulusEvent {}

class FetchStimuliEvent extends StimulusEvent {}

class CreateStimulusEvent extends StimulusEvent {
  final String type;
  final int value;
  final String reason;
  final String token;

  CreateStimulusEvent(this.token, this.type, this.value, this.reason);
}

class StimulusCubit extends Cubit<StimulusState> {
  final ApiService apiService = ApiService();

  StimulusCubit() : super(StimulusInitial());

  Future<void> performStimuliAction(StimulusEvent event) async {
    try {
      emit(StimulusLoading());
      if (event is FetchStimuliEvent) {
        User? loggedUser = await apiService.checkLoginStatus();
        if (loggedUser?.token != null) {
          // Check for null
          print(loggedUser!.token);
        } else {
          print("token is coming NULL");
        }

        final response = await apiService.listAllStimuli(loggedUser!.token);
        print(json.decode(response.body));
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (response.statusCode == 200 &&
            responseBody.containsKey('stimulusList')) {
          final List<dynamic> stimulusJsonList = responseBody['stimulusList'];
          final stimulusList =
              stimulusJsonList.map((json) => Stimulus.fromJson(json)).toList();

          print(stimulusList.length);
          emit(StimulusLoaded(stimulusList));
          print('State Loaded was emitted');
        } else {
          emit(StimulusError('Failed to fetch stimuli'));
        }
      } /*else if (event is CreateStimulusEvent) {
        final response = await apiService.createStimulus(
            event.type, event.value, event.token, event.reason);
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (response.statusCode == 201 &&
            responseBody.containsKey('stimulus')) {
          final stimulusCreated = responseBody['stimulus'];
          final stimulus = Stimulus.fromJson(stimulusCreated);
          emit(StimulusCreated(stimulus));
        }
      } */
    } catch (e) {
      emit(StimulusError('Error: $e'));
      print('Here the error was thrown');
    }
  }

  Future<void> createStimulus(String type, int value, String reason) async {
    emit(StimulusInitial());
    try {
      print('Entered this bloc');
      User? loggedUser = await apiService.checkLoginStatus();
      print('Success 1');
      if (loggedUser?.token != null) {
        final response = await apiService.createStimulus(
            type, value, loggedUser!.token, reason);
        print('Success 2');
        print(response.body);
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (response.statusCode == 200 &&
            responseBody.containsKey('stimulus')) {
          final stimulusCreated = responseBody['stimulus'];
          final stimulus = Stimulus.fromJson(stimulusCreated);
          emit(StimulusCreated(stimulus));
          print('The state Created was emitted');
        } else {
          if (responseBody.containsKey('errors')) {
            var messageError = responseBody['errors'][0];
            if (messageError is String) {
              emit(StimulusError(messageError));
            } else if (messageError.containsKey('msg')) {
              emit(StimulusError(messageError['msg']));
            }
          }
        }
      } else {
        emit(StimulusError('Error: Token wass null'));
        print('Here the error was thrown upon creation');
      }
    } catch (e) {
      emit(StimulusError('Error: $e'));
    }
  }
}
