import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:notes_app/services/internet_service/internet_service_event.dart';
import 'package:notes_app/services/internet_service/internet_service_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;
  late Stream<List<ConnectivityResult>> _connectivityStream;

  ConnectivityBloc(this._connectivity) : super(ConnectivityInitial()) {
    // Listen to connectivity changes and emit new states
    _connectivityStream = _connectivity.onConnectivityChanged;

    on<ConnectivityCheckRequested>(_onCheckRequested);
    on<ConnectivityChanged>(_onConnectivityChanged);

    // Listen to the stream and add events
    _connectivityStream.listen((result) {
      add(ConnectivityChanged(result));
    });
  }

  Future<void> _onCheckRequested(
      ConnectivityCheckRequested event, Emitter<ConnectivityState> emit) async {
    final result = await _connectivity.checkConnectivity();

    if (result.contains(ConnectivityResult.none)) {
      emit(ConnectivityDisconnected());
    } else {
      emit(ConnectivityConnected(result));
    }
  }

  void _onConnectivityChanged(
      ConnectivityChanged event, Emitter<ConnectivityState> emit) {
    if (event.result.contains(ConnectivityResult.none)) {
      emit(ConnectivityDisconnected());
    } else {
      emit(ConnectivityConnected(event.result));
    }
  }
}
