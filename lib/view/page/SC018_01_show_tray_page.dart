import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../bloc/area/tray_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/tray_api.dart';
import '../../model/tray_model.dart';
import '../../repository/tray_repository.dart';
import '../../router/router.dart';
import '../../utils/palette.dart';
import '../../utils/utils.dart';
import '../widgets/base_ListTile.dart';

class ShowTrayPage extends StatefulWidget {
  const ShowTrayPage({super.key});

  @override
  State<ShowTrayPage> createState() => _ShowTrayPageState();
}

class _ShowTrayPageState extends State<ShowTrayPage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => TrayRepository(trayApi: TrayApi()),
        child: BlocProvider(create: (context) => TrayBloc(RepositoryProvider.of<TrayRepository>(context))..getTray(), child: const ListTray()));
  }
}

class ListTray extends StatelessWidget {
  const ListTray({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final trayBloc = context.read<TrayBloc>();
    return BlocBuilder(
        bloc: trayBloc,
        builder: (context, state) {
          if (state is CommonState) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            } else if (state is CommonState<List<Tray>>) {
              return Scaffold(
                body: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: BaseListTile(
                          onPressed: () {
                            Navigator.pop(context, jsonEncode(state.model[index]));
                          },
                          // icon: const Icon(Icons.image, color: Colors.red, size: 50),
                          image: Image.network(
                            getStorageUrl(state.model[index].imgUrl ?? "https://picsum.photos/250?image=9"),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(state.model[index].name ?? "Mon Ngon", style: TextStyle(fontSize: 20)),
                          description: Text(
                            (truncateText("Giá: " + state.model[index].price.toString() ?? "Lorem ipsum dolor sit amet", 30)),
                            style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
                          ),
                          // time: const Text('10-10-2021'),
                        ),
                      );
                    },
                    itemCount: state.model.length),
              );
            }
            return Container();
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
