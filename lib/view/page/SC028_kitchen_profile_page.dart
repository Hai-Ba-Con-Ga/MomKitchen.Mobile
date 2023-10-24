import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../../utils/utils.dart';

class KitchenProfilePage extends StatefulWidget {
  const KitchenProfilePage({super.key});

  @override
  State<KitchenProfilePage> createState() => _KitchenProfilePageState();
}

class _KitchenProfilePageState extends State<KitchenProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                logout();
                context.go(
                  AppPath.login,
                );
              },
              child: const Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }
}
