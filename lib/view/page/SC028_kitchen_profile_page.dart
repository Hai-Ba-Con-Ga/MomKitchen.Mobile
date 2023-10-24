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
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text('Hồ sơ nhà bếp'),
        actions: [
          IconButton(
            onPressed: () {
              context.push(
                AppPath.kitchenprofileedit,
              );
            },
            icon: const Icon(
              Icons.edit_document,
              color: Colors.orange,
            ),
          ),
        ],
      ),
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
