
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch_posts_app/core/error/failure.dart';
import 'package:clean_arch_posts_app/core/strings/errors.dart';
import 'package:clean_arch_posts_app/core/strings/failure.dart';
import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/delete_post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/update_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_posts_event.dart';

part 'add_delete_update_posts_state.dart';

class AddDeleteUpdatePostsBloc
    extends Bloc<AddDeleteUpdatePostsEvent, AddDeleteUpdatePostsState> {
  final AddPostUseCases addPost;
  final DeletePostUseCases deletePost;
  final UpdatePostUseCases updatePost;

  AddDeleteUpdatePostsBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdatePostsInitial()) {
    on<AddDeleteUpdatePostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostsState());

        final failureOrDoneMessage = await addPost(event.post);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostsState());

        final failureOrDoneMessage = await updatePost(event.post);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostsState());

        final failureOrDoneMessage = await deletePost(event.postId);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }

  AddDeleteUpdatePostsState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePostsState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdatePostsState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
