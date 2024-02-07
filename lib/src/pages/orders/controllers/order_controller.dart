import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';

class OrderController extends GetxController {
  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();

  Future<void> getOrderItems() async {
    await ordersRepository.getOrderItems(
      orderId: orderId,
      token: authController.user.token!,
    );
  }
}
