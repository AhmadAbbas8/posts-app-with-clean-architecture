import 'package:clean_arch_posts_app/core/error/exception.dart';
import 'package:clean_arch_posts_app/core/error/failure.dart';
import 'package:clean_arch_posts_app/features/posts/data/models/post_model.dart';
import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';
import 'package:clean_arch_posts_app/core/network/network_info.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepositoriesImp implements PostsRepositories {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo netWorkInfo;

  PostRepositoriesImp(
      this.postRemoteDataSource, this.postLocalDataSource, this.netWorkInfo);

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => postRemoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() => postRemoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await netWorkInfo.isConnected) {
      try {
        final remotePosts = await postRemoteDataSource.getAllPosts();
        postLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => postRemoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await netWorkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
