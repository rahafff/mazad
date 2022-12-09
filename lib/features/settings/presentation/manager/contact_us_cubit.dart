import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/company_info_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global_states/standard_state.dart';
import '../../domain/repositories/settings_repository.dart';

class ContactUsCubit extends Cubit<StandardState<CompanyInfo>> {
  final SettingsRepository _settingsRepository;
  ContactUsCubit(this._settingsRepository)
      : super(const StandardState.loading());
  Future<void> emitGetCompanyInfo() async {
    emit(const StandardState.loading());
    final response = await _settingsRepository.getCompanyInfo();
    response.when(
      success: (BaseEntity<CompanyInfoEntity> entity) {
        if(!isClosed) {
          emit(
          StandardState.success(entity.data!.companyInfo),
        );
        }
      },
      failure: (NetworkExceptions failure) {
        emit(
          StandardState.error(failure),
        );
      },
    );
  }
}
