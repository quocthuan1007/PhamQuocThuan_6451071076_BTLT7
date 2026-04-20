import 'package:flutter/material.dart';
import '../models/user.dart';

class UserListWidget extends StatelessWidget {
  final List<User> users;
  final bool isLoading;
  final VoidCallback onRefresh;
  final Function(User) onUserTap;

  const UserListWidget({
    Key? key,
    required this.users,
    required this.isLoading,
    required this.onRefresh,
    required this.onUserTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        centerTitle: true,
        elevation: 0,
        actions: [
          if (!isLoading)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: onRefresh,
              tooltip: 'Refresh',
            )
          else
            const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: isLoading && users.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : users.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No users found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: onRefresh,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return UserTile(
                      user: user,
                      onTap: () => onUserTap(user),
                    );
                  },
                ),
    );
  }
}

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserTile({
    Key? key,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: Text(
              user.id.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                user.email,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                'Username: ${user.username}',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey.shade400,
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
