import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/home/domain/entities/shop_categories_entity.dart';
import 'package:elite_auction/features/home/domain/params/shop_categories_params.dart';
import 'package:elite_auction/features/home/domain/repositories/home_repository.dart';

class ShopCategoriesCubit extends Cubit<StandardState<List<ShopCategories>?>> {
  final HomeRepository _homeRepository;
  bool isFilteringByCategory = false;
  int? categoryId;
  late int itemCountForShopCategories;
  void _setItemCountForShopCategories(int responseLength) {
    if (responseLength % 3 == 0) {
      itemCountForShopCategories = responseLength ~/ 3;
    } else {
      itemCountForShopCategories = (responseLength / 3 + 1).toInt();
    }
  }

  ShopCategoriesCubit(this._homeRepository)
      : super(const StandardState.loading());
  Future<void> emitGetShopCategories(int shopId) async {
    emit(const StandardState.loading());
    var response = await _homeRepository
        .getShopCategories(ShopCategoriesParams(shopId: shopId));
    response.when(success: (BaseEntity<ShopCategoriesEntity> model) {
      _setItemCountForShopCategories(
          model.data!.shop?.shopCategories?.length ?? 0);
      if (!isClosed)
        emit(StandardState.success(model.data!.shop!.shopCategories));
    }, failure: (NetworkExceptions exception) {
      emit(StandardState.error(exception));
    });
  }
}
