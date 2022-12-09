import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/cart/domain/entities/online_payment_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/cart_repository.dart';

abstract class PaymentCubit<T> extends Cubit<PostingState<T>> {
  PaymentCubit() : super(const PostingState.idle());
  Future<void> pay();
}

class CardPaymentCubit extends PaymentCubit<BaseEntity<OnlinePaymentEntity>> {
  final CartRepository _cartRepository;

  late String paymentUrl;
  late int paymentId;
  CardPaymentCubit(this._cartRepository);
  @override
  Future<void> pay() async {
    emit(const PostingState.loading());
    var response = await _cartRepository.createPayment();
    response.when(
      success: (success) {
        paymentId = success.data!.payment.paymentId;
        paymentUrl = success.data!.payment.paymentUrl;
        emit(
          PostingState.success(success),
        );
      },
      failure: (failure) => emit(
        PostingState.error(failure),
      ),
    );
  }
}
