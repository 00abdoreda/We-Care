import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get_storage/get_storage.dart';

class GeoMap extends StatefulWidget {
  @override
  _GeoMapState createState() => _GeoMapState();
}

class _GeoMapState extends State<GeoMap> {
  GoogleMapController? _controller;
  Location _location = Location();
  LatLng _initialPosition = LatLng(37.4219999, -122.0840575);
  bool _isMapInitialized = false;
  List<Marker> _markers = [];
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _loadMarkers();
  }

  Future<void> _getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();
    setState(() {
      _initialPosition = LatLng(_locationData.latitude!, _locationData.longitude!);
      _isMapInitialized = true;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _location.onLocationChanged.listen((l) {
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  Future<void> _loadMarkers() async {
    List<dynamic>? markerList = box.read<List<dynamic>>('markers');
    if (markerList != null) {
      setState(() {
        _markers = markerList.map((marker) {
          List<String> data = marker.split(',');
          return Marker(
            markerId: MarkerId(marker),
            position: LatLng(double.parse(data[0]), double.parse(data[1])),
            infoWindow: InfoWindow(title: data[2]),
          );
        }).toList();
      });
    }
  }

  Future<void> _addMarker() async {
    if (_markers.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only add up to 3 markers.')),
      );
      return;
    }

    LocationData _locationData = await _location.getLocation();
    LatLng position = LatLng(_locationData.latitude!, _locationData.longitude!);

    String? locationName = await _getLocationName();

    if (locationName != null && locationName.isNotEmpty) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(position.toString()),
            position: position,
            infoWindow: InfoWindow(title: locationName),
          ),
        );
      });

      List<String> markerList = _markers.map((marker) => '${marker.position.latitude},${marker.position.longitude},${marker.infoWindow.title}').toList();
      await box.write('markers', markerList);
    }
  }

  Future<String?> _getLocationName() async {
    TextEditingController nameController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Patient Name'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Patient Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(nameController.text);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient display map'),
      ),
      body: _isMapInitialized
          ? GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 15),
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(_markers),
        myLocationEnabled: true,
      )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMarker,
        child: Icon(Icons.add_location),
      ),
    );
  }
}
