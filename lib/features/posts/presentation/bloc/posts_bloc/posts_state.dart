part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class GetAllPostsLoadingState extends PostsState {}
class GetAllPostsErrorState extends PostsState {
  final String msg;

  const GetAllPostsErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class GetAllPostsSuccessState extends PostsState {
  final List<Post> posts;

  const GetAllPostsSuccessState({required this.posts});
  @override
  List<Object> get props => [posts];
}
