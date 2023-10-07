import 'package:clean_arch_posts_app/core/network/network_info.dart';
import 'package:clean_arch_posts_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_arch_posts_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_arch_posts_app/features/posts/data/repositories/post_repositories_imp.dart';
import 'package:clean_arch_posts_app/features/posts/domain/repositories/posts_repositories.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/delete_post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/update_post.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/bloc/add_delet_update_posts_bloc/add_delete_update_posts_bloc.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostsBloc(getAllPostsUseCases: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostsBloc(
      addPost: sl(), updatePost: sl(), deletePost: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUseCases(sl()));
  sl.registerLazySingleton(() => AddPostUseCases(sl()));
  sl.registerLazySingleton(() => DeletePostUseCases(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCases(sl()));

// Repository

  sl.registerLazySingleton<PostsRepositories>(() => PostRepositoriesImp(
      postRemoteDataSource: sl(),
      postLocalDataSource: sl(),
      netWorkInfo: sl()));

// Datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetWorkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
