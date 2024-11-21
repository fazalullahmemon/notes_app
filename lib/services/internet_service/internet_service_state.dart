import 'package:connectivity_plus/connectivity_plus.dart';

sealed class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {
  final List<ConnectivityResult> result;
  ConnectivityConnected(this.result);
}

class ConnectivityDisconnected extends ConnectivityState {}
