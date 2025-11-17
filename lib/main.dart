import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysmallshop/core/category/category_cubit.dart';
import 'package:mysmallshop/core/product/product_cubit.dart';
import 'package:mysmallshop/core/repository/categories_repo.dart';
import 'package:mysmallshop/core/repository/product_repo.dart';
import 'package:mysmallshop/features/cart/cart_cubit.dart';
import 'package:mysmallshop/screens/splash_screen.dart';
import 'package:mysmallshop/features/theme/theme_cubit.dart';

void main() {
  final productsRepository = ProductsRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  ProductCubit(repository: productsRepository)..fetchProducts(),
        ),
        BlocProvider<CategoryCubit>(
          create: (_) => CategoryCubit(repository: CategoriesRepository()),
        ),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop App',
          theme: theme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
