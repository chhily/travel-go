import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_theme.dart';
import 'package:travel_go/provider/message/contact_handler.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/provider/message/store_users_handler.dart';
import 'package:travel_go/provider/message/user_store_handler.dart';
import 'package:travel_go/base/extension.dart';
import 'package:travel_go/view/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => UserContactHandler()),
        ChangeNotifierProvider(create: (_) => UserToStoreHandler()),
        ChangeNotifierProvider(create: (_) => StoreUsersHandler()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(textTheme),
        home: GestureDetector(
            onTap: () => TravelGoExtension(context).hideKeyboard(),
            child: const TravelGoRoot()),
      ),
    );
  }
}
