import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/services/service_locator.dart';
import 'package:ecommerce_app/core/services/shared_preferences_service.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/routes_manager/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryEntityAdapter());
  Hive.registerAdapter(ProductsEntityAdapter());
  await Hive.openBox<CategoryEntity>('categories');
  await Hive.openBox<ProductsEntity>('products');
  serverLocator();
  await SharedPreferencesService.init();

  String? token = await SharedPreferencesService().getToken();
  bool isLogin = token != null;

  runApp(MainApp(
    isLogin: isLogin,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.isLogin});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: isLogin ? Routes.mainRoute : Routes.signInRoute,
      ),
    );
  }
}
