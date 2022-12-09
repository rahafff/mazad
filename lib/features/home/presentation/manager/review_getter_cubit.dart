import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/features/home/domain/entities/user_review_entity.dart';
import 'package:elite_auction/features/home/domain/params/user_review_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/home_repository.dart';

class ReviewGetterCubit extends Cubit<StandardState<UserReviewEntity?>> {
  final HomeRepository _homeRepository;

  ReviewGetterCubit(this._homeRepository)
      : super(const StandardState.loading());
  Future<void> emitGetUserReview(UserReviewParams params) async {
    emit(const StandardState.loading());
    var response = await _homeRepository.getUserReview(params);
    response.when(
      success: (model) {
        if (!isClosed) emit(StandardState.success(model.data));
      },
      failure: (NetworkExceptions exception) {
        emit(StandardState.error(exception));
      },
    );
  }
}
