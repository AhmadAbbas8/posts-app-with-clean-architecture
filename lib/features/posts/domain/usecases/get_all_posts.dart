import 'package:clean_arch_posts_app/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class GetAllPostsUseCases {
  final PostsRepositories postsRepositories;

  GetAllPostsUseCases(this.postsRepositories);

  Future<Either<Failure, List<Post>>> call() async =>
      await postsRepositories.getAllPosts();
}

