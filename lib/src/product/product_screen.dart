import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/item_model.dart';

class ProductScreen extends StatelessWidget {
  final ItemModel item;

  const ProductScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withAlpha(230),
        body: Column(
          children: [

            //IMAGEM
            Expanded(
              child: Image.asset(item.imgUrl)
            ),

            //INFORMAÇÕES
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(50)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset: const Offset(0, 2)
                    )
                  ]
                ),
              ),
            )
          ],

        ));
  }
}
