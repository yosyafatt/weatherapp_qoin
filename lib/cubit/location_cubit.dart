import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<Placemark> {
  LocationCubit() : super(null);

  void getLocation() async {
    final co = await determineLocation();
    if (co is Position) {
      final ps = await getAddress(co.latitude, co.longitude);
      emit(ps.first);
    }
  }
}

class CoordinateCubit extends Cubit<Position> {
  CoordinateCubit() : super(null);

  void getCoordinates() async => emit(await determineLocation());
}

Future<Position> determineLocation() async {
  bool serviceEnabled;
  LocationPermission lp;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // print('disabled');
    return Future.error('Location services are disabled');
  }
  lp = await Geolocator.checkPermission();
  if (lp == LocationPermission.deniedForever) {
    // print('deniedForever');
    return Future.error('Location permission is permanently denied :(');
  }

  if (lp == LocationPermission.denied) {
    lp = await Geolocator.requestPermission();
    if (lp != LocationPermission.whileInUse &&
        lp != LocationPermission.always) {
      // print('denied');
      return Future.error('Location permission are denied : $lp');
    }
  }
  final cp = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.lowest);
  return cp;
}

Future<Position> lastKnownLocation() async {
  final lk = await Geolocator.getLastKnownPosition();
  return lk;
}

Future<List<Placemark>> getAddress(double latitude, double longitude) async {
  final place = await placemarkFromCoordinates(latitude, longitude);
  return place;
}
