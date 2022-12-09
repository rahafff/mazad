import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/pagination_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/pagination_entity.dart';
import 'package:elite_auction/core/models/standard_pagination_params.dart';
import 'package:elite_auction/features/settings/domain/entities/customer_paginated_product_entity.dart';

import '../../domain/repositories/settings_repository.dart';

class CustomerProductsPaginatorCubit
    extends Cubit<PaginationState<CustomerPaginatedProductEntity?>> {
  final SettingsRepository _settingsRepository;

  int currentPage = 1;
  int? lastPage;
  List<CustomerPaginatedProductEntity?> _orders = [];
  CustomerProductsPaginatorCubit(
    this._settingsRepository,
  ) : super(const PaginationState.loading());
  Future<void> emitGetCustomerProducts({
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (lastPage != null && currentPage > lastPage!) return;
      currentPage++;
    } else {
      currentPage = 1;
      emit(const PaginationState.loading());
    }

    var response = await _settingsRepository.getMyProducts(
      StandardPaginationParams(
        page: currentPage,
      ),
    );
    response.when(
        success: ( model) {
      lastPage = model.data!.lastPage;
      _addIncomingDataToClassMemberData(loadMore, model);
     if(!isClosed) {
       emit(PaginationState.success(_orders, currentPage));
     }
    }, failure: (NetworkExceptions exception) {
      emit(PaginationState.error(exception));
    });
  }

  void _addIncomingDataToClassMemberData(bool loadMore,
      BaseEntity<PaginationEntity<CustomerPaginatedProductEntity?>> model) {
    if (loadMore) {
      _orders.addAll(model.data!.data);
    } else {
      _orders = model.data!.data;
    }
  }
}
