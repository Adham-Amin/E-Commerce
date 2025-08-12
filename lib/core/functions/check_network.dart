import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> ckeckNetwork() async {
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());
  return connectivityResult.contains(ConnectivityResult.wifi) ||
      connectivityResult.contains(ConnectivityResult.mobile);
}
