import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/order_model.dart';
import '../utils/constants.dart';

class OrderApi {
  final Dio _dio = Dio();
  OrderApi() {
    _dio.options.baseUrl = '${AppConstants.localhostAdress}/order';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<void> createOrder(
      int totalQuantity, String userId, String idMeal) async {
    try {
      Logger log = Logger();
      log.i(totalQuantity);
      log.i(userId);
      log.i(idMeal);
      Response response = await _dio.post('', data: {
        'totalQuantity': totalQuantity,
        'userId': userId,
        'mealId': idMeal,
        'orderPayments': [
          {
            'amount': 0,
            'limitMonth': 0,
            'paymentTypeId': '3fa85f64-5717-4562-b3fc-2c963f66afa6'
          }
        ]
      });
      // Logger().i(response.data['data']);

      // Put order's status to PAID
      Response r = await _dio.put('', data: {
        'orderStatus': 'PAID',
        'orderID': response.data['data'],
      });
    } catch (error) {
      Logger().e('Error creating Meal: $error');
      throw error;
    }
  }

  Future<List<Order>> getAllOrderByUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? customerId = prefs.getString('customerId');
      Response response = await _dio.get('/', queryParameters: {
        'PageNumber': '1',
        'PageSize': '10',
        'OwnerId': customerId,
        'OrderBy': 'UpdatedDate:desc',
      });
      List<dynamic> OrdersData = response.data['data'] as List<dynamic>;
      // Logger().i(response.data['data']);
      List<Order> Orders =
          OrdersData.map((data) => Order.fromJson(data)).toList();
      return Orders;
    } catch (error) {
      Logger().e('Error fetching Orders: $error');
      rethrow;
    }
  }

  Future<Order> getOrderById(String OrderId) async {
    try {
      Response response = await _dio.get('/$OrderId');
      Order order = Order.fromJson(response.data['data']);
      return order;
    } catch (error) {
      Logger().e('Error fetching Order by ID: $error');
      rethrow;
    }
  }

  Future<List<Order>> getAllOrderByKitchenId(String status) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? kitchenId = prefs.getString('kitchenId');
      Logger().i('kitchenid: $kitchenId, status: $status');
      Response response = await _dio.get('', queryParameters: {
        'KitchenId': kitchenId,
        'OrderStatus': status,
        'OrderBy': 'UpdatedDate:desc',
      });
      List<dynamic> OrdersData = response.data['data'] as List<dynamic>;
      Logger().i(response.data['data']);
      List<Order> Orders = OrdersData.map((data) => Order.fromJson(data)).toList();
      return Orders;
    } catch (error) {
      Logger().e('Error fetching Orders: $error');
      rethrow;
    }
  }
}
