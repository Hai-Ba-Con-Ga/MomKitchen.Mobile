import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../bloc/area/kitchen_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/kitchen_api.dart';
import '../../model/kitchen_model.dart';
import '../../repository/kitchen_repository.dart';
import '../../repository/meal_repository.dart';
import '../../utils/utils.dart';

class KitchenPage extends StatefulWidget {
  const KitchenPage(
      {super.key,
      required this.kitchenId,
      required this.kitchenImg,
      required this.kitchenName,
      required this.kitchenAddress});
  final String kitchenId;
  final String kitchenImg;
  final String kitchenName;
  final String kitchenAddress;

  @override
  State<KitchenPage> createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
  @override
  Widget build(BuildContext context) {
    String img;
    if (widget.kitchenImg == null) {
      img = 'https://picsum.photos/250?image=9';
    } else {
      img = widget.kitchenImg;
    }
    Logger().i('kitchenId: ${widget.kitchenId}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang của Bếp'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black, // Màu sắc của viền dưới
                    width: 2.0, // Độ dày của viền
                  ),
                ),
              ),
              // color: Colors.grey.shade400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 120, // Độ rộng của hình ảnh món ăn
                        height: 120, // Chiều cao của hình ảnh món ăn
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            getStorageUrl('https://picsum.photos/250?image=9'),
                            width: 200, // Độ rộng của hình ảnh
                            height: 200, // Chiều cao của hình ảnh
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Text(widget.kitchenImg),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Bếp: ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.kitchenName,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Địa chỉ: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 210,
                                  child: Text(
                                    widget.kitchenAddress,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ), //widget.kitchenAddress
                            // Text(widget.kitchenAddress),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // RepositoryProvider(
            //   create: (context) => KitchenRepository(kitchenApi: KitchenApi()),
            //   child: BlocProvider(
            //     create: (context) => KitchenBloc(
            //         RepositoryProvider.of<KitchenRepository>(context))
            //       ..getAllMealKitchens(widget.kitchenId),
            //     child: ListMealOfKitchen(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class ListMealOfKitchen extends StatelessWidget {
//   const ListMealOfKitchen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final myBloc = context.read<KitchenBloc>();
//     return BlocBuilder(
//         bloc: myBloc,
//         builder: (context, state) {
//           if (state is CommonState) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (state.errorMessage != null) {
//               return Center(child: Text(state.errorMessage!));
//             } else if (state is CommonState<List<MealRepository>>) {
//               return GridView.count(
//                 crossAxisCount: 2,
//                 // crossAxisSpacing: 10.0,
//                 // mainAxisSpacing: 10.0,
//                 childAspectRatio: 95 / 100,
//                 children: List.generate(10, (index) {
//                   return Container(
//                     height: 10,
//                     width: 10,
//                     child: Text('Món '),
//                   );
//                 }),
//               );
//             }
//             return Container();
//           }
//           return const Center(child: CircularProgressIndicator());
//         });
//   }
// }
