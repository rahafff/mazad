import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/home/domain/entities/advertisements_entity.dart';
import 'package:elite_auction/features/home/domain/repositories/home_repository.dart';

class AdvertisementsCubit extends Cubit<StandardState<List<Sliders>>> {
  final HomeRepository _homeRepository;

  AdvertisementsCubit(this._homeRepository)
      : super(const StandardState.loading());
  Future<void> emitGetAdvertisements() async {
    emit(const StandardState.loading());
    var response = await _homeRepository.getAdvertisements();
    response.when(success: (BaseEntity<AdvertisementsEntity> model) {
      if (!isClosed) emit(StandardState.success(model.data!.sliders));
    }, failure: (NetworkExceptions exception) {
      emit(StandardState.error(exception));
    });
  }
}
