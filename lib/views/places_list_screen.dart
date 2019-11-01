import 'package:flutter/material.dart';
import '../views/add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dope Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
          )
        ],
      ),
      body: Consumer<GreatPlace>(
        child: Center(
          child: const Text('No places yet, start adding some!'),
        ),
        builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0 ? ch : ListView.builder(itemBuilder: (ctx, i) => ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(
              greatPlaces.items[i].image
            ),
          ),
          trailing: Icon(Icons.delete,color: Colors.red,),
          title: Text(greatPlaces.items[i].title),
          onTap: () {
            //view the details of the place
          },
        ), itemCount: greatPlaces.items.length
        ),
      ),
    );
  }
}
