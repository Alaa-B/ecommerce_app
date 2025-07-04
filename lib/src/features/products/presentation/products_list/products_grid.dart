import 'dart:math';

import 'package:ecommerce_app/src/features/products/presentation/products_list/products_list_state_provider.dart';
import '../../../../common_widgets/async_value_widget.dart';
import '../../domain/product.dart';
import 'product_card.dart';
import '../../../../localization/string_hardcoded.dart';
import '../../../../routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import '../../../../constants/app_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A widget that displays the list of products that match the search query.
class ProductsGrid extends ConsumerWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final productsRepository = ref.watch(productSearchResultProvider);
    return AsyncValueWidget<List<Product>>(
      value: productsRepository,
      data: (products) => products.isEmpty
          ? Center(
              child: Text(
                'No products found'.hardcoded,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : ProductsLayoutGrid(
              itemCount: products.length,
              itemBuilder: (_, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onPressed: () => context.goNamed(
                    AppRoutes.productDetails.name,
                    pathParameters: {'id': product.id},
                  ),
                );
              },
            ),
    );
  }
}

/// Grid widget with content-sized items.
/// See: https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/
class ProductsLayoutGrid extends StatelessWidget {
  const ProductsLayoutGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display.
  final int itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    // use a LayoutBuilder to determine the crossAxisCount
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // 1 column for width < 500px
      // then add one more column for each 250px
      final crossAxisCount = max(1, width ~/ 250);
      // once the crossAxisCount is known, calculate the column and row sizes
      // set some flexible track sizes based on the crossAxisCount with 1.fr
      final columnSizes = List.generate(crossAxisCount, (_) => 1.fr);
      final numRows = (itemCount / crossAxisCount).ceil();
      // set all the row sizes to auto (self-sizing height)
      final rowSizes = List.generate(numRows, (_) => auto);
      // Custom layout grid. See: https://pub.dev/packages/flutter_layout_grid
      return LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        rowGap: Sizes.p24, // equivalent to mainAxisSpacing
        columnGap: Sizes.p24, // equivalent to crossAxisSpacing
        children: [
          // render all the items with automatic child placement
          for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
        ],
      );
    });
  }
}
