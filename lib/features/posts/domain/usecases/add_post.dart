import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class AddPostUseCases {
  final PostsRepositories postsRepositories;

  AddPostUseCases(this.postsRepositories);

  Future<Either<Failure, Unit>> call(Post post) async =>
      await postsRepositories.addPost(post);
}
