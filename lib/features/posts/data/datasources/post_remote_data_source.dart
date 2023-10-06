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
  Future<Unit> addPost(Post post) async {
    final body = {
      'title': post.title,
      'body': post.body,
    };
    final response = await dio.post(
      '$BASE_URL/posts',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ),
      data: body,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await dio.delete(
      '$BASE_URL/posts/${id.toString()}',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ),
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
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
  Future<Unit> updatePost(Post post) async {
    final postID = post.id.toString();
    final body = {
      'title': post.title,
      'body': post.body,
    };
    final response = await dio.patch(
      '$BASE_URL/posts/${postID}',
      data: body,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ),
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
