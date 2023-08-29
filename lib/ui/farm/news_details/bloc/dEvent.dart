import 'package:equatable/equatable.dart';
import 'package:plantpulse/data/farm/models/News.dart';

abstract class NewsDetailEvent extends Equatable {
  const NewsDetailEvent();

  @override
  List<Object> get props => [];
}

class SelectNewsForDetail extends NewsDetailEvent {
  final Article article;
  const SelectNewsForDetail({required this.article});

  @override
  String toString() => 'SelectNewsForDetail Page { Title:: ${article.title} }';
}

class SelectNewsForDetailed extends NewsDetailEvent {
  final Article article;
  const SelectNewsForDetailed({required this.article});

  @override
  String toString() => 'SelectNewsForDetailed news { Title: ${article.title} }';
}
