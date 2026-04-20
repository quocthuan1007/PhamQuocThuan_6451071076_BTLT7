import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/api_service.dart';
import '../widgets/user_list_widget.dart';
import 'user_detail_view.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late Future<List<User>> futureUsers;
  List<User> users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUserList();
  }

  /// Fetch users from API
  Future<List<User>> fetchUserList() async {
    setState(() {
      isLoading = true;
    });

    try {
      final users = await ApiService.fetchUsers();
      setState(() {
        this.users = users;
        isLoading = false;
      });
      return users;
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      rethrow;
    }
  }

  /// Refresh user list
  void refreshUserList() {
    setState(() {
      futureUsers = fetchUserList();
    });
  }

  /// Navigate to user detail view
  void navigateToDetail(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailView(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: futureUsers,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return UserListWidget(
            users: users,
            isLoading: isLoading,
            onRefresh: refreshUserList,
            onUserTap: navigateToDetail,
          );
        }

        return UserListWidget(
          users: users,
          isLoading: isLoading,
          onRefresh: refreshUserList,
          onUserTap: navigateToDetail,
        );
      },
    );
  }
}
