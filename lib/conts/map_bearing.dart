// Function to calculate bearing between two LatLng points
import 'dart:math';

double bearingBetweenLatLngs(_currentlocation, _destinationlocation) {
  double lat1 = _currentlocation.latitude * (3.141592653589793 / 180);
  double lon1 = _currentlocation.longitude * (3.141592653589793 / 180);
  double lat2 = _destinationlocation.latitude * (3.141592653589793 / 180);
  double lon2 = _destinationlocation.longitude * (3.141592653589793 / 180);
  double dLon = lon2 - lon1;
  double y = sin(dLon) * cos(lat2);
  double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
  double brng = atan2(y, x);
  brng = brng * (180 / 3.141592653589793);
  brng = (brng + 360) % 360;
  return brng;
}
