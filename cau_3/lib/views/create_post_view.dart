import 'package:flutter/material.dart';
import '../models/post.dart';
import '../controller/post_controller.dart';
import '../widget/custom_button.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final PostController _controller = PostController();
  bool _isLoading = false;

  void _submitPost() async {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final post = Post(
        title: _titleController.text,
        body: _bodyController.text,
        userId: 1, // default user
      );

      final responseBody = await _controller.createPost(post);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post created successfully')),
        );
        print('Server Response: $responseBody');
        _titleController.clear();
        _bodyController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
                    text: 'Create Post',
                    onPressed: _submitPost,
                  ),
          ],
        ),
      ),
    );
  }
}
