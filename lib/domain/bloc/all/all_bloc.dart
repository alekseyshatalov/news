import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/data/models/article.dart';
import 'package:news/data/models/articles_repository.dart';

import '../../../utils/constants.dart';

part 'all_event.dart';
part 'all_state.dart';

class AllBloc extends Bloc<AllEvent, AllState> {
  int page = 1;
  int lastSize = 0;

  AllBloc() : super(AllInitial()) {
    on<LoadArticles>(
      (event, emit) async {
        List<Article> articles = await ArticlesRepository.loadAll(page);
        lastSize = articles.length;
        emit(AllLoaded(articles));
      },
    );

    on<LoadNextPage>(
      (event, emit) async {
        if (lastSize == pageSize) {
          page++;
          List<Article> articles = await ArticlesRepository.loadAll(page);
          lastSize = articles.length;
          emit(AllLoaded(articles));
        }
      },
    );
  }
}
