import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/area/order_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/order_api.dart';
import '../../model/order_model.dart';
import '../../repository/order_repository.dart';
import '../../router/router.dart';
import '../../utils/utils.dart';
import '../widgets/button_back.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, this.idOrder});
  final String? idOrder;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(),
        title: const Text(
          'Chi tiết đơn hàng',
          style: TextStyle(color: Colors.white),
        ),
        leadingWidth: 70,
        toolbarHeight: 100,
        backgroundColor: const Color.fromRGBO(30, 30, 46, 1),
        foregroundColor: const Color.fromRGBO(30, 30, 46, 1),
        surfaceTintColor: const Color.fromRGBO(30, 30, 46, 1),
      ),
      body: Container(
        // child: Text(widget.idOrder ?? ''),
        decoration: const BoxDecoration(color: Color.fromRGBO(30, 30, 46, 1)),
        child: ListView(
            controller: _controller, // Sử dụng ScrollController
            // physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Text(
                'Đơn Hàng',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Theme.of(context).textTheme.headline1?.fontSize),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Hãy đưa thông tin này\n Khi bạn đến Bếp ăn',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          Theme.of(context).textTheme.bodyLarge?.fontSize),
                  textAlign: TextAlign.center,
                ),
              ),
              // const Icon(Icons.qr_code, size: 250, color: Colors.white),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  _controller.animateTo(1000,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut);
                },
                child: RepositoryProvider(
                  create: (context) => OrderRepository(orderApi: OrderApi()),
                  child: BlocProvider(
                    create: (context) => OrderBloc(
                        RepositoryProvider.of<OrderRepository>(context))
                      ..getOrderById(widget.idOrder ?? ''),
                    child: BodyOrderDetail(),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class BodyOrderDetail extends StatelessWidget {
  const BodyOrderDetail({super.key});

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
          } else if (state is CommonState<Order>) {
            var serviceFrom = DateFormat('yyyy-MM-dd – kk:mm')
                .format(state.model.meal.serviceFrom);
            var serviceTo = DateFormat('yyyy-MM-dd – kk:mm')
                .format(state.model.meal.serviceTo);
            var createdDate = DateFormat('yyyy-MM-dd – kk:mm')
                .format(state.model.createdDate);
            return Container(
              height: 500,
              // margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      state.model.meal.name ?? '',
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.fontSize),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: 100,
                      // width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          getStorageUrl(state.model.meal.tray?.imgUrl ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Thực Khách:   ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.model.customer.user?.fullName ?? '',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //
                    Row(
                      children: [
                        const Text(
                          'Bếp:   ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.model.meal.kitchen?.name ?? '',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Địa chỉ:   ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.model.meal.kitchen?.address ?? '',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      // width: 200,
                      child: Row(
                        children: [
                          const Text(
                            'Ngày đặt hàng: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(createdDate,
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      // width: 200,
                      child: Row(
                        children: [
                          const Text(
                            'Bắt đầu: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(serviceFrom,
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      // width: 200,
                      child: Row(
                        children: [
                          const Text(
                            'Kết thúc:',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(serviceTo,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      // width: 200,
                      child: Row(
                        children: [
                          const Text(
                            'Trạng thái đơn hàng:',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(state.model.status,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
    ;
  }
}
