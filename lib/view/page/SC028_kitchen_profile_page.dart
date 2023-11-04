import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../data/meal_api.dart';
import '../../router/router.dart';

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
              onPressed: () => {
                logOut(),
                context.go(
                  AppPath.login,
                )
                // MealApi().getMealById('dcf2589a-cc3a-4f8f-a7f1-4bbb169a57f4')
              },
              child: const Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logOut() async {
    await AuthBloc().signOutWithGoogle();
  }
}
