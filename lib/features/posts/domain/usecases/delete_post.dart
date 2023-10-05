import 'package:clean_arch_posts_app/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class DeletePostUseCases {
  final PostsRepositories postsRepositories;

  DeletePostUseCases(this.postsRepositories);

  Future<Either<Failure, Unit>> call(int id) async => await postsRepositories.deletePost(id);
}
