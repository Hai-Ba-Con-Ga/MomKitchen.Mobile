import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../bloc/area/meal_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/meal_api.dart';
import '../../model/meal_detail_model.dart';
import '../../repository/meal_repository.dart';
import '../../router/router.dart';
import '../../utils/utils.dart';
import '../widgets/button_orange.dart';

int totalmax = 1;

class MealDetail extends StatefulWidget {
  const MealDetail({super.key, this.idMeal});
  final String? idMeal;

  @override
  State<MealDetail> createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.pop(),
        ),
        // backgroundColor: Colors.transparent,
        // backgroundColor: Color(0x44000000),
        // elevation: 0,
        title: const Text('Title'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Colors.red[600],
                size: 30,
              )),
        ],
      ),
      body: RepositoryProvider(
        create: (context) => MealRepository(mealApi: MealApi()),
        child: BlocProvider(
          create: (context) =>
              MealBloc(RepositoryProvider.of<MealRepository>(context))
                ..getMealById(widget.idMeal ?? ''),
          child: DetailMeal(),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 20),
        child: ButtonOrange(
          onPressed: () => context.push('${AppPath.order}/${widget.idMeal}'),
          title: 'ĐẶT NGAY NÈ',
        ),
      ),
    );
  }
}

class DetailMeal extends StatelessWidget {
  const DetailMeal({super.key});

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
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: 100,
                  //   child: Container(),
                  // ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        getStorageUrl(state.model.tray.imgUrl),
                        height: 300,
                        // width: 500,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 500,
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.model.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.model.kitchen.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${NumberFormat.decimalPattern().format(state.model.price)} VND',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Thời gian đóng đơn: ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      DateFormat('kk:mm:ss \n d MMMM yyyy')
                                          .format(state.model.closeTime),
                                      style: const TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.production_quantity_limits,
                              size: 30,
                            ),
                            Text(
                              state.model.serviceQuantity.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(width: 30),
                            const Icon(
                              Icons.star,
                              size: 30,
                            ),
                            const Text(
                              ' 4.7',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text('Mô Tả',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(state.model.tray.description),
                        const SizedBox(height: 10),
                        const Text('Phản Hồi',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ));
            }
            return Container();
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
