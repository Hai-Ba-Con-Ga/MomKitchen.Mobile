import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../data/tray_api.dart';
import '../../data/storage_api.dart';
import '../../model/dish_model.dart';
import '../../model/tray_model.dart';
import '../../repository/tray_repository.dart';
import '../../router/router.dart';
import '../../utils/palette.dart';
import '../widgets/button_back.dart';
import '../widgets/button_orange.dart';
import 'SC018_02_show_dish_page.dart';

class AddTrayPage extends StatefulWidget {
  const AddTrayPage({Key? key}) : super(key: key);
  @override
  _AddTrayPageState createState() => _AddTrayPageState();
}

class _AddTrayPageState extends State<AddTrayPage> {
  File? _image;
  XFile? _fimage;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodDescriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _listDishController = TextEditingController(text: 'Các Món Ăn');
  List<String> listDishId = [];

  Future<void> _getImage() async {
    final picker1 = ImagePicker();
    final pickedFile = await picker1.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _fimage = pickedFile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(onPressed: () => context.pop()),
        leadingWidth: 70,
        toolbarHeight: 80,
        title: Text('Thêm Mâm Cơm'),
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
              const Text('TÊN MÂM CƠM', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              TextFormField(
                controller: _foodNameController,
                decoration: InputDecoration(
                  hintText: 'Nhập tên mâm cơm',
                  hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color(0xFFF0F5FA),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên mâm cơm';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              const Text('MÔ TẢ', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              TextFormField(
                controller: _foodDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Mô tả chi tiết',
                  hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color(0xFFF0F5FA),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              const Text('GIÁ', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '30.000, 50.000...',
                  hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color(0xFFF0F5FA),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số lượng mâm cơm';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () async {
                    final resultDishes = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowDishPage(),
                        ));

                    listDishId = resultDishes.split(",");
                    Logger().i("List Dish ID from Add tray: $listDishId");
                    // setState(() {
                    //   _listDishController.text = resultDishes ?? "Các Món Ăn";
                    // });
                  },
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _listDishController,
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
          onPressed: addAction,
          child: const Icon(Icons.add),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }

  void addAction() async {
    if (_formKey.currentState!.validate()) {
      String? kitchenId = '';
      String foodName = _foodNameController.text;
      String? urlImage;
      String foodDescription = _foodDescriptionController.text;
      int? price = int.parse(_priceController.text);

      var prefs = await SharedPreferences.getInstance();
      kitchenId = prefs.getString('kitchenId');

      if (_fimage != null) {
        var storageApi = StorageApi();
        urlImage = await storageApi.createStorage(_fimage!);
        // Logger().i(urlImage);
      } else {}

      TrayRepository trayRepository = TrayRepository(trayApi: TrayApi());
      TrayCreateRequest trayRequest = TrayCreateRequest(
        kitchenId: kitchenId,
        name: foodName,
        imgUrl: urlImage,
        description: foodDescription,
        price: price,
        dishIds: listDishId,
      );
      await trayRepository.createTray(trayRequest);

      Logger().i('Tạo mâm cơm thành công');

      context.go('${AppPath.kitchenmanager}/1');
    } else {
      Logger().i('Không tạo được mâm cơm');
    }
  }
}
