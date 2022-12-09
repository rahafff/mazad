import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/resources/constant_backend_values.dart';
import 'package:elite_auction/core/widgets/loading_circular.dart';
import 'package:elite_auction/features/home/domain/bodies/add_review_on_product_body.dart';
import 'package:elite_auction/features/home/domain/entities/user_review_entity.dart';
import 'package:elite_auction/features/home/presentation/manager/review_getter_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/review_operations_cubit.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/error/network_exceptions.dart';
import '../../../../../core/global_states/standard_state.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../../core/utils/global.dart';
import '../../../domain/params/user_review_params.dart';
import '../../manager/product_cubit.dart';

class AddAndShowReviewButton extends StatelessWidget {
  AddAndShowReviewButton({
    Key? key,
  }) : super(key: key);
  final ReviewStatus reviewStatus = ReviewStatus();
  final ReviewOperationsCubit _reviewOperationsCubit =
      di.sl<ReviewOperationsCubit>();
  @override
  Widget build(BuildContext context) {
    final productId = context.read<ProductCubit>().product!.id;

    return MultiBlocProvider(
        providers: [
          BlocProvider<ReviewGetterCubit>(
            create: (_) => di.sl<ReviewGetterCubit>()
              ..emitGetUserReview(
                UserReviewParams(productId: productId),
              ),
          ),
        ],
        child: BlocBuilder<ReviewGetterCubit, StandardState<UserReviewEntity?>>(
          builder: (context, state) {
            final reviewGetter = context.read<ReviewGetterCubit>();
            return state.when(
                loading: () => Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: LoadingCircularWidget(),
                    ),
                success: (UserReviewEntity? data) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 3.0.h),
                    width: 90.0.w,
                    height: 8.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0.w),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                            color: ColorManager.lightGrayButtonColor,
                            child: Align(
                              alignment: lang
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Text(
                                data == null
                                    ? AppStrings.addReview.tr()
                                    : AppStrings.showReview.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: ColorManager.grayText),
                              ),
                            ),
                          ),
                        ),
                        Builder(builder: (context) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  elevation: 7,
                                  barrierColor: Colors.transparent,
                                  isDismissible: true,
                                  enableDrag: true,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: BlocConsumer<
                                            ReviewOperationsCubit,
                                            PostingState<
                                                EmptySuccessResponseEntity>>(
                                          bloc: _reviewOperationsCubit,
                                          listener: (context, state) {
                                            state.whenOrNull(
                                              success: (entity) {
                                                Navigator.pop(context);
                                                reviewGetter.emitGetUserReview(
                                                  UserReviewParams(
                                                      productId: productId),
                                                );
                                                return Fluttertoast.showToast(
                                                    msg: entity.message,
                                                    toastLength:
                                                        Toast.LENGTH_SHORT);
                                              },
                                              error: (error) {
                                                Navigator.pop(context);
                                                reviewGetter.emitGetUserReview(
                                                  UserReviewParams(
                                                      productId: productId),
                                                );
                                                return Fluttertoast.showToast(
                                                    msg: NetworkExceptions
                                                        .getErrorMessage(error),
                                                    toastLength:
                                                        Toast.LENGTH_SHORT);
                                              },
                                            );
                                          },
                                          builder: (context, state) {
                                            return state.maybeWhen(
                                              loading: () =>
                                                  LoadingCircularWidget(),
                                              orElse: () => Container(
                                                width: 100.0.w,
                                                padding:
                                                    EdgeInsets.only(top: 5.0.h),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(8.0.w),
                                                    topLeft:
                                                        Radius.circular(8.0.w),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    _buildReviewBottomSheetTitle(
                                                        context, data),
                                                    data == null
                                                        ? _buildBottomSheetReviewRatingBar(
                                                            context, data)
                                                        : _buildBottomSheetReviewRatingBarIndicator(
                                                            context, data),
                                                    data == null
                                                        ? _buildBottomSheetAddReviewButton(
                                                            context, productId)
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                color: ColorManager.midumeGrayButtonColor,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorManager.kGreen,
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  );
                },
                error: (_) => const SizedBox.shrink());
          },
        ));
  }

  Container _buildBottomSheetAddReviewButton(
      BuildContext context, int productId) {
    return Container(
      margin: EdgeInsets.only(top: 1.0.w),
      width: 100.0.w,
      decoration: BoxDecoration(
        color: ColorManager.kGreen,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.0.w),
          topLeft: Radius.circular(8.0.w),
        ),
      ),
      child: MaterialButton(
        onPressed: () {
          _reviewOperationsCubit.emitAddUserReviewOnProduct(
            AddReviewOnProductBody(
                productId: productId,
                reviewStarsCount: _reviewOperationsCubit.starsCount),
          );
        },
        child: Text(
          AppStrings.addReview.tr(),
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: ColorManager.kWhite),
        ),
      ),
    );
  }

  RatingBar _buildBottomSheetReviewRatingBar(
      BuildContext context, UserReviewEntity? review) {
    return RatingBar.builder(
      itemBuilder: (BuildContext context, _) {
        return const Icon(
          Icons.star,
          color: Colors.amber,
        );
      },
      itemPadding: EdgeInsets.symmetric(horizontal: 0.5.w),
      onRatingUpdate: (double value) {
        _reviewOperationsCubit.starsCount = value.toInt();
      },
      initialRating: 0,
      itemSize: 10.w,
      updateOnDrag: true,
    );
  }

  RatingBarIndicator _buildBottomSheetReviewRatingBarIndicator(
      BuildContext context, UserReviewEntity review) {
    return RatingBarIndicator(
      itemBuilder: (BuildContext context, _) {
        return const Icon(
          Icons.star,
          color: Colors.amber,
        );
      },
      itemPadding: EdgeInsets.symmetric(horizontal: 0.5.w),
      rating: review.reviewStars.toDouble(),
      itemSize: 10.w,
    );
  }

  RichText _buildReviewBottomSheetTitle(
      BuildContext context, UserReviewEntity? review) {
    return RichText(
      text: TextSpan(
        text: review == null
            ? "${AppStrings.addUrReview.tr()} "
            : "${AppStrings.yourReview.tr()} ",
        style: Theme.of(context).textTheme.bodyText1,
        children: [
          if (review != null)
            TextSpan(
              text: reviewStatus.reviewStatusesNames[review.reviewStatus]!.tr(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color:
                        reviewStatus.reviewStatusesColors[review.reviewStatus],
                  ),
            )
        ],
      ),
    );
  }
}
