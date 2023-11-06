import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/area/meal_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/meal_api.dart';
import '../../model/meal_model.dart';
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
                      Row(
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
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Image.asset('assets/images/googlemap_illustrator.png')),
            Container(
              width: 1000,
              height: 100,
              child: const BaseDatePicker(
                restorationId: 'main',
              ),
            ),
            const ListTile(
              title: Text('Recent Kitchen'),
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
            const ListTile(
              title: Text('Top Trending'),
            ),
            const ListTile(
              title: Text('Favorite kitchen'),
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
