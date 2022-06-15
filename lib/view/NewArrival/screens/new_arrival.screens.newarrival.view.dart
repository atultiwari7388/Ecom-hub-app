import 'package:ecom_hub/common/widgets/section_title.widgets.common.dart';
import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/view/NewArrival/services/deal_of_the_day.service.screens.deals.view.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.utils.dart';
import '../../PopularProducts/widgets/product_card.widget.popular.view.dart';

class NewArrival extends StatefulWidget {
  const NewArrival({
    Key? key,
  }) : super(key: key);

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  DealsOfTheDayServices dealsOfTheDayServices = DealsOfTheDayServices();
  ProductModel? dealOfTheDay;

  @override
  void initState() {
    super.initState();
    fetchDealOfTheDayServices();
  }

  void fetchDealOfTheDayServices() async {
    dealOfTheDay = await dealsOfTheDayServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          onTap: () {},
          title: 'Deal of the Day',
        ),
        Container(
          height: 230,
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: ProductCard(
                  onTap: () {},
                  image:
                      "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fpurepng.com%2Fpublic%2Fuploads%2Flarge%2Fpurepng.com-womens-white-t-shirtt-shirtfabrict-shapegramnetswhiteladies-1421526429266xobpo.png&f=1&nofb=1",
                  bgColor: index.isEven
                      ? Color.fromARGB(255, 38, 97, 96)
                      : Color.fromARGB(255, 222, 234, 234),
                  title: "Tshirts for girls",
                  textColor: index.isEven ? Colors.black : Colors.white,
                  price: 100,
                  containerBgColor: index.isOdd
                      ? Color.fromARGB(255, 38, 97, 96)
                      : Color.fromARGB(255, 222, 234, 234),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
