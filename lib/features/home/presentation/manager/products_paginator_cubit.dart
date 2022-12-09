import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/pagination_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/pagination_entity.dart';
import 'package:elite_auction/features/home/domain/entities/paginated_product_entity.dart';
import 'package:elite_auction/features/home/domain/params/products_with_pagination_params.dart';

import '../../domain/repositories/home_repository.dart';

class ProductsPaginatorCubit
    extends Cubit<PaginationState<PaginatedProductEntity?>> {
  final HomeRepository _homeRepository;

  int currentPage = 1;
  int? lastPage;
  List<PaginatedProductEntity?> products = [];
  ProductsPaginatorCubit(this._homeRepository)
      : super(const PaginationState.loading());
  Future<void> emitGetShopProducts(
      {bool loadMore = false,
      required int? shopId,
      String? search,
      int? shopCategoryId}) async {
    if (loadMore) {
      if (lastPage != null && currentPage > lastPage!) return;
      currentPage++;
    } else {
      currentPage = 1;
      emit(const PaginationState.loading());
    }

    var response = await _homeRepository.getShopProducts(
      ProductsWithPaginationParams(
          page: currentPage,
          shopId: shopId,
          shopCategoryId: shopCategoryId,
          search: search),
    );
    response.when(
        success: (BaseEntity<PaginationEntity<PaginatedProductEntity>> model) {
      lastPage = model.data!.lastPage;
      _addIncomingDataToClassMemberData(loadMore, model);
      if (!isClosed) emit(PaginationState.success(products, currentPage));
    }, failure: (NetworkExceptions exception) {
      emit(PaginationState.error(exception));
    });
  }

  Future<void> emitGetSubcategoryProducts(
      {bool loadMore = false,
      required int? categoryId,
      String? search,
      required int? subcategoryId}) async {
    if (loadMore) {
      if (lastPage != null && currentPage > lastPage!) return;
      currentPage++;
    } else {
      currentPage = 1;
      emit(const PaginationState.loading());
    }

    var response = await _homeRepository.getSubcategoryProducts(
      ProductsWithPaginationParams(
          page: currentPage,
          subcategoryId: subcategoryId,
          categoryId: categoryId,
          search: search),
    );
    response.when(
        success: (BaseEntity<PaginationEntity<PaginatedProductEntity>> model) {
      lastPage = model.data!.lastPage;
      _addIncomingDataToClassMemberData(loadMore, model);
      if (!isClosed) emit(PaginationState.success(products, currentPage));
    }, failure: (NetworkExceptions exception) {
      emit(PaginationState.error(exception));
    });
  }
 Future<void> emitGetSubsubcategoryProducts(
      {bool loadMore = false,
      required int? categoryId,
      String? search,
      required int? subsubcategoryId}) async {
    if (loadMore) {
      if (lastPage != null && currentPage > lastPage!) return;
      currentPage++;
    } else {
      currentPage = 1;
      emit(const PaginationState.loading());
    }

    var response = await _homeRepository.getSubsubcategoryProducts(
      ProductsWithPaginationParams(
          page: currentPage,
          subsubcategoryId: subsubcategoryId,
          categoryId: categoryId,
          search: search),
    );
    response.when(
        success: (BaseEntity<PaginationEntity<PaginatedProductEntity>> model) {
      lastPage = model.data!.lastPage;
      _addIncomingDataToClassMemberData(loadMore, model);
      if (!isClosed) emit(PaginationState.success(products, currentPage));
    }, failure: (NetworkExceptions exception) {
      emit(PaginationState.error(exception));
    });
  }

  Future<void> emitGetSearchAllProducts(
      {bool loadMore = false, required String search}) async {
    if (loadMore) {
      if (lastPage != null && currentPage > lastPage!) return;
      currentPage++;
    } else {
      currentPage = 1;
      emit(const PaginationState.loading());
    }

    var response = await _homeRepository.getSearchAllProducts(
      ProductsWithPaginationParams(page: currentPage, search: search),
    );
    response.when(
        success: (BaseEntity<PaginationEntity<PaginatedProductEntity>> model) {
      lastPage = model.data!.lastPage;
      _addIncomingDataToClassMemberData(loadMore, model);
      if (!isClosed) emit(PaginationState.success(products, currentPage));
    }, failure: (NetworkExceptions exception) {
      emit(PaginationState.error(exception));
    });
  }

  void _addIncomingDataToClassMemberData(bool loadMore,
      BaseEntity<PaginationEntity<PaginatedProductEntity?>> model) {
    if (loadMore) {
      products.addAll(model.data!.data);
    } else {
      products = model.data!.data;
    }
  }
}
