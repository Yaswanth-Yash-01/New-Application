import 'package:blocnews/models/article_model.dart';
import 'package:equatable/equatable.dart';

abstract class NewsStates extends Equatable {
  const NewsStates();

  @override
  List<Object> get props => [];
}

class NewsInitState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsLoadedState extends NewsStates {
  final List<ArticleModel> articleList;

  const NewsLoadedState({required this.articleList});

  @override
  List<Object> get props => [articleList];
}

class NewsErrorState extends NewsStates {
  final String errorMessage;

  const NewsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
