import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';

class CartGetterCubit extends Cubit<StandardState<Cart>> {
  final CartRepository _cartRepository;
  CartGetterCubit(this._cartRepository) : super(const StandardState.loading());
  Future<void> emitGetDetailedCart() async {
    emit(const StandardState.loading());
    var response = await _cartRepository.getDetailedCart();
    response.when(
      success: (success) => emit(
        StandardState.success(success.data!.cart),
      ),
      failure: (failure) => emit(
        StandardState.error(failure),
      ),
    );
  }
}
