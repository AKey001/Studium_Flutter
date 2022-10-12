import 'package:flutter/material.dart';

class AverageCardWidget extends StatelessWidget {
  const AverageCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container (
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const ListTile(
              title: Text('Durchschnitt'),
              subtitle: Text('vorläufig'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 8.0
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    '1.23',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}