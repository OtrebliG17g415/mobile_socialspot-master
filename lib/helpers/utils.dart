import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_spot/helpers/constants.dart';
import 'package:url_launcher/url_launcher.dart';

// Check Location Permissions
Future<bool> checkLocationPermission() async {
  var isLocGranted = await Permission.location.isGranted;
  if (!isLocGranted) Permission.location.request();
  if (isLocGranted) return true;
  return false;
}

class CheckConnect {
  final bool isConnected;
  final String? isConnectedTo;

  CheckConnect({
    required this.isConnected,
    this.isConnectedTo,
  });
}

Future<CheckConnect> utilsIsConnected() async {
  var isConnectedTo = await networkInfo.getWifiName();
  var isConnected = await InternetConnection().hasInternetAccess;
  if (isConnectedTo != null || !isConnected) {
    return CheckConnect(isConnected: isConnected, isConnectedTo: isConnectedTo);
  } else {
    return CheckConnect(isConnected: false);
  }
}

void utilsLaunchUrl(String url) async {
  var uri = Uri.parse(url);
  var canLaunch = await canLaunchUrl(uri);
  if (canLaunch) {
    launchUrl(uri);
  }
}

List<Widget> generateChoices(String type, List items) {
  switch (type) {
    case "checkbox":
      return List.from(
        items.map(
          (item) => Row(
            children: [
              Checkbox(value: false, onChanged: (newValue) {}),
              Text(item),
            ],
          ),
        ),
      );
    case "radiobox":
      return List.from(
        items.map(
          (item) => Row(
            children: [
              Radio(
                value: false,
                onChanged: (newValue) {},
                groupValue: null,
              ),
              Text(item),
            ],
          ),
        ),
      );
    default:
      return [];
  }
}
