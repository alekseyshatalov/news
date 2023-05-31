import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String url;
  final String? urlToImage;
  final String title;
  final String description;
  final String? content;

  const Article(
    this.url,
    this.urlToImage,
    this.title,
    this.description,
    this.content,
  );

  @override
  List<Object?> get props => [url, urlToImage, title, description];
}
