import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storeImage;

  Future<void> _launchCamera() async{
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 600);
    setState(() {
      _storeImage = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 400,
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 0.7, color: Colors.grey)
          ),
          child: _storeImage != null ? Image.file(_storeImage, fit: BoxFit.cover, width: double.infinity) : Text('No Image Taken', textAlign: TextAlign.center),
        ),
        SizedBox(width: 10.0,),
        Container(
          width: 400,
          height: 100,
            child: FlatButton.icon(
              icon: Icon(Icons.camera),
              label: Text('Take Image'),
              textColor: Theme.of(context).primaryColor,
              splashColor: Theme.of(context).accentColor,
              onPressed: () => _launchCamera(),
            ),
        )
        //expanded to fill up the remaining space
      ],
    );
  }
}
