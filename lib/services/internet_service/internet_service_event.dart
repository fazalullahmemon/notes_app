import 'package:connectivity_plus/connectivity_plus.dart';

sealed class ConnectivityEvent {}

class ConnectivityCheckRequested extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final List<ConnectivityResult> result;
  ConnectivityChanged(this.result);
}
