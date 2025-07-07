import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:labor_management_system/core/extensions/logs/log_ext.dart';

class GeoLocatorService {
  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  /// [latitude] device latitude
  double? latitude;

  /// [longitude] device longitude
  double? longitude;

  /// [Timer] to check location service status
  Timer? _locationServiceStatusTimer;

  /// [Timer] to check location service status on start
  Timer? _locationServiceStatusCheckTimer;

  /// [Position] stream subscription
  StreamSubscription<Position>? _positionStream;

  /// [locationServiceStatusStream] stream to get location service status
  final StreamController<bool> _locationServiceStatusController =
      StreamController<bool>.broadcast();

  /// [_locationServiceStatusCheckController] stream to check location service status on start
  final StreamController<bool> _locationServiceStatusCheckController =
      StreamController<bool>.broadcast();

  /* -------------------------------------------------------------------------- */
  /*                                  GETTERS                                   */
  /* -------------------------------------------------------------------------- */

  /// Get the location
  String get location => 'Latitude: $latitude, Longitude: $longitude';

  /// [locationServiceStatusCheckStream] stream to get location service status on start
  Stream<bool> get locationServiceStatusStream =>
      _locationServiceStatusController.stream;

  /// [locationServiceStatusCheckStream] stream to check location service status on start
  Stream<bool> get locationServiceStatusCheckStream =>
      _locationServiceStatusCheckController.stream;

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  /// Requests location permission from the user.
  ///
  /// This method first checks the current location permission status using
  /// [Geolocator.checkPermission]. If the permission is either denied or
  /// denied forever, it will request the permission using
  /// [Geolocator.requestPermission].
  ///
  /// Returns a [Future] that completes with the [LocationPermission] status.
  Future<LocationPermission> requestPermission() async {
    // check permission
    LocationPermission permission = await Geolocator.checkPermission();

    // if permission is denied or denied forever, request permission
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // request permission
      permission = await Geolocator.requestPermission();
    }
    // return permission
    return permission;
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Calculates the distance between two geographical points.
  ///
  /// This method uses the `Geolocator.distanceBetween` function to compute the
  /// distance between the start and end coordinates. If the start coordinates
  /// are not provided, it defaults to `latitude` and `longitude` or `0.0`.
  ///
  /// The distance is logged and then returned.
  ///
  Future<double> getDistanceBetweenTwoPoints({
    double? startLatitude,
    double? startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    final distance = Geolocator.distanceBetween(
      startLatitude ?? latitude ?? 0.0,
      startLongitude ?? longitude ?? 0.0,
      endLatitude,
      endLongitude,
    );
    'Distance Between Points $distance'.logs();
    return distance;
  }

  /// Stream to check location service status on start
  /// Starts a periodic timer that checks the status of the location service every 2 seconds.
  /// If the location service status check controller is closed, the timer is canceled.
  /// Otherwise, it checks if the location service is enabled and adds the status to the controller.
  /// Otherwise, it adds the current status of the location service (enabled or disabled) to the controller.
  /// If the location service status stream controller is closed, the timer is canceled.
  /// Otherwise, it adds the current status of the location service (enabled or disabled) to the stream.
  void startLocationServiceStatusListener() {
    _locationServiceStatusTimer = Timer.periodic(const Duration(seconds: 2), (
      timer,
    ) async {
      if (_locationServiceStatusController.isClosed) {
        timer.cancel();
        return;
      }
      final isEnabled = await isLocationServiceEnabled();
      _locationServiceStatusController.add(isEnabled);
    });
  }

  // Stream to check location service status

  void startLocationServiceStatusCheckListener() {
    _locationServiceStatusCheckTimer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) async {
        if (_locationServiceStatusCheckController.isClosed) {
          timer.cancel();
          return;
        }
        final isEnabled = await isLocationServiceEnabled();
        _locationServiceStatusCheckController.add(isEnabled);
      },
    );
  }

  /// Initializes the location service and retrieves the current position.
  ///
  /// This method attempts to get the current position of the device with high accuracy.
  /// If successful, it updates the latitude and longitude properties and starts listening
  /// to the position stream. In case of an error, it logs the error and returns null.
  ///
  /// Returns a [Future] that completes with the current [Position] or null if an error occurs.
  Future<Position?> initializeLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      latitude = position.latitude;
      longitude = position.longitude;
      listenPositionStream();
      return position;
    } catch (e) {
      'Error getting location: $e'.logError();
      return null;
    }
  }

  /// Listens to the position stream and updates the latitude and longitude
  /// properties with the current position.
  ///
  /// This method subscribes to the position stream using the `getPositionStream`
  /// method and listens for position updates. When a new position is received,
  /// it updates the `latitude` and `longitude` properties with the current
  /// position's latitude and longitude, respectively. It also logs the updated
  /// latitude and longitude values.
  void listenPositionStream() {
    _positionStream = getPositionStream().listen((Position position) {
      latitude = position.latitude;
      longitude = position.longitude;
      'Updated lat and Long $latitude,$longitude'.logs();
    });
  }

  /// Returns a stream of [Position] objects representing the device's location.
  ///
  /// The [accuracy] parameter specifies the desired accuracy of the location
  /// data. The default value is [LocationAccuracy.high].
  ///
  /// The stream will emit a new [Position] object whenever the device's location
  /// changes by at least 5 meters.
  ///
  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: accuracy, distanceFilter: 5),
    );
  }

  void dispose() {
    _positionStream?.cancel();
    _locationServiceStatusTimer?.cancel();
    if (!_locationServiceStatusController.isClosed) {
      _locationServiceStatusController.close();
    }
  }

  /// Disposes the location service status listener by cancelling the timer
  /// and closing the status controller if it is not already closed.
  void disposeLocationServiceStatusListener() {
    _locationServiceStatusTimer?.cancel();
    if (!_locationServiceStatusController.isClosed) {
      _locationServiceStatusController.close();
    }
  }

  /// Disposes the location service status check listener by cancelling the timer
  /// and closing the stream controller if it is not already closed.
  void disposeLocationServiceStatusCheckListener() {
    _locationServiceStatusCheckTimer?.cancel();
    if (!_locationServiceStatusCheckController.isClosed) {
      _locationServiceStatusCheckController.close();
    }
  }
}
