import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlace with ChangeNotifier{
  List<Place> _items = [];

  List<Place> get items{
    return [..._items];
  }

  Future<void> addPlace(String imageTitle, File pickedImage, PlaceLocation pickedLocation) async{

    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(longitude: pickedLocation.longitude, latitude: pickedLocation.longitude, address: address);

    var id = DateTime.now().toString();

    final newlyCreatedPlace = Place(id: id ,title: imageTitle,location: updatedLocation, image: pickedImage);
    _items.insert(0, newlyCreatedPlace);

    DBHelper.insert('user_places', {
      'id': id,
      'title': newlyCreatedPlace.title,
      'image': newlyCreatedPlace.image.path,
      'loc_lat': newlyCreatedPlace.location.latitude,
      'loc_lng': newlyCreatedPlace.location.longitude,
      'address': newlyCreatedPlace.location.address
    });
    notifyListeners();
  }

  Future<void> getPlaces() async{
    final dataList = await DBHelper.getData('user_places');
    _items = dataList.map((item) => Place(
      id: item['id'],
      title: item['title'],
      image: File(item['image']),
      location: PlaceLocation(
          latitude: item['loc_lat'] ,
          longitude: item['loc_lng'],
          address:  item['address']),
    )).toList();
    notifyListeners();
  }
  Place findPlaceById(String id){
    return _items.firstWhere((place) => place.id == id);
  }

}