import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListDish extends StatefulWidget {
  const ListDish({super.key, required this.title});

  final String title;

  @override
  State<ListDish> createState() => _ListDishState();
}

class _ListDishState extends State<ListDish> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title),
          // onTap: () => context.go(AppPath.favorite),
        ),
        Container(
          height: 150,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  child: Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=400'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 255, 251, 244),
                        height: 30,
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Snack"),
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.favorite_border,
                              size: 15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: 10),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
