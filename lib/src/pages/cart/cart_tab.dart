import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/cart/components/cart_tile.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/config/app_data.dart' as appData;

class CartTab extends StatelessWidget {
  CartTab({super.key});

  final UtilsServices utilsServices = UtilsServices();

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
            child: ListView.builder(
              itemBuilder: (_,index){
                return CartTile(cartItem: appData.cartItems[index]);
              },
              itemCount: appData.cartItems.length,
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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
                Text(
                  utilsServices.priceToCurrency(50.5),
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //Botão concluir pedido
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)
                      )
                    ),
                    onPressed: (){}, 
                    child: const Text(
                      "Concluir pedido",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    )
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
