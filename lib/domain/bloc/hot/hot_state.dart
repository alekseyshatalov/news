part of 'hot_bloc.dart';

abstract class HotState extends Equatable {
  const HotState();

  @override
  List<Object> get props => [];
}

class HotInitial extends HotState {}

class HotUpdating extends HotState {}

class HotLoaded extends HotState {
  final List<Article> articles;

  const HotLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}
