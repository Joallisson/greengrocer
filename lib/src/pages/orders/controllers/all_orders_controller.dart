import 'package:get/get.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AllOrdersController extends GetxController {
  final orderRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();
  List<OrderModel> allOrders = [];

  @override
  onInit(){
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await orderRepository.getAllOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(
      success: (orders){
        allOrders = orders;
        update();
      },
      error: (message){
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
