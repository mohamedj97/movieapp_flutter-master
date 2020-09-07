import 'package:flutter/material.dart';
import 'package:movieapp/data/pojo/review_response.dart';
import 'package:movieapp/resources/AppColors.dart';
import 'package:movieapp/ui/screens/movie_detail/review_item_widget.dart';

class ReviewScreen extends StatelessWidget {
  final _title = "Reviews";
  final List<Review> reviews;

  ReviewScreen(this.reviews);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      backgroundColor: AppColors.COLOR_DARK_PRIMARY,
      body: ListView.separated(
        itemCount: reviews.length,
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return ReviewItemWidget(reviews[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[300],
          );
        },
      ),
    );
  }
}
