import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/models/user_model.dart';

import '../models/order_model.dart';

ItemModel apple = ItemModel(
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  imgUrl: 'assets/fruits/apple.png',
  itemName: 'Maçã',
  price: 5.5,
  unit: 'kg',
);

ItemModel grape = ItemModel(
  imgUrl: 'assets/fruits/grape.png',
  itemName: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  imgUrl: 'assets/fruits/guava.png',
  itemName: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  imgUrl: 'assets/fruits/kiwi.png',
  itemName: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  imgUrl: 'assets/fruits/mango.png',
  itemName: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  imgUrl: 'assets/fruits/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

List<String> categories = [
  "Frutas",
  "Grãos",
  "Verduras",
  "Temperos",
  "Cereais",
];

List<CartItemModel> cartItems = [
  CartItemModel(
    item: apple,
    quantity: 2,
  ),
  CartItemModel(
    item: mango,
    quantity: 1,
  ),
  CartItemModel(
    item: guava,
    quantity: 3,
  ),
];

UserModel user = UserModel(
  name: "joão",
  email: "joão@teste.com",
  phone: "99 99999-9999",
  cpf: "123.456.789-10",
  password: "",
);

List<OrderModel> orders = [
  //Pedido 01
  OrderModel(
    id: "kjdJh3Fugsa76",
    createdDateTime: DateTime.parse('2023-06-06 12:00:10.458'),
    overdueDateTime: DateTime.parse('2023-06-06 13:00:10.458'),
    items: [
      CartItemModel(item: apple, quantity: 3),
      CartItemModel(item: mango, quantity: 2),
      CartItemModel(item: guava, quantity: 1),
    ],
    status: "pending_payment",
    copyAndPaste: "qwyhvJHVhvJH676",
    total: 11,
  ),

  //Pedido 02
  OrderModel(
    id: "u3235iuotU87bnb",
    createdDateTime: DateTime.parse('2023-06-06 12:00:10.458'),
    overdueDateTime: DateTime.parse('2023-06-06 13:00:10.458'),
    items: [
      CartItemModel(item: apple, quantity: 2),
      CartItemModel(item: mango, quantity: 2),
    ],
    status: "paid",
    copyAndPaste: "qwyhvJHVhvJH676",
    total: 11,
  ),

  //Pedido 3
  OrderModel(
    id: "u32U8786IldKnbnb",
    createdDateTime: DateTime.parse('2023-06-06 12:00:10.458'),
    overdueDateTime: DateTime.parse('2023-06-06 13:00:10.458'),
    items: [
      CartItemModel(item: guava, quantity: 1),
    ],
    status: "delivered",
    copyAndPaste: "qwyhvJHVhvJH676",
    total: 11,
  ),

  //Pedido 04
  OrderModel(
    id: "u3235iuotU87bnb",
    createdDateTime: DateTime.parse('2021-06-08 10:00:10.458'),
    overdueDateTime: DateTime.parse('2021-06-08 11:00:10.458'),
    items: [
      CartItemModel(item: apple, quantity: 2),
      CartItemModel(item: mango, quantity: 2),
    ],
    status: "pending_payment",
    copyAndPaste: "qwyhvJHVhvJH676",
    total: 11,
  ),

  //Pedido 5
  OrderModel(
    id: "u32U8786IldKnbnb",
    createdDateTime: DateTime.parse('2021-06-10 12:00:10.458'),
    overdueDateTime: DateTime.parse('2021-06-10 13:00:10.458'),
    items: [
      CartItemModel(item: guava, quantity: 1),
    ],
    status: "refunded",
    copyAndPaste: "qwyhvJHVhvJH676",
    total: 11,
  ),
];
