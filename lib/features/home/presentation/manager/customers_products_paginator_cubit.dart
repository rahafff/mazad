import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/pagination_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/pagination_entity.dart';
import 'package:elite_auction/features/home/domain/params/products_with_pagination_params.dart';

import '../../../settings/domain/entities/my_product_details_entity.dart';
import '../../domain/repositories/home_repository.dart';

class AllCustomersProductsCubit extends Cubit<PaginationState<MyProductDetailsEntity?>> {
  final HomeRepository _homeRepository;
  int currentPage = 1;
  int? lastPage;
  List<MyProductDetailsEntity?> _shops = [];
  AllCustomersProductsCubit(this._homeRepository) : super(const PaginationState.loading());
  Future<void> emitGetAllCustomersProducts({int? subcategoryId,int? subsubcategoryId,bool loadMore = false}) async {
    if (loadMore) {
      if (lastPage != null  && currentPage > lastPage!) return;
      currentPage++;
    } else {
      currentPage = 1;
      emit(const PaginationState.loading());
    }
    var response = await _homeRepository
        .getAllCustomersProducts(ProductsWithPaginationParams(page: currentPage,subcategoryId: subcategoryId,subsubcategoryId: subsubcategoryId));
    response.when(success: ( model) {
      lastPage = model.data!.lastPage;
      _addIncomingDataToClassMemberData(loadMore, model);
      if (!isClosed) emit(PaginationState.success(_shops, currentPage));
    }, failure: (NetworkExceptions exception) {
      emit(PaginationState.error(exception));
    });
  }

  void _addIncomingDataToClassMemberData(
      bool loadMore, BaseEntity<PaginationEntity<MyProductDetailsEntity?>> model) {
    if (loadMore) {
      _shops.addAll(model.data!.data);
    } else {
      _shops = model.data!.data;
    }
  }
}
