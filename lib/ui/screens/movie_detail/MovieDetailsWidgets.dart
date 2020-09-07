import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  final String text;

  SubTitleWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      minFontSize: 20,
      maxFontSize: 23,
      style: (TextStyle(color: Colors.orange)),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class MovieDetailsSectionWidget<T> extends StatelessWidget {
  final String text;
  final List<T> data;
  MovieDetailsSectionWidget(this.text, this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SubTitleWidget(text),
      ],
    );
  }
}

class SpaceDividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
    );
  }
}
