import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/orders/components/order_status_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  OrderTile({
    required this.order,
    super.key,
  });

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: order.status == 'pending_payment',
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pedido: ${order.id}"),
                Text(
                  utilsServices.formatDateTime(order.createdDateTime),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                )
              ]),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  //LISTA DE PRODUTOS
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 150,
                      child: ListView(
                        children: order.items.map((orderItem) {
                          return _OrderItemWidget(
                            utilsServices: utilsServices,
                            orderItem: orderItem,
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  //DIVISÃO
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    width: 8,
                  ),

                  //STATUS DO PEDIDO
                  Expanded(
                      flex: 2,
                      child: OrderStatusWidget(
                        status: order.status,
                        isOverdue:
                            order.overdueDateTime.isBefore(DateTime.now()),
                      )),
                ],
              ),
            ),

            //VALOR TOTAL
            Text.rich(
              TextSpan(style: const TextStyle(fontSize: 20), children: [
                const TextSpan(
                  text: "Total ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: utilsServices.priceToCurrency(order.total),
                )
              ]),
            ),

            //BOTÃO DE PAGAMENTO
            Visibility(
              visible: order.status == "pending_payment",
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                icon: Image.asset(
                  "assets/app_images/pix.png",
                  height: 18,
                ),
                label: const Text("Ver QR Code Pix"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    super.key,
    required this.orderItem,
    required this.utilsServices,
  });

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text("${orderItem.quantity} ${orderItem.item.unit} ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
        Expanded(
          child: Text(
            orderItem.item.itemName,
          ),
        ),
        Text(utilsServices.priceToCurrency(orderItem.totalPrice()))
      ]),
    );
  }
}
