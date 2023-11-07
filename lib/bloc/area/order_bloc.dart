import '../../model/order_model.dart';
import '../../repository/order_repository.dart';
import '../base_cubit.dart';
import '../base_state.dart';

class OrderBloc extends BaseCubit {
  OrderBloc(this._orderRepository) : super(InitialState());
  final OrderRepository _orderRepository;
  void init() {}

  Future<void> getAllOrderByUserId() async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final orders = await _orderRepository.getAllOrderByUserId();
      emit(
        CommonState<List<Order>>(
          orders,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        CommonState(
          null,
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> getOrderById(String orderId) async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final order = await _orderRepository.getOrderById(orderId);
      emit(
        CommonState<Order>(
          order,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        CommonState(
          null,
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> getAllOrderByKitchenId(String status) async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final orders = await _orderRepository.getAllOrderByKitchenId(status);
      emit(
        CommonState<List<Order>>(
          orders,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        CommonState(
          null,
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
