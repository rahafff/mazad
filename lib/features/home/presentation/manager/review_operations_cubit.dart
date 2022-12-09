import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/home/domain/bodies/add_review_on_product_body.dart';
import 'package:elite_auction/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewOperationsCubit
    extends Cubit<PostingState<EmptySuccessResponseEntity>> {
  final HomeRepository _homeRepository;
  int starsCount = 0;
  ReviewOperationsCubit(this._homeRepository)
      : super(const PostingState.idle());
  Future<void> emitAddUserReviewOnProduct(AddReviewOnProductBody body) async {
    emit(const PostingState.loading());
    var response = await _homeRepository.addReviewOnProduct(body);
    response.when(
      success: (success) => emit(
        PostingState.success(success),
      ),
      failure: (failure) => emit(
        PostingState.error(failure),
      ),
    );
  }
}
