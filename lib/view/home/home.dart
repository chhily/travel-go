import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/provider/geo/geo_handler.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/home/widget/choice_chip.dart';
import 'package:travel_go/view/home/widget/header.dart';
import 'package:travel_go/view/home/widget/highlight_card.dart';

import 'widget/category_highlight.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late GeoHandler geoHandler;
  var mySelected = StreamController<int?>.broadcast();
  List<String> itemTitle = [];
  List<String> itemImage = [];
  List<ItemObject> itemValue = [];
  List<String?> itemDescription = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    geoHandler = GeoHandler();
    initData();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => geoHandler.onGetUserLocation());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if (state == AppLifecycleState.resumed) {
      handleAfterDetached();
    }
    super.didChangeAppLifecycleState(state);
  }

  void handleAfterDetached() async {
    final permission = await geoHandler.handleLocationPermission();
    if (!permission) {
      if (!mounted) return;
      UIHelper.snackBarHelper(
          context: context, snackMessage: "Location services is disable!");
    } else {}
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    geoHandler.onGetUserLocation();
    super.didChangeDependencies();
  }

  void initData() {
    // final stopwatch = Stopwatch()..start();
    itemTitle = MockData.country.map((e) => e).toList();
    itemImage = MockData.countryImgUrl.map((e) => e).toList();
    itemDescription = MockData.countryDes.map((e) => e).toList();

    for (int i = 0; i < itemTitle.length; i++) {
      if (itemImage.length < itemTitle.length) itemImage.add(i.toString());
      if (itemDescription.length < itemTitle.length) itemDescription.add("N/A");

      ItemObject item = ItemObject(
          title: itemTitle[i],
          image: itemImage[i],
          description: itemDescription[i]);
      itemValue.add(item);
    }
    // stopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppGap.regularGap,
      children: [
        HomeHeaderWidget(
            streamController: geoHandler.myAddressController.stream),
        VerticalSpacing.huge,
        StreamBuilder<int?>(
            stream: mySelected.stream,
            initialData: null,
            builder: (context, streamValue) {
              return ChoiceChipWidget(
                valueSelected: streamValue.data,
                onSelected: (selected, index) {
                  mySelected.add(selected ? index : null);

                  // valueSelected = selected ? index : null;
                },
              );
            }),
        VerticalSpacing.huge,
        HighlightCardWidget(itemValue: itemValue),
        UIHelper.textHelper(
          text: "Category",
          fontWeight: FontWeight.bold,
          fontSize: FontSize.fontSizeBig,
        ),
        VerticalSpacing.big,
        CategoryHighlightWidget(itemList: itemValue),
      ],
    );
  }
}
