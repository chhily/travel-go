import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';

class CategoryHighlightWidget extends StatelessWidget {
  const CategoryHighlightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrl = [
      "https://i.pinimg.com/564x/87/10/fe/8710fe60ac262b1e7f23e1f87b90dc3b.jpg",
      "https://i.pinimg.com/564x/78/5c/c4/785cc4a79c67112c8d15a6ccda181eca.jpg",
      "https://i.pinimg.com/564x/b8/2e/33/b82e332473712b0f1b56b5b331970d5b.jpg",
      "https://i.pinimg.com/564x/de/eb/14/deeb14358042b9f77581e923740c1b4c.jpg",
      "https://i.pinimg.com/564x/34/cf/fb/34cffbe6160b2cedf3d8e59d27d901e9.jpg",
      "https://i.pinimg.com/564x/82/43/0e/82430e56d426a43b3d5951a760571e1d.jpg",
      "https://i.pinimg.com/564x/1f/7a/36/1f7a36ee1580c0fc154ba480a16d5ec1.jpg"
    ];

    final List<String> title = [
      "Italia",
      "Paris",
      "Japan",
      "Japan - FUJI",
      "Cambodia",
      "Bali",
      "Singapore",
    ];

    return Wrap(
      runSpacing: 10,
      spacing: 10,
      alignment: WrapAlignment.start,
      children: List.generate(
        imageUrl.length,
        (index) {
          return _buildCategoryWidget(
              imgUrl: imageUrl[index],
              tile: title[index],
              available: index,
              context: context);
        },
      ).toList(),
    );
  }

  Widget _buildCategoryWidget(
      {required String imgUrl,
      required String tile,
      required num available,
      required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.43,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          UIHelper.cacheImageHelper(image: imgUrl, width: 40, height: 40),
          HorizontalSpacing.regular,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.textHelper(
                  text: tile,
                  fontSize: FontSize.fontSizeBig,
                  fontWeight: FontWeight.bold),
              UIHelper.textHelper(
                  text: "Available: $available",
                  fontSize: FontSize.fontSizeMedium)
            ],
          ),
        ],
      ),
    );
  }
}
