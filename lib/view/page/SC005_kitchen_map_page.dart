import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_back.dart';

class KitchenMapPage extends StatefulWidget {
  const KitchenMapPage({super.key});

  @override
  State<KitchenMapPage> createState() => _KitchenMapPageState();
}

class _KitchenMapPageState extends State<KitchenMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(onPressed: () => context.go(AppPath.home)),
        title: const Text('Location'),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ListTile(
                tileColor: Color.fromRGBO(240, 245, 250, 1),
                title: Text('Location $index'),
                subtitle: Text(
                  'AddressAddressAddress AddressAddressAddress$index',
                  style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
                ),
                onTap: () => context.go(AppPath.home),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              ),
            );
          },
          itemCount: 20),
    );
  }
}
