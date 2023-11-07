import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../bloc/area/area_bloc.dart';
import '../../bloc/base_state.dart';
import '../../data/area_api.dart';
import '../../data/kitchen_api.dart';
import '../../model/area_model.dart';
import '../../model/auth_model.dart';
import '../../model/kitchen_model.dart';
import '../../repository/area_repository.dart';
import '../../repository/kitchen_repository.dart';
import '../../router/router.dart';
import '../../utils/palette.dart';
import '../widgets/base_ListTile.dart';
import '../widgets/button_back.dart';
import '../widgets/button_orange.dart';

class KitchenProfileEditPage extends StatefulWidget {
  const KitchenProfileEditPage({Key? key}) : super(key: key);
  final String? title = 'Tạo Căn Bếp cho bạn';
  @override
  _KitchenProfileEditPageState createState() => _KitchenProfileEditPageState();
}

class _KitchenProfileEditPageState extends State<KitchenProfileEditPage> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kitchenNameController = TextEditingController();
  final TextEditingController _addressNameController = TextEditingController();
  final TextEditingController _areaNameController = TextEditingController(text: "Chọn khu vực");

  Area? area;
  String? location;
  User? user;

  Future<void> _getImage() async {
    final picker1 = ImagePicker();
    final pickedFile = await picker1.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        toolbarHeight: 80,
        title: Text(widget.title!),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 3,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            children: <Widget>[
              GestureDetector(
                onTap: _getImage,
                child: _image == null
                    ? Container(
                        width: 100,
                        height: 100,
                        color: Colors.orange[100],
                        child: Icon(
                          Icons.camera_alt,
                          size: 40.0,
                          color: Colors.white,
                        ),
                      )
                    : Image.file(_image!),
              ),
              SizedBox(height: 20.0),
              const Text('TÊN QUÁN', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              TextFormField(
                controller: _kitchenNameController,
                decoration: InputDecoration(
                  hintText: 'NGUYEN VAN A',
                  hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color(0xFFF0F5FA),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              const Text('ĐỊA CHỈ', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              TextFormField(
                controller: _addressNameController,
                decoration: InputDecoration(
                  hintText: 'Số nhà, đường, phường, quận, thành phố...etc',
                  hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color(0xFFF0F5FA),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              const Text('KHU VỰC', style: TextStyle(fontSize: 16.0)),
              ElevatedButton(
                  onPressed: () async {
                    final resultArea = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectKitchenMap(),
                        ));
                    area = Area.fromJson(jsonDecode(resultArea));
                    setState(() {
                      _areaNameController.text = area?.name ?? "Chọn Khu Vực";
                    });
                  },
                  child: TextField(
                    controller: _areaNameController,
                    enabled: false,
                  )),
              SizedBox(height: 100.0),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width * 0.9,
        child: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // Thực hiện lưu dữ liệu món ăn ở đây
              String kitchenName = _kitchenNameController.text;
              String addressName = _addressNameController.text;
              String areaId = area?.id ?? "";

              var prefs = await SharedPreferences.getInstance();
              var user = await prefs.getString('userData');
              var kitchenId = await prefs.getString('kitchenId');
              if (user != null) {
                User userData = User.fromJson(jsonDecode(user));
                KitchenRepository kitchenRepository = KitchenRepository(kitchenApi: KitchenApi());
                KitchenRequest kitchenRequest = KitchenRequest(
                  name: kitchenName,
                  address: addressName,
                  status: "ACTIVE",
                  location: Location(lat: 0, lng: 0),
                  areaId: areaId,
                  ownerId: userData.id,
                );
                await kitchenRepository.CreateKitchen(kitchenRequest);
                context.go('${AppPath.kitchenhome}');
              } else {
                Logger().e("User is null");
              }
            }
            // context.go('${AppPath.kitchenprofile}');
          },
          child: const Icon(Icons.add),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}

class SelectKitchenMap extends StatefulWidget {
  const SelectKitchenMap({super.key});

  @override
  State<SelectKitchenMap> createState() => _SelectKitchenMapState();
}

class _SelectKitchenMapState extends State<SelectKitchenMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(),
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

class ListArea extends StatefulWidget {
  const ListArea({
    super.key,
    this.onSuccess,
  });
  final Function? onSuccess;

  @override
  State<ListArea> createState() => _ListAreaState();
}

class _ListAreaState extends State<ListArea> {
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
                  icon: const Icon(Icons.location_on, color: Colors.blueAccent),
                  title: Text(state.model[index].name, style: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pop(context, jsonEncode(state.model[index]));
                  },
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
                icon: const Icon(Icons.notifications, color: Colors.red),
                title: Text(state.model[index].name, style: const TextStyle(fontSize: 20)),
                onPressed: () {},
                // description: const Text(
                //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                //   style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
                // ),
              );
            },
            itemCount: state.model.length,
          );
        } else {
          return const Center(child: Text("hihi"));
        }
      },
    );
  }
}
