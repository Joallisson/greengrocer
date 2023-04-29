import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/commom_widgets/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class ProductScreen extends StatelessWidget {
  final ItemModel item;
  final UtilsServices utilsServices = UtilsServices();

  ProductScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withAlpha(230),
        body: Stack(
          children: [
            //Conteúdo
            Column(
              children: [
                //IMAGEM
                Expanded(
                  child: Hero(
                    tag: item.imgUrl,
                    child: Image.asset(item.imgUrl)
                  )
                ),

                //INFORMAÇÕES
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade600,
                              offset: const Offset(0, 2))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //Nome - Quantidade
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.itemName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              
                              QuantityWidget(),
                            ],
                          ),

                          //Preço
                          Text(
                            utilsServices.priceToCurrency(item.price),
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.customSwatchColor),
                          ),

                          //Descrição
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SingleChildScrollView(
                                child: Text(
                                  item.description,
                                  style: const TextStyle(height: 1.5),
                                ),
                              ),
                            ),
                          ),

                          //Botão
                          SizedBox(
                            height: 55,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () {},
                              label: const Text(
                                "Adicionar ao Carrinho",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),

            //Botão de voltar pra Home
            Positioned(
                top: 10,
                left: 10,
              child: SafeArea(
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
