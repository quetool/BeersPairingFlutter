import 'package:beers_pairing/screens/random_beer.dart';
import 'package:flutter/material.dart';

class PairedBeersBody extends StatefulWidget {
  @override
  _PairedBeersBodyState createState() => _PairedBeersBodyState();
}

class _PairedBeersBodyState extends State<PairedBeersBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            title: Text("Title"),
            subtitle: Text("Subtitle"),
            trailing: AbvWidget(percentage: 2.0),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
