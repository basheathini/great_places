import 'package:flutter/foundation.dart';
import '../models/place.dart';

class GreatPlace with ChangeNotifier{
  List<Place> _items = [];

  List<Place> get items{
    return [..._items];
  }

}