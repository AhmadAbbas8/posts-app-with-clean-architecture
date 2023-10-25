import 'package:clean_arch_posts_app/core/utils/snackbar.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/bloc/add_delet_update_posts_bloc/add_delete_update_posts_bloc.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/screens/posts_screen.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/widgets/delete_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';



class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostsBloc,
              AddDeleteUpdatePostsState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostsState) {
                CustomSnackBar.showSnackBar(
                    message: state.message, context: context,color: Colors.green);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const PostsScreen(),
                    ),
                        (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostsState) {
                Navigator.of(context).pop();
                CustomSnackBar.showSnackBar(
                    message: state.message, context: context,color: Colors.redAccent);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostsState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }
}