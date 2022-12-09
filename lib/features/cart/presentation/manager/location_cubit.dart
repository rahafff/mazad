import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:elite_auction/features/cart/domain/entities/search_response_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/cart_repository.dart';

class LocationCubit extends Cubit<StandardState<List<Prediction>>> {
  final CartRepository _cartRepository;
  LocationCubit(this._cartRepository) : super(const StandardState.loading());
  Future<void> emitGetLocationSearchResults(String search,String sessionToken) async {
    emit(const StandardState.loading());
    var response = await _cartRepository.getSearchResults(search,sessionToken);
    response.when(
      success: (success) => emit(
        StandardState.success(success),
      ),
      failure: (failure) => emit(
        StandardState.error(failure),
      ),
    );
  }

  Future<void> locationDetailes(String placeId, ) async {
    var response = await _cartRepository.getSearchDeResults(placeId);
    response.when(
      success: (success) {
        AppSharedPreferences.longitude =success.location?.lng;
        AppSharedPreferences.latitude =success.location?.lat;
      },
      failure: (failure) => emit(
        StandardState.error(failure),
      ),
    );
  }

  void hideSearchSuggestions() {
    emit(StandardState.error(NetworkExceptions.notFound('')));
  }
}
