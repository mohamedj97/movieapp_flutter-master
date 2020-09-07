import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/data/pojo/trailers_entity.dart';
import 'package:movieapp/resources/AppColors.dart';
import 'package:movieapp/ui/AppWidgets.dart';
import 'package:movieapp/utils/UrlUtils.dart';

class VideoItemWidget extends StatelessWidget {
  final TrailersResult trailer;

  VideoItemWidget(this.trailer);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UrlUtils.launchYouTube(trailer.key);
      },
      child: Container(
        width: 150,
        child: Card(
          margin: EdgeInsets.all(5.0),
          elevation: 6,
          color: AppColors.COLOR_PRIMARY,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RoundedImage(
                imgPath:
                    'https://img.youtube.com/vi/${trailer.key}/sddefault.jpg',
                height: 110,
                width: 150,
              ),
              SizedBox(
                height: 5,
              ),
              AutoSizeText(
                '${trailer.name}',
                minFontSize: 15,
                maxFontSize: 20,
                softWrap: true,
                style: (TextStyle(color: Colors.white)),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
