import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sys_paths;

class ImageInput extends StatefulWidget {

  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storeImage;


  Future<void> _launchCamera() async{

    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 600);

    if(imageFile == null){
      return;
    }

    setState(() {
      _storeImage = imageFile;
    });

    final imageName = path.basename(imageFile.path);
    final appDir = await sys_paths.getApplicationDocumentsDirectory();
    final savedImagePlace = await imageFile.copy('${appDir.path}/$imageName');
    widget.onSelectImage(savedImagePlace);
    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 400,
          height: 120,
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
              label: const Text('Take Image'),
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
