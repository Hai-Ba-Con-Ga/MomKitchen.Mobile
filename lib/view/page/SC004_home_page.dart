import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/area/kitchen_bloc.dart';
import '../../bloc/area/meal_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/kitchen_api.dart';
import '../../data/meal_api.dart';
import '../../model/kitchen_model.dart';
import '../../model/meal_model.dart';
import '../../repository/kitchen_repository.dart';
import '../../repository/meal_repository.dart';
import '../../router/router.dart';
import '../../utils/palette.dart';
import '../../utils/utils.dart';
import '../widgets/base_date_picker.dart';
import '../widgets/button_orange.dart';
import '../widgets/card_dish.dart';
import 'SC018_01_meal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Container(
            alignment: Alignment.centerLeft,
            child: TextField(
              controller: _searchTextController,
              decoration: InputDecoration(
                hintText: 'Search',
                fillColor: const Color(0xddddddFF),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                // conteprefixIconntPadding: EdgeInsets.only(right: 50),
                // prefixIconConstraints: BoxConstraints(
                //   minWidth: 80,
                // ),
                prefixIcon: GestureDetector(
                  onTap: () {
                    if (_searchTextController.text.isEmpty) {
                      return;
                    }
                    context.push(
                        '${AppPath.search}/${_searchTextController.text}');
                  },
                  child: const Icon(Icons.search),
                ),
                suffixIcon: _searchTextController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchTextController.clear();
                        },
                        icon: const Icon(Icons.cancel))
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () => context.push(AppPath.listOrder),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xddddddFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.receipt_long_outlined,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () => context.push(AppPath.notification),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xddddddFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none_sharp,
                  ),
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KHU VỰC HIỆN TẠI',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                      const Row(
                        children: [
                          Text('Nhà Bè Hà Lan',
                              style: TextStyle(color: Color(0xFF676767))),
                          Icon(Icons.arrow_drop_down)
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child: ButtonOrange(
                        title: 'Xem bản đồ',
                        icon: Icons.location_on,
                        onPressed: () => context.push(AppPath.kitchenmap)),
                  ),
                ],
              ),
            ),
            // Container(
            //     padding: EdgeInsets.symmetric(vertical: 10),
            //     child: Image.asset('assets/images/googlemap_illustrator.png')),
            Container(
              width: 1000,
              height: 100,
              child: const BaseDatePicker(
                restorationId: 'main',
              ),
            ),
            const ListTile(
              title: Text('Món ngon'),
            ),
            RepositoryProvider(
              create: (context) => MealRepository(mealApi: MealApi()),
              child: BlocProvider(
                create: (context) =>
                    MealBloc(RepositoryProvider.of<MealRepository>(context))
                      ..getMeal(),
                child: Meals(),
              ),
            ),
            // const ListTile(
            //   title: Text('Top Trending'),
            // ),
            // RepositoryProvider(
            //   create: (context) => MealRepository(mealApi: MealApi()),
            //   child: BlocProvider(
            //     create: (context) =>
            //         MealBloc(RepositoryProvider.of<MealRepository>(context))
            //           ..getMeal(),
            //     child: Meals(),
            //   ),
            // ),
            const ListTile(
              title: Text('Bếp nổi tiếng'),
            ),
            RepositoryProvider(
              create: (context) => KitchenRepository(kitchenApi: KitchenApi()),
              child: BlocProvider(
                create: (context) => KitchenBloc(
                    RepositoryProvider.of<KitchenRepository>(context))
                  ..getAllKitchens(),
                child: Kitchens(),
              ),
            ),
          ],
        ));
  }
}

class Meals extends StatelessWidget {
  const Meals({
    super.key,
  });

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
            } else if (state is CommonState<List<MealGetAllResponse>>) {
              return SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.model.length,
                  itemBuilder: (context, index) {
                    return CardDish(
                      onPressed: () => context.push(
                          '${AppPath.mealdetail}/${state.model[index].id}'),
                      nameMeal: state.model[index].name ?? '',
                      priceMeal: state.model[index].price ?? 0,
                      mealId: state.model[index].id ?? '',
                      imgUrl: state.model[index].tray?.imgUrl ?? '',
                      kitchenName: state.model[index].kitchen?.name ?? '',
                    );
                  },
                ),
              );
            }
            return Container();
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class Kitchens extends StatelessWidget {
  const Kitchens({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final myBloc = context.read<KitchenBloc>();
    return BlocBuilder(
        bloc: myBloc,
        builder: (context, state) {
          if (state is CommonState) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            } else if (state is CommonState<List<Kitchen>>) {
              return SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.model.length,
                  // itemCount: 10,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 200,
                      height: 200,
                      child: TextButton(
                        // onPressed: () => context.push(
                        //     '${AppPath.kitchenPage}/${state.model[index].id}'),
                        onPressed: () => context.push(
                            '${AppPath.kitchenPage}/${state.model[index].id}/${state.model[index].imgUrl}/${state.model[index].name}/${state.model[index].address}'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Container(
                          // color: Colors.red,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                height: 120,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 20,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 40, 10, 0),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        truncateText(
                                            state.model[index].name ??
                                                'Tên bếp',
                                            18),
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          truncateText(
                                              state.model[index].address ?? '',
                                              50),
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  // height: 100,
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 15),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.network(
                                        getStorageUrl(
                                            'https://picsum.photos/250?image=9'),
                                        fit: BoxFit.cover,
                                        height: 100,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
