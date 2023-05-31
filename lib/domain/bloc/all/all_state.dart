part of 'all_bloc.dart';

abstract class AllState extends Equatable {
  const AllState();

  @override
  List<Object> get props => [];
}

class AllInitial extends AllState {}

class AllLoaded extends AllState {
  final List<Article> articles;

  const AllLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}
