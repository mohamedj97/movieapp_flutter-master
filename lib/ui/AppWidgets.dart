import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/resources/AppColors.dart';

class RoundedImage extends StatelessWidget {
  final String imgPath;
  final String imgPlaceHolder;
  final double height;
  final double width;

  RoundedImage(
      {@required this.imgPath,
      this.imgPlaceHolder = 'images/placeholder.jpg',
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: 200),
        fadeOutDuration: Duration(milliseconds: 200),
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
              color: AppColors.COLOR_DARK_PRIMARY,
              border: Border.all(color: AppColors.TEXT_COLOR)),
          child: Center(
            child: ProgressBar(),
          ),
        ),
        imageUrl: imgPath,
        fit: BoxFit.fill,
        height: height ?? height,
        width: width ?? width,
        errorWidget: (context, url, error) => Image.asset(
          imgPlaceHolder,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}

class FavouriteBtn extends StatefulWidget {
  final String _unFavorite = 'Unfavorited';
  final String _makeITFavorite = 'Favorite';
  final String _favorite = 'Favorited';
  final String _makeItUnFavorite = 'Unfavorite';
  final bool isFavoutrite;
  final Function onPressed;

  FavouriteBtn(this.isFavoutrite, this.onPressed);

  @override
  _FavouriteBtnState createState() => _FavouriteBtnState();
}

class _FavouriteBtnState extends State<FavouriteBtn> {
  String animation;

  @override
  void initState() {
    super.initState();
    animation = widget.isFavoutrite ? widget._favorite : widget._unFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          animation = widget.isFavoutrite
              ? widget._makeItUnFavorite
              : widget._makeITFavorite;
        });
        if (animation == widget._makeItUnFavorite ||
            animation == widget._makeITFavorite) {
          widget.onPressed();
        }
      },
      child: FlareActor(
        'assets/favorite.flr',
        fit: BoxFit.none,
        animation: animation,
        callback: (animation) {},
      ),
    );
  }
}
