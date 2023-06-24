import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/pages/cart/repository/cart_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  int getCartTotalItems() {  
    return cartItems.isEmpty
                ? 0 
                : cartItems.map((e) => e.quantity).reduce((a, b) => a + b);
  }

  double cartTotalPrice() {
    double total = 0;

    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      cartItemId: item.id,
      token: authController.user.token!,
      quantity: quantity,
    );

      if(result){
        if (quantity == 0) {
          cartItems.removeWhere((cartItem) => cartItem.id == item.id);
        } else {
          cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity = quantity;
        }

        update();
      }else{
        utilsServices.showToast(
          message: 'Ocorreu um erro ao alterar a quantidade do produto',
          isError: true,
        );
      }

    return result;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: (data) {
        cartItems = data;
        update();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];

      await changeItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );

    } else {
      final CartResult result = await cartRepository.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        productId: item.id!,
        quantity: quantity,
      );

      result.when(
        success: (cartItem) {
          cartItems.add(
            CartItemModel(
              item: item,
              quantity: quantity,
              id: cartItem,
            ),
          );
        },
        error: (message) {
          utilsServices.showToast(
            message: message,
            isError: true,
          );
        },
      );
    }

    update();
  }
}
