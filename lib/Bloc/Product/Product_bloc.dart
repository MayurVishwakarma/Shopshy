// lib/bloc/product_bloc.dart
// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopshy/Repository/Product_repository.dart';

part 'Product_event.dart';
part 'Product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.fetchProducts();
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
  }
}
