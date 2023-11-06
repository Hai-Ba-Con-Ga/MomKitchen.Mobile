import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/area/order_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/order_api.dart';
import '../../model/order_model.dart';
import '../../repository/order_repository.dart';
import '../../router/router.dart';
import '../widgets/base_ListTile.dart';
import '../widgets/button_back.dart';
import '../widgets/order/card_order.dart';

class ListOrderPage extends StatefulWidget {
  const ListOrderPage({super.key});

  @override
  State<ListOrderPage> createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(onPressed: () => context.pop()),
        leadingWidth: 70,
        toolbarHeight: 100,
        title: const Text('Đơn Hàng của bạn'),
      ),
      body: ListCardOrder(),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       leading: ButtonBack(onPressed: () => context.pop()),
  //       leadingWidth: 70,
  //       toolbarHeight: 100,
  //       title: const Text('Đơn Hàng của bạn'),
  //     ),
  //     body: Container(
  //       child: RepositoryProvider(
  //         create: (context) => OrderRepository(orderApi: OrderApi()),
  //         child: BlocProvider(
  //           create: (context) =>
  //               OrderBloc(RepositoryProvider.of<OrderRepository>(context))
  //                 ..getAllOrderByUserId(),
  //           child: ListCardOrder(),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

// class ListCardOrder extends StatefulWidget {
//   const ListCardOrder({super.key});

//   @override
//   State<ListCardOrder> createState() => _ListCardOrderState();
// }

// class _ListCardOrderState extends State<ListCardOrder> {
//   @override
//   Widget build(BuildContext context) {
//     final myBloc = context.read<OrderBloc>();
//     return BlocBuilder(
//         bloc: myBloc,
//         builder: (context, state) {
//           if (state is CommonState) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (state.errorMessage != null) {
//               return Center(child: Text(state.errorMessage!));
//             } else if (state is CommonState<List<Order>>) {
//               return SizedBox(
//                 height: 200,
//                 width: double.infinity,
//                 child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemCount: state.model.length,
//                   itemBuilder: (context, index) {
//                     return CardOrder();
//                   },
//                 ),
//               );
//             }
//             return Container();
//           }
//           return const Center(child: CircularProgressIndicator());
//         });
//   }
// }

class ListCardOrder extends StatelessWidget {
  const ListCardOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (context, index) {
          return CardOrder();
        },
      ),
    );
  }
}
