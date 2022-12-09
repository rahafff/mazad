import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/pagination_entity.dart';
import 'package:elite_auction/features/home/domain/entities/paginated_product_entity.dart';
import 'package:elite_auction/features/home/domain/params/products_with_pagination_params.dart';
import 'package:elite_auction/features/home/domain/repositories/home_repository.dart';

import '../../../../core/models/api_response.dart';

class SlidedProductsCubit
    extends Cubit<StandardState<List<PaginatedProductEntity?>>> {
  final HomeRepository _homeRepository;
  final String paginationPerPage = '8';
  SlidedProductsCubit(this._homeRepository)
      : super(const StandardState.loading());
  Future<void> emitGetShopProductSimilarProducts(
      {required int shopId, required int productId}) async {
    return await _getResult(
      () => _homeRepository.getShopProductSimilarProducts(
        ProductsWithPaginationParams(
            page: 1,
            shopId: shopId,
            perPage: paginationPerPage,
            productId: productId),
      ),
    );
  }

  Future<void> emitGetLastAddedProducts() async {
    return await _getResult(
      () => _homeRepository.getLastAddedProducts(
        ProductsWithPaginationParams(page: 1, perPage: paginationPerPage),
      ),
    );
  }

  Future<void> emitGetOwnerProductSimilarProducts(
      {required int productId}) async {
    return await _getResult(
      () => _homeRepository.getOwnerProductSimilarProducts(
        ProductsWithPaginationParams(
            page: 1, perPage: paginationPerPage, productId: productId),
      ),
    );
  }

  Future<void> emitGetMostPopularProducts() async {
    return await _getResult(
      () => _homeRepository.getMostPopularProducts(
        ProductsWithPaginationParams(page: 1, perPage: paginationPerPage),
      ),
    );
  }

  Future<void> emitGetMostPurchasedProducts() async {
    return await _getResult(
      () => _homeRepository.getMostPurchasedProducts(
        ProductsWithPaginationParams(
          page: 1,
          perPage: paginationPerPage,
        ),
      ),
    );
  }

  Future<void> _getResult(
      Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
              Function()
          useCase) async {
    var response = await useCase();
    response.when(
        success: (BaseEntity<PaginationEntity<PaginatedProductEntity>> model) {
      if (!isClosed) emit(StandardState.success(model.data!.data));
    }, failure: (NetworkExceptions exception) {
      emit(StandardState.error(exception));
    });
  }
}
