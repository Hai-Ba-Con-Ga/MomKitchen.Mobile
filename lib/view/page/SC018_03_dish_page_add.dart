import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../data/dish_api.dart';
import '../../data/storage_api.dart';
import '../../model/dish_model.dart';
import '../../repository/dish_repository.dart';
import '../../router/router.dart';
import '../../utils/palette.dart';
import '../widgets/button_back.dart';
import '../widgets/button_orange.dart';

class AddDishPage extends StatefulWidget {
  const AddDishPage({Key? key}) : super(key: key);
  @override
  _AddDishPageState createState() => _AddDishPageState();
}

class _AddDishPageState extends State<AddDishPage> {
  File? _image;
  XFile? _fimage;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodDescriptionController = TextEditingController();

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
        title: Text('Thêm Món Ăn'),
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
              const Text('TÊN MÓN ĂN', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              TextFormField(
                controller: _foodNameController,
                decoration: InputDecoration(
                  hintText: 'Nhập tên món ăn',
                  hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color(0xFFF0F5FA),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên món ăn';
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
                    return 'Vui lòng nhập tên món ăn';
                  }
                  return null;
                },
              ),
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

      var prefs = await SharedPreferences.getInstance();
      kitchenId = prefs.getString('kitchenId');

      if (_fimage != null) {
        var storageApi = StorageApi();
        urlImage = await storageApi.createStorage(_fimage!);
        // Logger().i(urlImage);
      } else {}

      DishRepository dishRepository = DishRepository(dishApi: DishApi());
      Dish dishRequest = Dish(
        kitchenId: kitchenId,
        name: foodName,
        imageUrl: urlImage,
        description: foodDescription,
      );
      await dishRepository.createDish(dishRequest);

      Logger().i('Tạo món ăn thành công');

      context.go('${AppPath.kitchenmanager}/2');
    } else {
      Logger().i('Không tạo được món ăn');
    }
  }
}
