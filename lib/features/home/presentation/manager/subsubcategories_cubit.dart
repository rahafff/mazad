import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';

import '../../domain/entities/subsubcategories_entity.dart';
import '../../domain/repositories/home_repository.dart';

class SubsubcategoriesCubit
    extends Cubit<StandardState<List<Subsubcategory?>>> {
  final HomeRepository _homeRepository;

  SubsubcategoriesCubit(this._homeRepository)
      : super(const StandardState.loading());
  Future<void> emitGetSubsubategories(int subcategoryId) async {
    emit(const StandardState.loading());
    var response = await _homeRepository.getSubsubcategories(subcategoryId);
    response.when(success: (model) {
      if (!isClosed) {
        emit(
          StandardState.success(model.data!.subsubcategories!.subsubcategories),
        );
      }
    }, failure: (NetworkExceptions exception) {
      emit(StandardState.error(exception));
    });
  }
}
