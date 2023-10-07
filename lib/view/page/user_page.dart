import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
          TextButton(
            onPressed: () => context.go(
              AppPath.login,
            ),
            child: const Text('Log Out'),
          ),
        
      ),
    );
  }
}
