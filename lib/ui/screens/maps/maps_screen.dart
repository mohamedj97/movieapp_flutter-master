import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:movieapp/resources/AppColors.dart';
import 'package:movieapp/ui/AppWidgets.dart';
import 'package:movieapp/utils/Locale.dart';

class MapsScreen extends StatefulWidget {
  MapsScreen({Key key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

enum LocationState { asking, success, refused }

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = {};
  LocationState canGetLocation = LocationState.asking;
  final location = new Location();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
  }

  Future<LatLng> getLoc() async {
    LocationData currentLocation;

    try {
      currentLocation = await location.getLocation();
      print("Location: " +
          currentLocation.longitude.toString() +
          "," +
          currentLocation.latitude.toString());
    } on PlatformException catch (e) {
      print("error " + e.code);
      if (e.code == 'PERMISSION_DENIED') {
        print('PERMISSION_DENIED');
      }
    }

    LatLng my = LatLng(currentLocation.latitude, currentLocation.longitude);
//    final GoogleMapController controller = await _controller.future;
//    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
//      bearing: 0,
//      target: my,
//      zoom: 19.4746,
//    )));
    markers.add(Marker(
      markerId: MarkerId('me'),
      position: my,
    ));

    return my;
  }

  getLocation() async {
    if (await location.hasPermission() == true) {
      if (await location.serviceEnabled() == true) {
        setState(() {
          canGetLocation = LocationState.success;
        });
      } else {
        if (await location.requestService() == true)
          setState(() {
            canGetLocation = LocationState.success;
          });
        else {
          setState(() {
            canGetLocation = LocationState.refused;
          });
        }
      }
    } else {
      if (await location.requestPermission() == true) {
        if (await location.serviceEnabled() == true) {
          setState(() {
            canGetLocation = LocationState.success;
          });
        } else {
          if (await location.requestService() == true)
            setState(() {
              canGetLocation = LocationState.success;
            });
          else {
            setState(() {
              canGetLocation = LocationState.refused;
            });
          }
        }
      } else
        setState(() {
          canGetLocation = LocationState.refused;
        });
    }
  }

  Widget getWidget() {
    if (canGetLocation == LocationState.asking) {
      return ProgressBar();
    } else if (canGetLocation == LocationState.refused) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: AutoSizeText(
            appLocale.tr('Location_Error'),
            minFontSize: 20,
            maxFontSize: 30,
            style: TextStyle(color: AppColors.TEXT_COLOR),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else
      return FutureBuilder(
        future: getLoc(),
        builder: (context, AsyncSnapshot<LatLng> location) {
          if (location.connectionState == ConnectionState.waiting) {
            return ProgressBar();
          } else
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              markers: this.markers,
              initialCameraPosition: CameraPosition(
                target: location.data,
                zoom: 11.0,
              ),
            );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.COLOR_DARK_PRIMARY,
      child: getWidget(),
    );
  }
}
