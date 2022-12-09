import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/bodies/add_product_body.dart';

class ProductOperationsCubit
    extends Cubit<PostingState<EmptySuccessResponseEntity>> {
  final HomeRepository _homeRepository;

  ProductOperationsCubit(this._homeRepository)
      : super(const PostingState.idle());
  Future<void> emitAddProduct(AddProductBody body) async {
    emit(const PostingState.loading());
    var response = await _homeRepository.addProduct(body);
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
