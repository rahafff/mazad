import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/features/splash/domain/entities/version_entity.dart';
import 'package:package_info/package_info.dart';

import '../../domain/repositories/splash_repository.dart';

class ApplicationVersionCubit extends Cubit<StandardState<VersionEntity?>> {
  final SplashRepository _splashRepository;
  final PackageInfo _packageInfo;
  late final String buildNumber;
  ApplicationVersionCubit(this._splashRepository, this._packageInfo)
      : super(const StandardState.loading()) {
    buildNumber = "${_packageInfo.version}.${_packageInfo.buildNumber}";
    print("application build number $buildNumber");
  }
  Future<void> emitGetAppVersion() async {
    emit(const StandardState.loading());
    var response = await _splashRepository.getApplicationVersion();
    response.when(success: (version) {
      emit(StandardState.success(version.data));
    }, failure: (NetworkExceptions exception) {
      emit(StandardState.error(exception));
    });
  }
}
