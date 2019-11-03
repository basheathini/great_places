import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../views/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}


class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void  _showPreview(double lat, double lon){
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat,
        longitude: lon
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    widget.onSelectPlace(lat, lon);

  }

  Future<void> _getCurrentUserLocation() async{
    try{
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
    }catch(error){
      print(error);
    }


//    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
//        latitude: locData.latitude,
//        longitude: locData.longitude
//    );
//
//    setState(() {
//      _previewImageUrl = staticMapImageUrl;
//    });
//
//    widget.onSelectPlace(locData.latitude, locData.longitude);

  }

  Future<void> _selectOnMap() async{
    final selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
              isSelecting: true
            )
        )
    );
    if(selectedLocation == null){
      return;
    }

    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    //widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
    //print(selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null ? 
          Text('No location Chosen', textAlign: TextAlign.center,)
              :
              Image.network(_previewImageUrl, fit: BoxFit.cover, width: double.infinity,)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(onPressed: _getCurrentUserLocation, icon: Icon(Icons.location_on), label: Text('Current Location'), textColor: Theme.of(context).primaryColor),
            FlatButton.icon(onPressed: _selectOnMap, icon: Icon(Icons.map), label: Text('Select on Map'))
          ],
        )
      ],

    );
  }
}
