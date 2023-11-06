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
  int quantity = 1;
  int price = 0;
  int maxQuantity = 1;

  void setMaxQuantity(int newValue) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        maxQuantity = newValue;
      });
      // Logger().i(newValue);
    });
  }

  void setPrice(int newValue) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        price = newValue;
      });
      // Logger().i(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(),
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
                  child: CardMeal(
                    setMaxQuantity: setMaxQuantity,
                    setPrice: setPrice,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: decreaseQuantity,
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: increaseQuantity,
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
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Tổng Số Tiền:     ${NumberFormat.decimalPattern().format(quantity * price)} VND',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                width: 350,
                child: ButtonOrange(
                  title: 'Đặt hàng',
                  onPressed: () => {
                    onOrder(),
                    // context.go(
                    //   AppPath.home,
                    // )
                  },
                  icon: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void increaseQuantity() {
    if (quantity < maxQuantity) {
      setState(() {
        quantity++;
      });
    }
  }

  onOrder() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    await OrderApi().createOrder(quantity, userId!, widget.idMeal!);
  }
}

class CardMeal extends StatefulWidget {
  final Function(int) setMaxQuantity;
  final Function(int) setPrice;
  const CardMeal(
      {super.key, required this.setMaxQuantity, required this.setPrice});

  @override
  State<CardMeal> createState() => _CardMealState();
}

class _CardMealState extends State<CardMeal> {
  bool isMaxQuantitySet = false;
  bool isPriceSet = false;

  void setMaxQuantity(int max) {
    if (!isMaxQuantitySet) {
      isMaxQuantitySet = true;
      widget.setMaxQuantity(max);
    }
  }

  void setPrice(int price) {
    if (!isPriceSet) {
      isPriceSet = true;
      widget.setPrice(price);
    }
  }

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
              setMaxQuantity(state.model.serviceQuantity);
              setPrice(state.model.price);
              return Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 120, // Độ rộng của hình ảnh món ăn
                        height: 120, // Chiều cao của hình ảnh món ăn
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            getStorageUrl(state.model.tray.imgUrl),
                            width: 200, // Độ rộng của hình ảnh
                            height: 200, // Chiều cao của hình ảnh
                            fit: BoxFit.cover,
                          ),
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
