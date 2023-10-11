import 'package:clean_arch_posts_app/features/posts/presentation/bloc/add_delet_update_posts_bloc/add_delete_update_posts_bloc.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/screens/posts_screen.dart';
import 'package:clean_arch_posts_app/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const PostsApp());
}

class PostsApp extends StatelessWidget {
  const PostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (context) => di.sl<AddDeleteUpdatePostsBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'Posts App',
        home: PostsScreen(),
      ),
    );
  }
}
