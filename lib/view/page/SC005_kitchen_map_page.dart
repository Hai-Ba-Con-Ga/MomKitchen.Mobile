import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/area/area_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/area_api.dart';
import '../../model/area_model.dart';
import '../../repository/area_repository.dart';
import '../../router/router.dart';
import '../widgets/base_ListTile.dart';
import '../widgets/button_back.dart';

class KitchenMapPage extends StatefulWidget {
  const KitchenMapPage({super.key});

  @override
  State<KitchenMapPage> createState() => _KitchenMapPageState();
}

class _KitchenMapPageState extends State<KitchenMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(onPressed: () => context.go(AppPath.home)),
        leadingWidth: 70,
        toolbarHeight: 100,
        title: const Text('Location'),
      ),
      body: RepositoryProvider(
        create: (context) => AreaRepository(areaApi: AreaApi()),
        child: BlocProvider(
          create: (context) => AreaBloc(RepositoryProvider.of<AreaRepository>(context))..getArea(),
          child: ListArea(),
        ),
      ),
    );
  }
}

class ListArea extends StatelessWidget {
  const ListArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final myBloc = context.read<AreaBloc>();
    return BlocBuilder(
      bloc: myBloc,
      builder: (context, state) {
        if (state is CommonState) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          } else if (state is CommonState<List<Area>>) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return BaseListTile(
                  icon: Icon(Icons.location_on, color: Colors.blueAccent),
                  title: Text(state.model[index].name, style: TextStyle(fontSize: 20)),
                  description: Text(
                    'Giao tinh quan tu nhat nhu nuoc, ket giao tieu nhan ngot ruou nong',
                    style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
                  ),
                );
              },
              itemCount: state.model.length,
            );
          }
          return Container();
        } else if (state is CommonState<List<Area>>) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return BaseListTile(
                icon: Icon(Icons.notifications, color: Colors.red),
                title: Text(state.model[index].name, style: TextStyle(fontSize: 20)),
                description: Text(
                  'Giao tinh quan tu nhat nhu nuoc, ket giao tieu nhan ngot ruou nong',
                  style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
                ),
              );
            },
            itemCount: state.model.length,
          );
        } else {
          return Center(child: Text("hihi"));
        }
      },
    );
  }
}
