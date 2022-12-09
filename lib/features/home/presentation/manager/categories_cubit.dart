import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';

import '../../domain/entities/categories_entity.dart';
import '../../domain/repositories/home_repository.dart';

class CategoriesCubit extends Cubit<StandardState<List<Category>>> {
  final HomeRepository _homeRepository;

  CategoriesCubit(this._homeRepository) : super(const StandardState.loading());
  Future<void> emitGetCategories() async {
    emit(const StandardState.loading());
    var response = await _homeRepository.getCategories();
    response.when(success: (BaseEntity<CategoriesEntity> model) {
      if (!isClosed) emit(StandardState.success(model.data!.categories));
    }, failure: (NetworkExceptions exception) {
      emit(StandardState.error(exception));
    });
  }
}
