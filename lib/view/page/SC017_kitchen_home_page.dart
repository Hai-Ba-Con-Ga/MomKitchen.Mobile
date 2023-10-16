import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_orange.dart';

class KitchenHome extends StatefulWidget {
  const KitchenHome({super.key});

  @override
  State<KitchenHome> createState() => _KitchenHomeState();
}

class _KitchenHomeState extends State<KitchenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen owner name'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ButtonOrange(
            title: 'Kitchen Manager',
            onPressed: () => context.go(AppPath.kitchenmanager),
          )
        ],
      )),
    );
  }
}
