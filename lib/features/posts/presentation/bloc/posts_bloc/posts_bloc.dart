import 'package:clean_arch_posts_app/core/error/failure.dart';
import 'package:clean_arch_posts_app/core/strings/failure.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCases getAllPostsUseCases;

  PostsBloc({required this.getAllPostsUseCases}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(GetAllPostsLoadingState());
        final failureOrPosts = await getAllPostsUseCases.call();
        failureOrPosts.fold(
          (failure) => emit(GetAllPostsErrorState(msg: _mapFailureToMessage(failure))),
          (posts) => emit(GetAllPostsSuccessState(posts: posts)),
        );
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      default:
        return 'Error not handling';
    }
  }
}
