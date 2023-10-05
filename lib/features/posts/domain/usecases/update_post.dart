import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class UpdatePostUseCases {
  final PostsRepositories postsRepositories;

  UpdatePostUseCases(this.postsRepositories);

  Future<Either<Failure, Unit>> call(Post post) async =>
      await postsRepositories.updatePost(post);
}
