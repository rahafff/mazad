import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/my_product_details_entity.dart';
import 'package:elite_auction/features/settings/domain/params/my_order_details_params.dart';
import 'package:elite_auction/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global_states/standard_state.dart';
import '../../../../core/utils/global.dart';

class MyProductDetailsCubit extends Cubit<StandardState<MyProductDetailsEntity>> {
  final SettingsRepository _settingsRepository;
  MyProductDetailsCubit(this._settingsRepository,)
      : super(const StandardState.loading());
  late final MyProductDetailsEntity product;
  Future<void> emitGetMyProductDetails({required int productId }) async {
    emit(const StandardState.loading());
    final response = await _settingsRepository.getMyProductDetails(MyProductDetailsParams(productId: productId,));
    response.when(
      success: (BaseEntity<MyProductDetailsEntity> entity) {
         expireDate=entity.data!.expiredDate;
        emit(
          StandardState.success(entity.data!),
        );
      },
      failure: (failure) {
        emit(
          StandardState.error(failure),
        );
      },
    );
  }
}
