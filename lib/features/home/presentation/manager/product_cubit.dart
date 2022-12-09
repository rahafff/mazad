import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/home/domain/params/product_params.dart';
import 'package:elite_auction/features/home/domain/repositories/home_repository.dart';

import '../../domain/entities/product_response_entity.dart';

class ProductCubit extends Cubit<StandardState<ProductResponseEntity>> {
  final HomeRepository _homeRepository;
  ProductEntity? product;
  ProductCubit(this._homeRepository) : super(const StandardState.loading());
  Future<void> emitGetProduct({required int productId, int? shopId}) async {
    emit(const StandardState.loading());
    var response =shopId!=null? await _homeRepository
        .getShopProduct(ProductParams(productId: productId, shopId: shopId)):await _homeRepository
        .getProduct(ProductParams(productId: productId));
    response.when(success: (BaseEntity<ProductResponseEntity> model) {
      product = model.data!.product;
      if (!isClosed) emit(StandardState.success(model.data!));
    }, failure: (NetworkExceptions exception) {
      emit(StandardState.error(exception));
    });
  }

  bool isVariationsNull() {
    return product!.productVariations!.isEmpty;
  }
}
