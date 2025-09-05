import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:wifi_iot/wifi_iot.dart'; // ✅ Pour la connexion réelle

final wifiProvider = StateNotifierProvider<WifiNotifier, WifiState>((ref) {
  return WifiNotifier();
});

class WifiState {
  final List<WiFiAccessPoint> availableNetworks;
  final bool isLoading;
  final String? error;
  final String? connectedSSID;

  WifiState({
    this.availableNetworks = const [],
    this.isLoading = false,
    this.error,
    this.connectedSSID,
  });
}

class WifiNotifier extends StateNotifier<WifiState> {
  WifiNotifier() : super(WifiState());

  Future<void> loadWifiNetworks() async {
    state = WifiState(isLoading: true, error: null);

    try {
      final canScan = await WiFiScan.instance.canStartScan();
      if (canScan != CanStartScan.yes) {
        state =
            WifiState(error: "Scanning WiFi non supporté", isLoading: false);
        return;
      }

      final result = await WiFiScan.instance.startScan();
      if (result != true) {
        state = WifiState(error: "Échec du scan WiFi", isLoading: false);
        return;
      }

      final networks = await WiFiScan.instance.getScannedResults();
      final currentSSID = await WiFiForIoTPlugin.getSSID();

      state = WifiState(
        availableNetworks: networks,
        connectedSSID: currentSSID,
        isLoading: false,
      );
    } catch (e) {
      state = WifiState(error: "Erreur: ${e.toString()}", isLoading: false);
    }
  }

  Future<bool> connectToNetwork(String ssid, String password) async {
    try {
      // ✅ CONNEXION RÉELLE avec wifi_iot
      return await WiFiForIoTPlugin.connect(
        ssid,
        password: password,
        security: NetworkSecurity.WPA, // Adaptez selon le réseau
        joinOnce: false,
      );
    } catch (e) {
      print("Erreur connexion: $e");
      return false;
    }
  }
}
