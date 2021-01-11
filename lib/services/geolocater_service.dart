import 'package:geolocator/geolocator.dart';

class GeolocaterService {
  Future<Position> getlocation() async {
    var geolocator = Geolocator();
    return await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        locationPermissionLevel: GeolocationPermission.location);
  }
}
