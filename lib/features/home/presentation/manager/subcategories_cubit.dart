import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/home/domain/entities/subcategories_entity.dart';
import 'package:elite_auction/features/home/domain/params/subcategories_params.dart';

import '../../domain/repositories/home_repository.dart';

class SubcategoriesCubit extends Cubit<StandardState<List<Subcategory>>> {
  final HomeRepository _homeRepository;

  SubcategoriesCubit(this._homeRepository)
      : super(const StandardState.loading());
  Future<void> emitGetSubcategories(SubCategoriesParams params) async {
    emit(const StandardState.loading());
    var response = await _homeRepository.getSubcategories(params);
    response.when(success: (BaseEntity<SubCategoriesEntity> model) {
      if (!isClosed) {
        emit(StandardState.success(model.data!.subcategories.subcategories));
      }
    }, failure: (NetworkExceptions exception) {
      emit(StandardState.error(exception));
    });
  }
}
