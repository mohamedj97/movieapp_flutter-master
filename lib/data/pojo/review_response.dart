import 'dart:convert';

class ReviewResponse {
  int id;
  int page;
  List<Review> results;
  int totalPages;
  int totalResults;

  ReviewResponse({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        id: json["id"] == null ? null : json["id"],
        page: json["page"] == null ? null : json["page"],
        results: json["results"] == null
            ? null
            : List<Review>.from(json["results"].map((x) => Review.fromMap(x))),
        totalPages: json["total_pages"] == null ? null : json["total_pages"],
        totalResults:
            json["total_results"] == null ? null : json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "page": page == null ? null : page,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages == null ? null : totalPages,
        "total_results": totalResults == null ? null : totalResults,
      };
}

class Review {
  String author;
  String content;
  String id;
  String url;
  int movieId;

  Review({
    this.author,
    this.content,
    this.id,
    this.url,
  });

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        author: json["author"] == null ? null : json["author"],
        content: json["content"] == null ? null : json["content"],
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toMap() => {
        "author": author == null ? null : author,
        "content": content == null ? null : content,
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        'movieId': movieId,
      };
}
