import 'dart:convert';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../data/meal_api.dart';
import '../../data/storage_api.dart';
import '../../model/tray_model.dart';
import '../../model/meal_model.dart';
import '../../repository/meal_repository.dart';
import '../../router/router.dart';
import '../../utils/palette.dart';
import '../../utils/utils.dart';
import '../widgets/button_back.dart';
import '../widgets/button_orange.dart';
import 'SC018_01_show_tray_page.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({Key? key}) : super(key: key);
  @override
  _AddMealPageState createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  File? _image;
  XFile? _fimage;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodDescriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _serviceQuantityController = TextEditingController();
  final TextEditingController _listTrayController = TextEditingController(text: 'Mâm Cơm');

  final TextEditingController _startTimeController = TextEditingController(text: 'Chọn thời gian bắt đầu bữa ăn');
  final TextEditingController _endTimeController = TextEditingController(text: 'Chọn thời gian kết thúc bữa ăn');
  final TextEditingController _closeTimeController = TextEditingController(text: 'Chọn thời gian ngưng nhận đơn');

  DateTime? startTime;
  DateTime? endTime;
  DateTime? closeTime;

  Tray? tray;
  String? imgTray;

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
        title: Text('Thêm Bữa Ăn'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 3,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            children: <Widget>[
              imgTray == null
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
                  // : Image.file(_image!),
                  : Image.network(
                      getStorageUrl(imgTray ?? "https://picsum.photos/250?image=9"),
                      // width: 100,
                      // height: 100,
                      fit: BoxFit.cover,
                    ),
              SizedBox(height: 20.0),
              const Text('TÊN BỮA ĂN', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              TextFormField(
                controller: _foodNameController,
                decoration: InputDecoration(
                  hintText: 'Nhập tên bữa ăn',
                  hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color(0xFFF0F5FA),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên bữa ăn';
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
                    return 'Vui lòng nhập giá bữa ăn';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              const Text('SỐ LƯỢNG NGƯỜI PHỤC VỤ', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              TextFormField(
                controller: _serviceQuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '1, 2, 3...',
                  hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color(0xFFF0F5FA),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số lượng';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () async {
                    final resultTrayes = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowTrayPage(),
                        ));
                    tray = Tray.fromJson(jsonDecode(resultTrayes));
                    Logger().i("Tray: $tray");
                    setState(() {
                      _listTrayController.text = (tray?.name ?? "Các Món Ăn") + " - " + (tray?.price ?? 0).toString() + "đ";
                      imgTray = tray?.imgUrl;
                    });
                  },
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _listTrayController,
                    enabled: false,
                  )),
              SizedBox(height: 20.0),
              const Text('Thời gian bắt đầu bữa ăn', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              ElevatedButton(
                  onPressed: () {
                    BottomPicker.dateTime(
                      title: 'Thời gian bắt đầu bữa ăn',
                      titleStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.orange,
                      ),
                      onSubmit: (date) {
                        startTime = date;
                        _startTimeController.text = DateFormat('dd/MM/yyyy HH:mm:ss').format(startTime!);
                      },
                      onClose: () {
                        print('Picker closed');
                      },
                      iconColor: Colors.black,
                      minDateTime: DateTime.now(),
                      maxDateTime: DateTime.now().add(Duration(days: 30)),
                      initialDateTime: DateTime.now(),
                      gradientColors: [Color(0xfffdcbf1), Color(0xffe6dee9)],
                    ).show(context);
                  },
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _startTimeController,
                    enabled: false,
                  )),
              SizedBox(height: 20.0),
              const Text('Thời gian kết thúc bữa ăn', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              ElevatedButton(
                  onPressed: () {
                    BottomPicker.dateTime(
                      title: 'Thời gian kết thúc bữa ăn',
                      titleStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.orange,
                      ),
                      onSubmit: (date) {
                        endTime = date;
                        _endTimeController.text = DateFormat('dd/MM/yyyy HH:mm:ss').format(endTime!);
                      },
                      onClose: () {
                        print('Picker closed');
                      },
                      iconColor: Colors.black,
                      minDateTime: (startTime ?? DateTime.now()),
                      maxDateTime: (startTime ?? DateTime.now()).add(Duration(days: 30)),
                      initialDateTime: (startTime ?? DateTime.now()),
                      gradientColors: [Color(0xfffdcbf1), Color(0xffe6dee9)],
                    ).show(context);
                  },
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _endTimeController,
                    enabled: false,
                  )),
              SizedBox(height: 20.0),
              const Text('Thời gian ngưng nhận đơn', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 5.0),
              ElevatedButton(
                  onPressed: () {
                    BottomPicker.dateTime(
                      title: 'Thời gian ngưng nhận đơn',
                      titleStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.orange,
                      ),
                      onSubmit: (date) {
                        closeTime = date;
                        _closeTimeController.text = DateFormat('dd/MM/yyyy HH:mm:ss').format(closeTime!);
                      },
                      onClose: () {
                        print('Picker closed');
                      },
                      iconColor: Colors.black,
                      minDateTime: DateTime.now(),
                      maxDateTime: DateTime.now().add(Duration(days: 30)),
                      initialDateTime: DateTime.now(),
                      gradientColors: [Color(0xfffdcbf1), Color(0xffe6dee9)],
                    ).show(context);
                  },
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _closeTimeController,
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
      String foodDescription = _foodDescriptionController.text;
      int? price = int.parse(_priceController.text);
      int? serviceQuantity = int.parse(_serviceQuantityController.text);

      var prefs = await SharedPreferences.getInstance();
      kitchenId = prefs.getString('kitchenId');

      MealRepository mealRepository = MealRepository(mealApi: MealApi());
      MealCreateRequest mealRequest = MealCreateRequest(
        name: foodName,
        serviceFrom: startTime,
        serviceTo: endTime,
        price: price,
        serviceQuantity: serviceQuantity,
        closeTime: closeTime,
        kitchenId: kitchenId,
        trayId: tray?.id,
      );
      await mealRepository.createMeal(mealRequest);

      Logger().i('Tạo bữa ăn thành công');

      context.go('${AppPath.kitchenmanager}/0');
    } else {
      Logger().i('Không tạo được bữa ăn');
    }
  }
}
