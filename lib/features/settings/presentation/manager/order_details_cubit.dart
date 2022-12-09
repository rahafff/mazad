import 'package:elite_auction/features/settings/domain/entities/order_entity.dart';
import 'package:elite_auction/features/settings/domain/params/order_details_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global_states/standard_state.dart';
import '../../domain/repositories/settings_repository.dart';

class OrderDetailsCubit extends Cubit<StandardState<PaginatedOrderEntity>> {
  final SettingsRepository _settingsRepository;
  OrderDetailsCubit(this._settingsRepository)
      : super(const StandardState.loading());
  Future<void> emitGetOrderDetails(OrderDetailsParams params) async {
    emit(const StandardState.loading());
    final response = await _settingsRepository.getOrderDetails(params);
    response.when(
      success: (entity) {
        emit(
          StandardState.success(entity.data!.order),
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
