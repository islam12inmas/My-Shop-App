import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:max_udemy_course/data/requests/get_products_request.dart';
import 'package:max_udemy_course/domain/products_model.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  static ProductsCubit get(context) => BlocProvider.of(context);
  ProductsModel productsList = ProductsModel();

  getProducts() {
    emit(ProductsLoading());
    GetProductsRequest.getProducts((p0) {
      productsList = p0;
      emit(ProductsLoaded());
    }, (error) => emit(ProductsError()));
  }
}
