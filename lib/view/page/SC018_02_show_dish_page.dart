import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../bloc/area/dish_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/dish_api.dart';
import '../../model/dish_model.dart';
import '../../repository/dish_repository.dart';
import '../../router/router.dart';
import '../../utils/palette.dart';
import '../../utils/utils.dart';
import '../widgets/base_ListTile.dart';
import 'SC018_03_dish_page_add.dart';

class ShowDishPage extends StatefulWidget {
  const ShowDishPage({super.key});

  @override
  State<ShowDishPage> createState() => _ShowDishPageState();
}

class _ShowDishPageState extends State<ShowDishPage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => DishRepository(dishApi: DishApi()),
        child: BlocProvider(create: (context) => DishBloc(RepositoryProvider.of<DishRepository>(context))..getDish(), child: const ListDish()));
  }
}

class ListDish extends StatelessWidget {
  const ListDish({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dishBloc = context.read<DishBloc>();
    Map<String, bool> checkDish = {};
    return BlocBuilder(
        bloc: dishBloc,
        builder: (context, state) {
          if (state is CommonState) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            } else if (state is CommonState<List<Dish>>) {
              return Scaffold(
                body: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), // Độ tròn là 50% của chiều rộng (50px)
                          border: Border.all(
                            color: (checkDish[state.model[index].id!] == true) ? Colors.orange : Colors.white, // Màu của viền (cam)
                            width: 5.0, // Độ dày của viền (5px)
                          ),
                        ),
                        child: BaseListTile(
                          onPressed: () {
                            if (checkDish[state.model[index].id] == true) {
                              checkDish[state.model[index].id!] = false;
                            } else {
                              checkDish[state.model[index].id!] = true;
                            }
                            dishBloc.reload();
                          },
                          // icon: const Icon(Icons.image, color: Colors.red, size: 50),
                          image: Image.network(
                            getStorageUrl(state.model[index].imageUrl ?? "https://picsum.photos/250?image=9"),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(state.model[index].name ?? "Mon Ngon", style: TextStyle(fontSize: 20)),
                          description: Text(
                            (truncateText(state.model[index].description ?? "Lorem ipsum dolor sit amet", 30)),
                            style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
                          ),
                          // time: const Text('10-10-2021'),
                        ),
                      );
                    },
                    itemCount: state.model.length),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    List<String> listDishId = [];
                    for (var i = 0; i < state.model.length; i++) {
                      if (checkDish[state.model[i].id] == true) {
                        listDishId.add(state.model[i].id!);
                      }
                    }
                    // Logger().i("List Dish ID: $listDishId");
                    Navigator.pop(context, listDishId.join(","));
                  },
                  child: const Icon(Icons.done),
                  backgroundColor: primaryColor,
                ),
              );
            }
            return Container();
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
