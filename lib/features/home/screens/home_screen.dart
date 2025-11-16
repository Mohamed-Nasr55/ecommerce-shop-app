import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysmallshop/core/category/category_cubit.dart';
import 'package:mysmallshop/core/category/category_model.dart';
import 'package:mysmallshop/core/category/category_state.dart';
import 'package:mysmallshop/core/product/product_cubit.dart';
import 'package:mysmallshop/core/product/product_model.dart';
import 'package:mysmallshop/core/product/product_state.dart';
import 'package:mysmallshop/features/cart/cart_cubit.dart';
import 'package:mysmallshop/features/cart/cart_item.dart';
import 'package:mysmallshop/features/cart/cart_screen.dart';
import 'package:mysmallshop/features/home/widgets/home_appbar.dart';
import 'package:mysmallshop/features/home/widgets/home_page_body.dart';
import 'package:mysmallshop/features/profile/screens/profile_screen.dart';
import 'package:mysmallshop/core/category/categories_screen.dart';
import 'package:mysmallshop/widgets/bottom_nav_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchName = '';
  List<Category> _categories = [];
  List<Product> _filteredProducts = [];

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<ProductCubit>().fetchProducts();
    context.read<CategoryCubit>().loadCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0 ? const HomeAppbar() : null,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProductLoaded) {
                _filteredProducts =
                    state.products
                        .where(
                          (p) => p.title.toLowerCase().contains(
                            _searchName.toLowerCase(),
                          ),
                        )
                        .toList();

                return HomePageBody(
                  products: _filteredProducts,
                  searchController: _searchController,
                  onSearchChanged:
                      (value) => setState(() => _searchName = value),
                  onAddToCart:
                      (product) => context.read<CartCubit>().addItem(
                        CartItem(
                          title: product.title,
                          image:
                              product.images.isNotEmpty
                                  ? product.images.first
                                  : '',
                          price: product.price,
                        ),
                      ),
                );
              }
              if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),

          BlocBuilder<CategoryCubit, dynamic>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CategoryLoaded) {
                _categories = state.categories;
                return CategoriesScreen(categories: _categories);
              }
              if (state is CategoryError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),

          const CartScreen(),

          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
