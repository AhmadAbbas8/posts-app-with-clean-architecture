import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/bloc/add_delet_update_posts_bloc/add_delete_update_posts_bloc.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/widgets/submit_button.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/widgets/text_form_field_widget.dart';
import 'package:dartz/dartz_streaming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, required this.isUpdatePost, this.post});
  final bool isUpdatePost;
  final Post? post;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final  _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  void initState() {
    if(widget.isUpdatePost){
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
              name: "Title", multiLines: false, controller: titleController),
          TextFormFieldWidget(
              name: "Body", multiLines: true, controller: bodyController),
          FormSubmitBtn(
              isUpdatePost: widget.isUpdatePost,
              onPressed: validateFormThenUpdateOrAddPost),
        ],
      ),
    );
  }
  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Post(
          id: widget.isUpdatePost ? widget.post!.id : 0,
          title: titleController.text,
          body: bodyController.text);

      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
