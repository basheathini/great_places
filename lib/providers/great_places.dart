import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlace with ChangeNotifier{
  List<Place> _items = [];

  List<Place> get items{
    return [..._items];
  }

  void addPlace(String imageTitle, File pickedImage){
    var id = DateTime.now().toString();
    final newlyCreatedPlace = Place(id: id ,title: imageTitle,location: null, image: pickedImage);
    _items.insert(0, newlyCreatedPlace);

    DBHelper.insert('user_places', {
      'id': id,
      'title': imageTitle,
      'image': pickedImage.path
    });
    notifyListeners();
  }

  Future<void> getPlaces() async{
    final dataList = await DBHelper.getData('user_places');
    _items = dataList.map((item) => Place(
      id: item['id'],
      title: item['title'],
      image: File(item['image']),
      location: null
    )).toList();
    notifyListeners();
  }

}