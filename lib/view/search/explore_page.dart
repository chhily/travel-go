import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/search/widget/search_explore.dart';
import 'package:travel_go/view/search/widget/suggestion_place.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: AppColors.secondary,
              image: DecorationImage(
                fit: BoxFit.fill,
                opacity: 0.5,
                image: NetworkImage(MockData.bgImage),
              )),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UIHelper.textHelper(
                      text: "Choose Your Favorite",
                      fontSize: FontSize.fontSizeHuge,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.white,
                      textAlign: TextAlign.center),
                  VerticalSpacing.regular,
                  UIHelper.textHelper(
                      text: "Many Interesting Choices For you",
                      textColor: AppColors.white,
                      textAlign: TextAlign.center)
                ],
              ),
              Positioned(
                top: 20,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                    color: AppColors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        VerticalSpacing.huge,
        Align(
          alignment: Alignment.center,
          child: selectionIcon(),
        ),
        VerticalSpacing.regular,
        Padding(
          padding: AppGap.regularGap,
          child: UIHelper.textHelper(
              text: "Suggestion Place",
              fontSize: FontSize.fontSizeTitle,
              fontWeight: FontWeight.bold),
        ),
        const Expanded(child: SuggestionPlaceWidget()),
      ],
    );
  }

  Widget selectionIcon() {
    const List<IconData> iconList = [
      FontAwesomeIcons.solidCompass,
      FontAwesomeIcons.sailboat,
      FontAwesomeIcons.personSwimming,
      FontAwesomeIcons.campground,
      FontAwesomeIcons.personSkiing,
    ];

    const List<String> iconTitle = [
      "Explorer",
      "Sailing",
      "Swimming",
      "Camping",
      "skiing"
    ];

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      children: List.generate(
        iconList.length,
        (index) => iconWidget(
          iconData: iconList[index],
          iconTitle: iconTitle[index],
        ),
      ),
    );
  }

  Widget iconWidget({required IconData iconData, required String iconTitle}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: AppColors.secondary.withOpacity(0.2),
              radius: 24,
              child: Icon(iconData, color: AppColors.secondary),
            ),
          ),
          VerticalSpacing.medium,
          UIHelper.textHelper(
            text: iconTitle,
            textColor: AppColors.textSecondary,
          ),
        ],
      );
}
