import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_hub/models/orders.models.dart';
import 'package:ecom_hub/view/account/services/account.services.account.view.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/colors.utils.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderModel>? ordersList;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrdersData();
  }

  void fetchOrdersData() async {
    ordersList = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("My Orders",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: kPrimaryColor)),
        centerTitle: true,
        leading: BackButton(color: kPrimaryColor),
      ),
      body: ordersList == null
          ? Center(
              child: Lottie.asset("assets/not-found.json"),
            )
          : ListView.builder(
              itemCount: ordersList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final orderData = ordersList![index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //image Section
                          CachedNetworkImage(
                            imageUrl: orderData.products[0].images[0],
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 35,
                              backgroundImage: imageProvider,
                            ),
                            placeholder: (context, url) => GFShimmer(
                              child: CircleAvatar(
                                radius: 35,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),

                          //product name section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(orderData.products[0].name),
                              Text(
                                  "₹" + orderData.products[0].price.toString()),
                            ],
                          ),
                          //quantity section
                          // SizedBox(width: defaultPadding),
                          Expanded(child: Text("Today")),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
