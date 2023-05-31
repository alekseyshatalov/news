part of 'all_bloc.dart';

abstract class AllEvent extends Equatable {
  const AllEvent();

  @override
  List<Object> get props => [];
}

class LoadArticles extends AllEvent {}

class LoadNextPage extends AllEvent {}
