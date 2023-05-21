import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class LoadAppEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class SendDataEvent extends AppEvent {
  final String? token;
  final String title;
  final String body;
  const SendDataEvent({this.token = "", required this.title, required this.body});
  @override
  List<Object?> get props => [token, title, body];
}
