import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/data/pojo/CastResponse.dart';
import 'package:movieapp/ui/AppWidgets.dart';

import '../../../constants.dart';

class ActorItemWidget extends StatelessWidget {
  final CastElement actor;

  ActorItemWidget(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            RoundedImage(
              imgPath: '$IMAGE_PATH${actor.profilePath}',
              height: 100,
              width: 150,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.2),
                margin: EdgeInsets.all(5.0),
                width: double.infinity,
                child: AutoSizeText(
                  '${actor.name}\n(${actor.character})',
                  minFontSize: 13,
                  maxFontSize: 15,
                  style: (TextStyle(color: Colors.white)),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
