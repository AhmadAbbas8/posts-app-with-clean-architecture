import 'package:clean_arch_posts_app/core/error/exception.dart';
import 'package:clean_arch_posts_app/features/posts/data/models/post_model.dart';
import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

const BASE_URL = 'https://jsonplaceholder.typicode.com';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int id);

  Future<Unit> updatePost(Post post);

  Future<Unit> addPost(Post post);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl({required this.dio});

  @override
  Future<Unit> addPost(Post post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await dio.get(
      '$BASE_URL/posts',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ),
    );
    if (response.statusCode == 200) {
      final List<PostModel> postModel = [];
      for (var val in response.data as List) {
        postModel.add(PostModel.fromJson(val));
      }
      return postModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(Post post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
