import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../widgets/location_input.dart';
import '../models/place.dart';


class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _selectedLocation;


  ///I need to revisit this method creation, it needs a file that was captured through
  ///a helper widget and we need to go fetch that file. it is like a reversed function
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng){
      _selectedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage == null || _selectedLocation == null){
      return;
    }
    Provider.of<GreatPlace>(context, listen: false).addPlace(_titleController.text, _pickedImage, _selectedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  SizedBox(height: 10),
                  ImageInput(_selectImage),
                  SizedBox(height: 10),
                  LocationInput(_selectPlace)
              ],),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 40,
            child: RaisedButton.icon(
              onPressed: () =>
                _savePlace()
              ,
              icon: Icon(Icons.add),
              label: Text('Add Place'),
              color: Theme.of(context).accentColor,
              elevation: 15,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
