import 'package:connectivity_plus/connectivity_plus.dart';

/// Exposes a stream of network connectivity changes.
///
/// SOLID: Single Responsibility - Solely provides a stream for observing network state.
class NetworkStatusStream {
  final Connectivity _connectivity;

  NetworkStatusStream(this._connectivity);

  /// Stream of network state changes.
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((results) {
      return !results.contains(ConnectivityResult.none);
    });
  }
}
