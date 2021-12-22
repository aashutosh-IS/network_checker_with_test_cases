import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  StreamSubscription<ConnectivityResult>? subscription;

  NetworkBloc() : super(NetworkInitial()) {
    on<NetworkEvent>((event, emit) {
      if (event is ListenConnection) {
        subscription = Connectivity().onConnectivityChanged.listen((status) {
          add(ConnectionChanged(status == ConnectivityResult.none
              ? ConnectionFailure()
              : ConnectionSuccess()));
        });
      }
      if (event is ConnectionChanged) {

        emit(event.connection);
      }
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
