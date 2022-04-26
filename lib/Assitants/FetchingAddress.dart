// ignore_for_file: file_names, unnecessary_new

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:labour_app_wg/Models/address.dart';
import 'package:provider/provider.dart';

import '../Datahandler/appdata.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "Home AddressES";
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];

    placeAddress =
        "${place.street},${place.subLocality},${place.locality}, ${place.country}";

    Address pickupaddress = new Address();
    pickupaddress.latitude = position.latitude;
    pickupaddress.longitude = position.longitude;
    pickupaddress.placeName = placeAddress;
    Provider.of<AppData>(context, listen: false)
        .updatepicklocation(pickupaddress);

    return placeAddress;
  }
}
