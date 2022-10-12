import 'package:flutter/material.dart';

class ResultCardWidget extends StatelessWidget {
  const ResultCardWidget({Key? key}) : super(key: key);

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
              title: Text('Gesamturteil'),
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
                    '1.0',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    '24',
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}