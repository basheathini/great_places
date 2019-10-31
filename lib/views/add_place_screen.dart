import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();

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
                  ImageInput(),
              ],),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 40,
            child: RaisedButton.icon(
              onPressed: () {},
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
