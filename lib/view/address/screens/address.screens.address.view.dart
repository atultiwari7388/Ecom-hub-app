import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ecom_hub/common/widgets/custom_button.widget.common.dart';
import 'package:ecom_hub/provider/user.provider.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/utils/utils.dart';
import 'package:ecom_hub/view/address/services/adress_service.dart';
import 'package:ecom_hub/view/auth/widgets/custom_text_field.widgets.auth.view.dart';
import 'package:ecom_hub/view/cart/widgets/subtotal.widgets.cart.view.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "address-screen";
  final String totalAmount;
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController flatBuildingController = TextEditingController();
  TextEditingController areaStreet = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController townCity = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = "";

  List<PaymentItem> paymentItems = [];
  AddressServices _addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaStreet.dispose();
    pinCode.dispose();
    townCity.dispose();
    super.dispose();
  }

  void onGooglePayResult(result) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      _addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    _addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payFinalAmount(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaStreet.text.isNotEmpty ||
        pinCode.text.isNotEmpty ||
        townCity.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatBuildingController.text}, ${areaStreet.text}, ${townCity.text}- ${pinCode.text},";
      } else {
        throw Exception("Please Enter Valid Address");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBarMessage(
          context, "Error", "Someting went wrong", ContentType.warning);
    }
  }

  @override
  Widget build(BuildContext context) {
    var userAddress = Provider.of<UserProvider>(context).user.address;
    final user = Provider.of<UserProvider>(context).user;
    int sum = 0;
    //map through the cart items and add the price to the sum

    user.cart
        .map((e) => sum += e['quantity'] * e["product"]["price"] as int)
        .toList();
    double deliveryFee = 50.20;

    double totalPrice = sum + deliveryFee;

    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: kPrimaryColor),
        ),
        title: Text(
          "Checkout",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: defaultPadding + 4),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Delivery Address",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: defaultPadding * 2),
            if (userAddress.isNotEmpty)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: defaultPadding, right: defaultPadding),
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: kbgColor,
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        userAddress.toString(),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: kPrimaryColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  Center(child: Text("Or")),
                ],
              ),
            SizedBox(height: defaultPadding),
            Form(
              key: _addressFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    controller: flatBuildingController,
                    hintText: "Flat, House no., Building",
                    imagePath: "assets/icons/home.svg",
                  ),
                  SizedBox(height: defaultPadding),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    controller: areaStreet,
                    hintText: "Area, Street",
                    imagePath: "assets/icons/home.svg",
                  ),
                  SizedBox(height: defaultPadding),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    controller: pinCode,
                    hintText: "pincode",
                    imagePath: "assets/icons/home.svg",
                  ),
                  SizedBox(height: defaultPadding),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    controller: townCity,
                    hintText: "Town, City",
                    imagePath: "assets/icons/home.svg",
                  ),
                  SizedBox(height: defaultPadding * 1.5),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Billing information",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: defaultPadding * 2),
                  //payment information
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: defaultPadding - 3,
                              right: defaultPadding,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery fee :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: kPrimaryColor),
                                ),
                                SizedBox(width: defaultPadding),
                                Text(
                                  "₹" + deliveryFee.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          CartSubTotal(),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: defaultPadding - 3,
                              right: defaultPadding,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: kPrimaryColor),
                                ),
                                SizedBox(width: defaultPadding),
                                Text(
                                  "₹" + totalPrice.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //payment method

                  SizedBox(height: defaultPadding * 2),
                  // CustomButton(text: "Buy Now", onTap: () {}),
                  GooglePayButton(
                    style: GooglePayButtonStyle.black,
                    type: GooglePayButtonType.buy,
                    onPressed: () => payFinalAmount(userAddress),
                    width: double.maxFinite,
                    height: 50,
                    margin: EdgeInsets.only(top: 15),
                    paymentConfigurationAsset: "gpay.json",
                    onPaymentResult: onGooglePayResult,
                    paymentItems: paymentItems,
                    loadingIndicator: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                  CustomButton(
                    text: "Cash on Delivery",
                    onTap: () => payFinalAmount(userAddress),
                  ),
                  SizedBox(height: defaultPadding * 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
