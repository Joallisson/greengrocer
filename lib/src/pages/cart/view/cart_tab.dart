import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/pages/cart/view/components/cart_tile.dart';
import 'package:greengrocer/src/pages/commom_widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/config/app_data.dart' as appData;

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  double cartTotalPrice() {
    // double total = 0;
    // for (var item in appData.cartItems) {
    //   total += item.totalPrice();
    // }

    // return total;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
      body: Column(
        children: [
          //Listagem de produtos do carrinho
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, index) {
                    return CartTile(
                      cartItem: controller.cartItems[index],
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Total geral
                const Text(
                  "Total Geral",
                  style: TextStyle(fontSize: 12),
                ),

                //Preço total
                GetBuilder<CartController>(
                  builder: (controller) {
                    return Text(
                      utilsServices.priceToCurrency(controller.cartTotalPrice()),
                      style: TextStyle(
                        fontSize: 23,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                //Botão concluir pedido
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.customSwatchColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18))),
                      onPressed: () async {
                        bool? result = await showOrderConfirmation();

                        if (result ?? false) {
                          showDialog(
                            context: context,
                            builder: (_) => PaymentDialog(
                              order: appData.orders.first,
                            ),
                          );
                        } else {
                          utilsServices.showToast(
                              //context: context,
                              message: "Pedido não confirmado",
                              isError: true);
                        }
                      },
                      child: const Text(
                        "Concluir pedido",
                        style: TextStyle(fontSize: 18),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text("Confirmação"),
            content: const Text("Deseja realmente concluir o seu pedido?"),
            actions: [
              //BOTÃO DE NÃO
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("Não")),

              //BOTÃO DE SIM
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Sim"))
            ],
          );
        });
  }
}