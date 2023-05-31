import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/data/models/article.dart';
import 'package:news/data/models/articles_repository.dart';
import 'package:news/utils/constants.dart';

part 'hot_event.dart';
part 'hot_state.dart';

class HotBloc extends Bloc<HotEvent, HotState> {
  HotBloc() : super(HotInitial()) {
    int page = 1;
    int lastSize = 0;

    Timer.periodic(
      updateDuration,
      (timer) {
        print('hot update');
        // TODO - enable
        // add(LoadArticles());
      },
    );

    on<LoadArticles>(
      (event, emit) async {
        List<Article> articles = await ArticlesRepository.loadHot(page);
        lastSize = articles.length;
        emit(HotLoaded(articles));
      },
    );

    on<LoadNextPage>(
      (event, emit) async {
        if (lastSize == pageSize) {
          page++;
          List<Article> articles = await ArticlesRepository.loadAll(page);
          lastSize = articles.length;
          emit(HotLoaded(articles));
        }
      },
    );
  }
}
