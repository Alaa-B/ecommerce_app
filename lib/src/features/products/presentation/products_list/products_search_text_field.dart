import 'package:ecommerce_app/src/features/products/presentation/products_list/products_list_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../localization/string_hardcoded.dart';

/// Search field used to filter products by name
class ProductsSearchTextField extends ConsumerStatefulWidget {
  const ProductsSearchTextField({super.key});

  @override
  ConsumerState<ProductsSearchTextField> createState() =>
      _ProductsSearchTextFieldState();
}

class _ProductsSearchTextFieldState
    extends ConsumerState<ProductsSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          autofocus: false,
          style: Theme.of(context).textTheme.titleLarge,
          decoration: InputDecoration(
            hintText: 'Search products'.hardcoded,
            icon: const Icon(Icons.search),
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                      ref.read(productsListStateProvider.notifier).state = '';
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          onChanged: (query) =>
              ref.read(productsListStateProvider.notifier).state = query,
        );
      },
    );
  }
}
