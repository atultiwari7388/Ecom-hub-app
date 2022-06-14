import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          Image.asset(
            "assets/images/product_0.png",
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.cover,
          ),
          SizedBox(height: defaultPadding * 1.2),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                defaultPadding,
                defaultPadding * 1.5,
                defaultPadding,
                defaultPadding,
              ),
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadius * 3),
                  topRight: Radius.circular(defaultBorderRadius * 3),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Product Title",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        Text(
                          "\₹" + "200",
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    //description
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: Text(
                          "Dolor lorem stet rebum invidunt ut, takimata dolor et aliquyam dolor labore sit eirmod sadipscing labore, et kasd dolor dolor justo dolore. Sed labore sanctus duo dolor takimata. Accusam eos takimata sit clita, dolores dolore sed sit ea takimata invidunt eos, et at justo sadipscing et sadipscing et. Lorem amet."),
                    ),
                    SizedBox(height: defaultPadding * 2),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 48,
                        child: ElevatedButton(
                          child: Text("Add To cart"),
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            shape: StadiumBorder(),
                            elevation: 0,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
