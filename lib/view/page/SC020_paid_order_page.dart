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
import '../widgets/order/card_order_kitchen.dart';

class PaidOrderPage extends StatefulWidget {
  PaidOrderPage({super.key, required this.orderStatus});
  String orderStatus = 'paid';

  @override
  State<PaidOrderPage> createState() => _PaidOrderPageState();
}

class _PaidOrderPageState extends State<PaidOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RepositoryProvider(
          create: (context) => OrderRepository(orderApi: OrderApi()),
          child: BlocProvider(
            create: (context) => OrderBloc(RepositoryProvider.of<OrderRepository>(context))..getAllOrderByKitchenId(widget.orderStatus),
            child: ListCardOrder(),
          ),
        ),
      ),
    );
  }
}

class ListCardOrder extends StatelessWidget {
  const ListCardOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final myBloc = context.read<OrderBloc>();
    return BlocBuilder(
        bloc: myBloc,
        builder: (context, state) {
          if (state is CommonState) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            } else if (state is CommonState<List<Order>>) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.model.length,
                itemBuilder: (context, index) {
                  return CardOrderKitchen(
                    order: state.model[index],
                  );
                },
              );
            }
            return Container();
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
