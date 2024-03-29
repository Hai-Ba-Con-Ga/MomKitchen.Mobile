import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/area/tray_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/tray_api.dart';
import '../../model/tray_model.dart';
import '../../repository/tray_repository.dart';
import '../../router/router.dart';
import '../../utils/palette.dart';
import '../../utils/utils.dart';

class TrayPage extends StatefulWidget {
  const TrayPage({super.key});

  @override
  State<TrayPage> createState() => _TrayPageState();
}

class _TrayPageState extends State<TrayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => TrayRepository(trayApi: TrayApi()),
        child: BlocProvider(
          create: (context) => TrayBloc(RepositoryProvider.of<TrayRepository>(context))..getTray(),
          child: ListTray(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await context.push(AppPath.addtray);
        },
        child: const Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
    );
  }
}

class ListTray extends StatelessWidget {
  const ListTray({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final myBloc = context.read<TrayBloc>();
    return BlocBuilder(
        bloc: myBloc,
        builder: (context, state) {
          if (state is CommonState) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            } else if (state is CommonState<List<Tray>>) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      // width: 50,
                      height: 170,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Card(
                        elevation: 0,
                        color: const Color(0xFFECF0F4),
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(
                            children: [
                              Image.network(
                                getStorageUrl(state.model[index].imgUrl ?? "https://picsum.photos/250?image=9"),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(truncateText(state.model[index].name ?? "Mâm Cỗ", 15), style: TextStyle(fontSize: 20)),
                                  SizedBox(height: 10),
                                  Text(
                                    truncateText(state.model[index].description ?? "Bữa Tiệc dành cho gia đình", 25),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text((state.model[index].price ?? 75000).toString() + 'đ', style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 50,
                                  width: 100,
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextButton(onPressed: () {}, child: const Text('Sửa', style: TextStyle(color: Colors.white, fontSize: 12))),
                                ),
                                Container(
                                  height: 50,
                                  width: 100,
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextButton(
                                      onPressed: () {
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
                                                    myBloc.deleteTray(state.model[index].id!);
                                                  },
                                                  child: Text('Xóa'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text('xóa', style: TextStyle(color: Colors.white, fontSize: 12))),
                                ),
                              ],
                            ),
                          )
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
