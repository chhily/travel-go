import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/ui_helper.dart';

class DetailsHeaderWidget extends StatelessWidget {
  final ItemObject? itemObject;
  const DetailsHeaderWidget({super.key, this.itemObject});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: itemObject?.title ?? "N/A",
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: UIHelper.cacheImageHelper(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.45,
                        image: itemObject?.image ?? "",
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: AppGap.regularGap,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(12)),
                          color: AppColors.primary.withOpacity(0.5),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UIHelper.textHelper(
                                      text: itemObject?.title ?? "N/A",
                                      fontSize: FontSize.fontSizeTitle,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.white),
                                  UIHelper.textHelper(
                                      text: itemObject?.description ?? "",
                                      textColor: AppColors.white,
                                      maxLines: 2),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor:
                                  AppColors.secondary.withOpacity(0.5),
                              child: const Icon(FontAwesomeIcons.solidHeart,
                                  size: 12, color: AppColors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          top: 8,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(
                Icons.arrow_back,
                color: AppColors.primary,
              ),
            ),
          ),
        )
      ],
    );
  }
}
