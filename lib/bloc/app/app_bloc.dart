import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/app_repo.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository appRepo;
  AppBloc(this.appRepo) : super(AppLoadingState()) {
    on<LoadAppEvent>(
      (event, emit) async {
        emit(AppLoadedState());
      },
    );

    on<SendDataEvent>(
      (event, emit) async {
        emit(AppLoadingState());
        if (event.token != "") {
          try {
            await appRepo.sendSpecificUser(token: event.token!, title: event.title, body: event.body);
          } catch (e) {
            debugPrint(e.toString());
          }
        } else {
          try {
            await appRepo.sendNotificationToAllUsers(title: event.title, body: event.body);
          } catch (e) {
            debugPrint(e.toString());
          }
        }

        emit(AppLoadedState());
      },
    );
  }
}
