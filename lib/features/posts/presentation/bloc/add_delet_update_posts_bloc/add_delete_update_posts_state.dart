part of 'add_delete_update_posts_bloc.dart';

abstract class AddDeleteUpdatePostsState extends Equatable {
  const AddDeleteUpdatePostsState();
}

class AddDeleteUpdatePostsInitial extends AddDeleteUpdatePostsState {
  @override
  List<Object> get props => [];
}


class LoadingAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState {
  @override

  List<Object?> get props => [];
}

class ErrorAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState {
  final String message;

  const ErrorAddDeleteUpdatePostsState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState {
  final String message;

  const MessageAddDeleteUpdatePostsState({required this.message});

  @override
  List<Object> get props => [message];
}