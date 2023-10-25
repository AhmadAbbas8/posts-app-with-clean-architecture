import 'package:clean_arch_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/screens/post_add_update.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/widgets/message_display_widget.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/widgets/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton(context),
    );
  }

  AppBar get appBar => AppBar(
        title: const Text('Posts'),
      );

  Widget get body => Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is GetAllPostsLoadingState) {
              return const LoadingWidget();
            } else if (state is GetAllPostsSuccessState) {
              return RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: PostListWidget(posts: state.posts));
            } else if (state is GetAllPostsErrorState) {
              return MessageDisplayWidget(message: state.msg);
            } else {
              return const LoadingWidget();
            }
          },
        ),
      );

  Future<void> _onRefresh(BuildContext context) async =>
      context.read<PostsBloc>().add(RefreshPostsEvent());

  Widget  floatingActionButton(context) => FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_ ) =>const PostAddUpdateScreen(
                isUpdatePost: false,
              ),
            )),
        child: const Icon(Icons.add),
      );
}
