import 'package:flutter/material.dart';

import 'router/router.dart';
import 'utils/color.dart';
import 'utils/theme.dart';

class MomKitchen extends StatefulWidget {
  const MomKitchen({Key? key, this.firstRoute}) : super(key: key);
  final String? firstRoute;

  @override
  State<MomKitchen> createState() => _MomKitchenState();
}

class _MomKitchenState extends State<MomKitchen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // routerConfig: AppRouter().Router(widget.firstRoute),
      routerConfig: AppRouter.router,
      theme: mainTheme,
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
    );
  }
}
