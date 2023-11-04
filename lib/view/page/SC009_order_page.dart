import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/area/meal_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/meal_api.dart';
import '../../data/noti_api.dart';
import '../../data/order_api.dart';
import '../../model/meal_detail_model.dart';
import '../../repository/meal_repository.dart';
import '../../router/router.dart';
import '../../utils/utils.dart';
import '../widgets/button_orange.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, this.idMeal});
  final String? idMeal;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int totalQuantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop),
        title: const Text('Bữa ăn'),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          // height: 2000,
          width: double.infinity,
          child: Column(
            children: [
              RepositoryProvider(
                create: (context) => MealRepository(mealApi: MealApi()),
                child: BlocProvider(
                  create: (context) =>
                      MealBloc(RepositoryProvider.of<MealRepository>(context))
                        ..getMealById(widget.idMeal ?? ''),
                  child: CardMeal(),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: null,
                  ),
                  Text(
                    '3',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: null,
                  ),
                ],
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.amber[500],
                        ),
                        onPressed: () => {
                          context.push(AppPath.payment),
                        },
                        child: const Text(
                          'Chọn phương thức thanh toán',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.amber,
        height: 120,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Tổng Số Tiền: 60\$',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                width: 350,
                child: ButtonOrange(
                  title: 'Đặt hàng',
                  onPressed: onOrder,
                  icon: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onOrder() async {
    // NotiApi().pushNoti();
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    await OrderApi().createOrder(totalQuantity, userId!, widget.idMeal!);
  }
}

class CardMeal extends StatelessWidget {
  const CardMeal({super.key});

  @override
  Widget build(BuildContext context) {
    final myBloc = context.read<MealBloc>();
    return BlocBuilder(
        bloc: myBloc,
        builder: (context, state) {
          if (state is CommonState) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            } else if (state is CommonState<MealDetailResponse>) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 120, // Độ rộng của hình ảnh món ăn
                        height: 120, // Chiều cao của hình ảnh món ăn
                        child: Image.network(
                          getStorageUrl(state.model.tray.imgUrl),
                          width: 200, // Độ rộng của hình ảnh
                          height: 200, // Chiều cao của hình ảnh
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              state.model.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Bếp: ${state.model.kitchen.name}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${NumberFormat.decimalPattern().format(state.model.price)} VND',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
