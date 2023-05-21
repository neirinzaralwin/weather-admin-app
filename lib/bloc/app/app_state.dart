import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {}

class AppLoadingState extends AppState {
  @override
  List<Object?> get props => [];
}

class AppLoadedState extends AppState {
  @override
  List<Object?> get props => [];
}

class AppErrorState extends AppState {
  final String error;
  AppErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
