import 'package:flutter/material.dart';
import '../models/user.dart';

class UserDetailView extends StatelessWidget {
  final User user;

  const UserDetailView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Avatar with ID
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        user.id.toString(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Details Card
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        icon: Icons.person,
                        label: 'Full Name',
                        value: user.name,
                      ),
                      const Divider(height: 24),
                      _buildDetailRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: user.email,
                      ),
                      const Divider(height: 24),
                      _buildDetailRow(
                        icon: Icons.account_circle,
                        label: 'Username',
                        value: user.username,
                      ),
                      const Divider(height: 24),
                      _buildDetailRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: user.phone,
                      ),
                      const Divider(height: 24),
                      _buildDetailRow(
                        icon: Icons.language,
                        label: 'Website',
                        value: user.website,
                      ),
                      const Divider(height: 24),
                      _buildDetailRow(
                        icon: Icons.badge,
                        label: 'ID',
                        value: user.id.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Back Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to List'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
