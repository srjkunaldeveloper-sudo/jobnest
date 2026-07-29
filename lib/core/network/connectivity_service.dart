import 'package:connectivity_plus/connectivity_plus.dart';

/// Service to check current network connectivity status.
///
/// SOLID: Dependency Inversion - Relies on the Connectivity abstraction.
class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService(this._connectivity);

  /// Checks if the device is currently connected to any network.
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }
}
