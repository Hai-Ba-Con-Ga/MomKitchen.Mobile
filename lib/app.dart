import 'package:flutter/material.dart';

import 'router/router.dart';
import 'utils/theme.dart';

class MomKitchen extends StatelessWidget {
  const MomKitchen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
