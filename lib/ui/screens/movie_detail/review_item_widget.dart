import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/data/pojo/review_response.dart';
import 'package:movieapp/resources/AppColors.dart';

class ReviewItemWidget extends StatelessWidget {
  final Review review;
  final bool hasTextLimit;

  ReviewItemWidget(this.review, {this.hasTextLimit = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: hasTextLimit ? Colors.blueGrey[800] : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: hasTextLimit ? 20 : null,
            child: AutoSizeText(review.author,
                minFontSize: 18,
                maxLines: 3,
                maxFontSize: 20,
                style: TextStyle(
                    color: AppColors.TEXT_COLOR, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: hasTextLimit ? 100 : null,
            child: AutoSizeText(review.content,
                minFontSize: 16,
                maxLines: hasTextLimit ? 6 : 1000,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxFontSize: 18,
                style: TextStyle(color: AppColors.TEXT_COLOR)),
          ),
        ],
      ),
    );
  }
}
