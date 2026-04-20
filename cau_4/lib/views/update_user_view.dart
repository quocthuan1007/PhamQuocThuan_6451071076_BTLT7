import 'package:flutter/material.dart';
import '../models/user.dart';
import '../controller/user_controller.dart';
import '../widget/custom_text_field.dart';

class UpdateUserView extends StatefulWidget {
  const UpdateUserView({super.key});

  @override
  State<UpdateUserView> createState() => _UpdateUserViewState();
}

class _UpdateUserViewState extends State<UpdateUserView> {
  final UserController _controller = UserController();
  final _formKey = GlobalKey<FormState>();
  
  late Future<User> _futureUser;
  User? _user;
  bool _isUpdating = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    _futureUser = _controller.getUser(1).then((user) {
      setState(() {
        _user = user;
        _nameController.text = user.name;
        _emailController.text = user.email;
      });
      return user;
    });
  }

  void _updateUser() async {
    if (_formKey.currentState!.validate() && _user != null) {
      setState(() {
        _isUpdating = true;
      });

      _user!.name = _nameController.text;
      _user!.email = _emailController.text;

      try {
        final updatedUser = await _controller.updateUser(_user!);
        if (mounted) {
          setState(() {
            _user = updatedUser;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User updated successfully!')),
          );
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
            _isUpdating = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update User Info')),
      body: FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && _user == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (_user != null) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      label: 'Name',
                      validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
                    ),
                    const SizedBox(height: 20),
                    _isUpdating
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _updateUser,
                            child: const Text('Update Info'),
                          ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
