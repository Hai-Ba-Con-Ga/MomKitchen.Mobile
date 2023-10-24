import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

class DishPage extends StatefulWidget {
  const DishPage({super.key});

  @override
  State<DishPage> createState() => _DishPageState();
}

class _DishPageState extends State<DishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // padding: const EdgeInsets.only(top: 10),
      body: RepositoryProvider(
          create: (context) => DishRepository(dishApi: DishApi()),
          child: BlocProvider(create: (context) => DishBloc(RepositoryProvider.of<DishRepository>(context))..getDish(), child: const ListDish())),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await context.push(AppPath.adddish);
        },
        child: const Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
    );
  }
}

class ListDish extends StatelessWidget {
  const ListDish({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dishBloc = context.read<DishBloc>();
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
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return BaseListTile(
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
                      trailing: Container(
                        width: 20,
                        height: 100,
                        alignment: Alignment.center,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: GestureDetector(
                                onTap: () => dishBloc.deleteDish(
                                      state.model[index].id!,
                                    ),
                                child: Icon(Icons.edit, color: Colors.blue.withOpacity(0.8), size: 20)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Xác nhận xóa'),
                                        content: Text('Bạn có chắc muốn xóa món ăn này?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: Text('Hủy'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              dishBloc.deleteDish(state.model[index].id!);
                                            },
                                            child: Text('Xóa'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.delete, color: Colors.red.withOpacity(0.8), size: 20)),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.all(0.0),
                          //   child: IconButton(
                          //     icon: Icon(Icons.delete, color: Colors.red.withOpacity(0.8), size: 10),
                          //     onPressed: () => dishBloc.deleteDish(state.model[index].id!),
                          //   ),
                          // ),
                        ]),
                      ),
                    );
                  },
                  itemCount: state.model.length);
            }
            return Container();
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
