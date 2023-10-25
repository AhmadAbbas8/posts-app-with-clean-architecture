import 'package:clean_arch_posts_app/core/utils/snackbar.dart';
import 'package:clean_arch_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/bloc/add_delet_update_posts_bloc/add_delete_update_posts_bloc.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/screens/posts_screen.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAddUpdateScreen extends StatelessWidget {
  final bool isUpdatePost;

  final Post? post;

  const PostAddUpdateScreen({super.key, required this.isUpdatePost, this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  AppBar get appBar => AppBar(
        title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
      );

  Widget get body => Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child:
              BlocConsumer<AddDeleteUpdatePostsBloc, AddDeleteUpdatePostsState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostsState) {
                CustomSnackBar.showSnackBar(context: context, message: state.message, color: Colors.green);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => PostsScreen(),
                    ),
                    (route) => false);
              }else if(state is ErrorAddDeleteUpdatePostsState){

              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostsState) {
                return LoadingWidget();
              }
              return  FormWidget(
                    isUpdatePost: isUpdatePost,
                    post: isUpdatePost ? post : null);


            },
          ),
        ),
      );


}
