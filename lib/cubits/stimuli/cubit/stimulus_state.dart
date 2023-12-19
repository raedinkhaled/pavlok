part of 'stimulus_cubit.dart';

abstract class StimulusState extends Equatable {
  @override
  List<Object> get props => [];
}

class StimulusInitial extends StimulusState {}

class StimulusLoading extends StimulusState {}

class StimulusLoaded extends StimulusState {
  final List<Stimulus> stimulusList;

  StimulusLoaded(this.stimulusList);

  @override
  List<Object> get props => [stimulusList];
}

class StimulusCreated extends StimulusState {
  final Stimulus stimulus;

  StimulusCreated(this.stimulus);

  @override
  List<Object> get props => [stimulus];
}

class StimulusError extends StimulusState {
  final String message;

  StimulusError(this.message);

  @override
  List<Object> get props => [message];
}
