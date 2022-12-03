import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/utils/app_routes.dart';
import 'package:sagos_mobile/view_models/auth_view_model.dart';
import 'package:sagos_mobile/view_models/customer_view_model.dart';
import 'package:sagos_mobile/views/address_screen.dart';
import 'package:sagos_mobile/views/addressform_screen.dart';
import 'package:sagos_mobile/views/asset_screen.dart';
import 'package:sagos_mobile/views/assetform_screen.dart';
import 'package:sagos_mobile/views/auth_or_home_screen.dart';
import 'package:sagos_mobile/views/auth_page.dart';
import 'package:sagos_mobile/views/customerform_screen.dart';
import 'package:sagos_mobile/views/customerformedit_screen.dart';
import 'package:sagos_mobile/views/customers_screen.dart';
import 'package:sagos_mobile/views/dashboard_screen.dart';
import 'package:sagos_mobile/views/workorder_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProxyProvider<AuthViewModel, CustomerViewModel>(
            create: (_) => CustomerViewModel('', []),
            update: (ctx, auth, previous) {
              return CustomerViewModel(
                  auth.token ?? '', previous?.customerListModel ?? []);
            },
          )
        ],
        child: MaterialApp(
          title: 'SAGOS',
          theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.indigo,
              accentColor: Colors.deepOrangeAccent,
              brightness: Brightness.light,
              fontFamily: 'Lato',
              backgroundColor: Colors.grey[200]),
          routes: {
            AppRoutes.AUTH_OR_HOME: (context) => AuthOrHomeScreen(),
            AppRoutes.CUSTOMERS: (context) => CustomersScreen(),
            AppRoutes.CUSTOMER_FORM: (context) => CustomerFormScreen(),
            AppRoutes.CUSTOMER_FORM_EDIT: (context) => CustomerFormEditScreen(),
            AppRoutes.CUSTOMER_ASSETS: (context) => AssetsScreen(),
            AppRoutes.CUSTOMER_ADDRESS: (context) => AddressScreen(),
            AppRoutes.CUSTOMER_ASSET_FORM: (context) => AssetFormScreen(),
            AppRoutes.CUSTOMER_ADDRESS_FORM: (context) => AddressFormScreen(),
            AppRoutes.WORKORDER: (context) => WorkOrderScreen()
          },
          debugShowCheckedModeBanner: false,
        ));
  }
}
