// import 'dart:async';
// import 'dart:developer';
// import 'dart:ui' as ui;
//
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:elite_auction/core/API/http/api_urls.dart';
// import 'package:elite_auction/core/constants/app_assets.dart';
// import 'package:elite_auction/core/constants/constant_widgets.dart';
// import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
// import 'package:elite_auction/core/widgets/TryRequest.dart';
// import 'package:elite_auction/core/widgets/loading.dart';
// import 'package:elite_auction/features/auctions/data/add_comment_request_model.dart';
// import 'package:elite_auction/features/auctions/data/bid_event_pusher_response.dart';
// import 'package:elite_auction/features/auctions/data/bid_request_model.dart';
// import 'package:elite_auction/features/auctions/data/normal_auction_static_data.dart';
// import 'package:elite_auction/features/auctions/domain/normal_auction_domain/bid_cubit.dart';
// import 'package:elite_auction/features/auctions/domain/normal_auction_domain/comments_cubit.dart';
// import 'package:elite_auction/features/auctions/domain/normal_auction_domain/normal_auction_static_data_cubit.dart';
// import 'package:elite_auction/features/auctions/domain/pusher_cubit.dart';
// import 'package:elite_auction/features/auctions/presentation/widgets/auctions_shared_app_bar.dart';
// import 'package:elite_auction/features/settings/presentation/pages/my_auction_orders.dart';
// import 'package:elite_auction/features/testPage.dart';
// import 'package:expandable_page_view/expandable_page_view.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../AppSettings.dart';
// import '../../../../core/constants/AppColors.dart';
// import '../../../../core/widgets/build_indicator.dart';
// import '../../../../core/widgets/shared_elevated_button.dart';
// import '../../../../features/Home/presentation/widgets/build_product_image.dart';
// import '../../../../global.dart';
// import '../../domain/normal_auction_domain/timer_cubit.dart';
// import '../widgets/build_bid_choice.dart';
// import '../widgets/time_card.dart';
//
// class NormalAuctionScreen extends StatefulWidget {
//   final int auctionId;
//   final String auctionName;
//   final String startBidDate;
//   final String endBidDate;
//   const NormalAuctionScreen({
//     Key key,
//     this.auctionId,
//     this.auctionName,
//     this.startBidDate,
//     this.endBidDate,
//   }) : super(key: key);
//
//   @override
//   State<NormalAuctionScreen> createState() => _NormalAuctionScreenState();
// }
//
// class _NormalAuctionScreenState extends State<NormalAuctionScreen> {
//   int index = 0;
//   final TextEditingController bidEditingController = TextEditingController();
//   final TextEditingController commentController = TextEditingController();
//   final GlobalKey<FormState> _commentKey = GlobalKey();
//   final GlobalKey<FormState> _bidKey = GlobalKey();
//
//   PusherCubit pusherContext;
//   TimerCubit timerCubit = TimerCubit();
//   @override
//   void initState() {
//     context
//         .read<NormalAuctionStaticDataCubit>()
//         .getAuctionStaticData(auctionId: widget.auctionId);
//     context.read<PusherCubit>().initPusher(auctionId: widget.auctionId);
//     timerCubit.initTimer(
//         startBidDate: widget.startBidDate, endBidDate: widget.endBidDate);
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     pusherContext = context.read<PusherCubit>();
//     super.didChangeDependencies();
//   }
//
//   @override
//   dispose() {
//     pusherContext.pusherDisconnect(auctionId: widget.auctionId);
//     timerCubit.disposeTimer();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext auctionContext) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AuctionsSharedAppBar(
//             context: context, appBarTitle: widget.auctionName, canGoBack: true),
//         backgroundColor: AppColors.kWhite,
//         body: BlocListener<PusherCubit, PusherState>(
//           listenWhen: (prev, curr) {
//             return prev.closeEventPusherResponse !=
//                 curr.closeEventPusherResponse;
//           },
//           listener: (context, state) {
//             if (state.closeEventPusherResponse != null) {
//               Navigator.pop(context);
//               _buildAuctionResultAlertDialog(state, context);
//             }
//           },
//           child: Column(
//             children: [
//               Expanded(
//                 flex: 9,
//                 child: BlocConsumer<NormalAuctionStaticDataCubit,
//                     NormalAuctionStaticDataState>(
//                   listener: (context, state) {
//                     if (state is NormalAuctionStaticDataSuccess)
//                       context.read<PusherCubit>().auctionComments =
//                           state.auction.auction.auctionComments;
//                     print(context.read<PusherCubit>().auctionComments);
//                   },
//                   builder: (context, state) {
//                     if (state is NormalAuctionStaticDataLoading)
//                       return LoadingCircularWidget();
//                     else if (state is NormalAuctionStaticDataError)
//                       return TryRequest(
//                           onTry: auctionContext
//                               .read<NormalAuctionStaticDataCubit>()
//                               .getAuctionStaticData(
//                                 auctionId: widget.auctionId,
//                               ));
//                     else if (state is NormalAuctionStaticDataSuccess) {
//                       final auction = state.auction.auction;
//
//                       return Container(
//                         child: ListView(
//                           shrinkWrap: true,
//                           primary: false,
//                           physics: ScrollPhysics(),
//                           children: [
//                             _buildAuctionImagesSlider(auction),
//                             SizedBox(
//                               height: 5.0.h,
//                             ),
//                             BuildIndicator(
//                                 length: auction.images.length, index: index),
//                             SizedBox(
//                               height: 5.0.h,
//                             ),
//                             BlocBuilder<PusherCubit, PusherState>(
//                               builder: (context, state) {
//                                 final bidState =
//                                     context.watch<PusherCubit>().state;
//                                 return Row(
//                                   children: [
//                                     _buildAuctionDetails(auction, bidState),
//                                     _buildAuctionLeaderBoard(auction, bidState),
//                                   ],
//                                 );
//                               },
//                             ),
//                             Container(
//                                 height: 10.0.h,
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal: 5.0.w, vertical: 1.0.h),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     _buildBidTextField(auction),
//                                     SizedBox(
//                                       width: 2.0.w,
//                                     ),
//                                     _buildAuctionBidButton(context),
//                                   ],
//                                 )),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: ListTile(
//                                     title: Text('Choosing'.tr(),
//                                         style: TextStyle(
//                                             fontFamily: lang
//                                                 ? 'Walter_Becker'
//                                                 : 'Farsi_Far_Tow',
//                                             color: AppColors.kGreen,
//                                             fontSize: 12.0.sp)),
//                                   ),
//                                 ),
//                                 _buildBidRecommendedSelections(auction),
//                               ],
//                             ),
//                             _buildComments(context),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: AppColors.kWhite,
//                                   border: Border(
//                                     top:
//                                         BorderSide(color: Colors.grey.shade100),
//                                   ),
//                                   boxShadow: [ConstantWidgets.lightShadow]),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 5.0.w, vertical: 3.0.h),
//                               margin: EdgeInsets.symmetric(
//                                 vertical: 5.0.h,
//                               ),
//                               child: Align(
//                                 alignment: lang
//                                     ? Alignment.centerLeft
//                                     : Alignment.centerRight,
//                                 child: AutoSizeText(
//                                   "Description".tr() +
//                                       ' : ' +
//                                       auction.auctionMobileDescription,
//                                   style: TextStyle(
//                                       fontFamily: lang
//                                           ? 'Walter_Becker'
//                                           : 'Farsi_Far_Tow',
//                                       fontSize: 12.0.sp,
//                                       color: AppColors.kBlack),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                     return SizedBox.shrink();
//                   },
//                 ),
//               ),
//               BlocConsumer<TimerCubit, TimerState>(
//                 bloc: timerCubit,
//                 listener: (context, state) {
//                   if (state.isEnded) {
//                     _buildAuctionWaitingForResultAlertDialog(context);
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state.isOngoing)
//                     return Expanded(
//                       flex: 1,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: AppColors.kWhite,
//                             boxShadow: [ConstantWidgets.lightShadow]),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               "End in ".tr(),
//                               style: TextStyle(
//                                   fontFamily:
//                                       lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                                   fontSize: 12.0.sp,
//                                   color: AppColors.kMove),
//                             ),
//                             SizedBox(
//                               width: 5.0.w,
//                             ),
//                             _buildTimerRow()
//                           ],
//                         ),
//                       ),
//                     );
//                   // else if (timerCubit.state.isWaiting) {
//                   //   return Expanded(
//                   //     flex: 1,
//                   //     child: Container(
//                   //       decoration: BoxDecoration(
//                   //         color: AppColors.kGreen,
//                   //         borderRadius: BorderRadius.only(
//                   //           topRight: Radius.circular(8.0.w),
//                   //           topLeft: Radius.circular(8.0.w),
//                   //         ),
//                   //       ),
//                   //       width: 60.0.w,
//                   //       child: Row(
//                   //         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   //         crossAxisAlignment: CrossAxisAlignment.center,
//                   //         children: [
//                   //           Container(
//                   //             child: FittedBox(
//                   //               fit: BoxFit.scaleDown,
//                   //               alignment: lang
//                   //                   ? Alignment.centerLeft
//                   //                   : Alignment.centerRight,
//                   //               child: Text(
//                   //                 "Waiting for results ".tr(),
//                   //                 style: TextStyle(
//                   //                     fontFamily: lang
//                   //                         ? 'Walter_Becker'
//                   //                         : 'Farsi_Far_Tow',
//                   //                     fontSize: 10.0.sp,
//                   //                     color: AppColors.kWhite),
//                   //               ),
//                   //             ),
//                   //           ),
//                   //           _buildTimerRow()
//                   //         ],
//                   //       ),
//                   //     ),
//                   //   );
//                   // }
//                   /// maybe i will need this timer depending on new design
//                   return SizedBox.shrink();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   _buildTimerRow() {
//     return BlocBuilder<TimerCubit, TimerState>(
//       bloc: timerCubit,
//       builder: (context, state) {
//         final timerState = timerCubit.state;
//         return Row(
//           children: [
//             if (timerState.isOngoing) ...[
//               TimeCard(
//                 time: timerState.hours.toString(),
//               ),
//               SizedBox(
//                 width: 1.0.w,
//               ),
//               TimeCard(time: timerState.minutes.toString()),
//               SizedBox(
//                 width: 1.0.w,
//               ),
//             ],
//             TimeCard(time: timerState.seconds.toString()),
//           ],
//         );
//       },
//     );
//   }
//
//   void _buildAuctionResultAlertDialog(PusherState state, BuildContext context) {
//     AlertDialog alertDialog = AlertDialog(
//       backgroundColor: AppColors.kWhite,
//       elevation: 7,
//       title: Text(
//         state.closeEventPusherResponse.winnerId !=
//                 AppSharedPreferences.accessUserId
//             ? 'Sorry you have lost this auction\nHardLuck next time'.tr()
//             : 'You\'ve Won !\ngo to auction orders to complete your order'.tr(),
//         textAlign: TextAlign.center,
//         style: TextStyle(
//             color: AppColors.kMove,
//             fontSize: 14.0.sp,
//             fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//             fontWeight: FontWeight.bold),
//       ),
//       content: state.closeEventPusherResponse.winnerId !=
//               AppSharedPreferences.accessUserId
//           ? SharedElevetedButton(
//               buttonContent: 'Back to auctions',
//               buttonWidth: 50.0.w,
//               onPressed: () {
//                 Navigator.popUntil(context, (route) => route.isFirst);
//               },
//             )
//           : Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 SharedElevetedButton(
//                   buttonContent: 'Complete Now'.tr(),
//                   onPressed: () {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MyAuctionOrdersScreen(),
//                       ),
//                       (route) => route.isFirst,
//                     );
//                   },
//                 ),
//                 SharedElevetedButton(
//                   buttonContent: 'Complete Later'.tr(),
//                   onPressed: () {
//                     Navigator.popUntil(context, (route) => route.isFirst);
//                   },
//                 ),
//               ],
//             ),
//     );
//
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return WillPopScope(
//             onWillPop: () {
//               return Future.value(false);
//             },
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 30.0.h),
//               child: alertDialog,
//             ),
//           );
//         });
//   }
//
//   void _buildAuctionWaitingForResultAlertDialog(BuildContext context) {
//     AlertDialog alertDialog = AlertDialog(
//       backgroundColor: AppColors.kWhite,
//       elevation: 7,
//       title: Text(
//         'Waiting For Results'.tr(),
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: AppColors.kMove,
//           fontWeight: FontWeight.bold,
//           fontSize: 14.0.sp,
//           fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//         ),
//       ),
//       content: LoadingCircularWidget(),
//     );
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return WillPopScope(
//             onWillPop: () {
//               return Future.value(false);
//             },
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 30.0.h),
//               child: alertDialog,
//             ),
//           );
//         });
//   }
//
//   GestureDetector _buildComments(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           elevation: 7,
//           barrierColor: AppColors.kGray,
//           isDismissible: true,
//           enableDrag: true,
//           isScrollControlled: true,
//           builder: (BuildContext context) {
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom),
//                 child: BlocBuilder<CommentsCubit, CommentsState>(
//                   builder: (context, state) {
//                     return Container(
//                       width: 100.0.w,
//                       height: 50.0.h,
//                       padding: EdgeInsets.only(top: 2.0.h),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(8.0.w),
//                           topLeft: Radius.circular(8.0.w),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Comments".tr(),
//                             style: TextStyle(
//                                 fontFamily:
//                                     lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                                 color: AppColors.kBlack,
//                                 fontSize: 14.0.sp),
//                           ), //todo translate
//                           Divider(
//                             color: AppColors.kMove,
//                             thickness: 2.0,
//                           ),
//                           context
//                                           .watch<PusherCubit>()
//                                           .state
//                                           .commentEventPusherResponse ==
//                                       null &&
//                                   context
//                                       .read<PusherCubit>()
//                                       .auctionComments
//                                       .isEmpty
//                               ? Expanded(
//                                   child: Center(
//                                     child: Text(
//                                         'There are no comments for this auction'
//                                             .tr()),
//                                   ),
//                                 )
//                               : _buildCommentsWhenItIsNotEmpty(),
//
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 2.0.w),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Expanded(
//                                   flex: 8,
//                                   child: _buildCommentsTextField(),
//                                 ),
//                                 SizedBox(
//                                   width: 2.0.w,
//                                 ),
//                                 _buildCommentSubmitButton(context),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//       child: Container(
//         height: 10.0.h,
//         width: double.infinity,
//         color: Colors.grey.shade50,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               flex: 5,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 5.0.w),
//                 child: Align(
//                   alignment:
//                       lang ? Alignment.centerLeft : Alignment.centerRight,
//                   child: Text(
//                     "Comments".tr(),
//                     style: TextStyle(
//                         fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                         color: Colors.black,
//                         fontSize: 12.0.sp,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 color: AppColors.kGray.withOpacity(0.1),
//                 child: Icon(
//                   lang ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
//                   color: AppColors.kGreen,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   BlocConsumer<CommentsCubit, CommentsState> _buildCommentSubmitButton(
//       BuildContext context) {
//     return BlocConsumer<CommentsCubit, CommentsState>(
//       listener: (ctx, state) {
//         if (state is AddCommentSuccessful) {
//           commentController.clear();
//           FocusScope.of(context).unfocus();
//           return Fluttertoast.showToast(msg: state.message);
//         } else if (state is AddCommentSuccessful)
//           return Fluttertoast.showToast(msg: state.message);
//       },
//       builder: (context, state) {
//         if (state is AddCommentLoading) return LoadingCircularWidget();
//         return Expanded(
//           flex: 2,
//           child: Container(
//             height: 9.3.h,
//             child: TextButton(
//               onPressed: () {
//                 if (_commentKey.currentState.validate())
//                   context.read<CommentsCubit>().addComment(
//                       commentRequestModel: CommentRequestModel(
//                           auctionId: widget.auctionId,
//                           comment: commentController.text));
//               },
//               child: Text(
//                 'Send'.tr(),
//                 style: TextStyle(color: AppColors.kWhite),
//               ),
//               style: TextButton.styleFrom(
//                   backgroundColor: AppColors.kGreen, elevation: 2),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Form _buildCommentsTextField() {
//     return Form(
//       key: _commentKey,
//       child: TextFormField(
//         textAlignVertical: TextAlignVertical.center,
//         controller: commentController,
//         textAlign: lang ? TextAlign.start : TextAlign.start,
//         cursorColor: AppColors.kMove,
//         textDirection: lang ? ui.TextDirection.ltr : ui.TextDirection.ltr,
//         maxLines: null,
//         validator: (value) {
//           if (value.isEmpty)
//             return "The comment field is required".tr();
//           else if (value.length < 2)
//             return "Comment must be longer than 2 characters".tr();
//           else if (value.length > 500)
//             return 'Comment must be 500 characters at most'.tr();
//           return null;
//         },
//         keyboardType: TextInputType.multiline,
//         decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             hintText: "Place your comment".tr(),
//             hintStyle: TextStyle(
//                 fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                 color: AppColors.kGray),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColors.kGreen)),
//             focusColor: Colors.blue,
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: AppColors.kGray),
//             ),
//             enabled: true),
//         style: TextStyle(
//           fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//           fontSize: 12.0.sp,
//           color: Colors.black,
//           decoration: TextDecoration.none,
//         ),
//       ),
//     );
//   }
//
//   Expanded _buildCommentsWhenItIsNotEmpty() {
//     return Expanded(
//       child: BlocBuilder<PusherCubit, PusherState>(
//         builder: (context, state) {
//           final comments =
//               context.watch<PusherCubit>().state.commentEventPusherResponse;
//
//           return ListView.separated(
//             padding: EdgeInsets.only(left: 2.0.w, top: 5.0.w, right: 2.0.w),
//             shrinkWrap: true,
//             itemCount: comments != null
//                 ? comments.length
//                 : context.read<PusherCubit>().auctionComments.length,
//             itemBuilder: (context, index) {
//               return BuildComment(
//                 userName: comments != null
//                     ? comments[index].userDisplayName
//                     : context
//                         .read<PusherCubit>()
//                         .auctionComments[index]
//                         .userDisplayName,
//                 creationTime: comments != null
//                     ? comments[index].createdAt
//                     : context
//                         .read<PusherCubit>()
//                         .auctionComments[index]
//                         .createdAt,
//                 comment: comments != null
//                     ? comments[index].comment
//                     : context
//                         .read<PusherCubit>()
//                         .auctionComments[index]
//                         .comment,
//               );
//             },
//             separatorBuilder: (BuildContext context, int index) {
//               return Divider(
//                 color: AppColors.kMove,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   _buildBidRecommendedSelections(Auction auction) {
//     return Expanded(
//       child: BlocBuilder<PusherCubit, PusherState>(
//         builder: (context, state) {
//           final bidState = context.watch<PusherCubit>().state;
//           return Container(
//             width: 50.0.w,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 for (int index = 1; index <= 3; index++)
//                   BuildBidChoice(
//                     bidChoice: bidState.bidEventPusherResponse != null
//                         ? (bidState.bidEventPusherResponse.auctionLiveData
//                                     .currentHighestBid *
//                                 5 *
//                                 index ~/
//                                 100 +
//                             bidState.bidEventPusherResponse.auctionLiveData
//                                 .currentHighestBid)
//                         : (auction.currentHighestBid * 5 * index ~/ 100 +
//                             auction.currentHighestBid),
//                     onTap: () {
//                       setState(() {
//                         bidEditingController.text =
//                             bidState.bidEventPusherResponse != null
//                                 ? (bidState
//                                                 .bidEventPusherResponse
//                                                 .auctionLiveData
//                                                 .currentHighestBid *
//                                             5 *
//                                             index ~/
//                                             100 +
//                                         bidState.bidEventPusherResponse
//                                             .auctionLiveData.currentHighestBid)
//                                     .toString()
//                                 : (auction.currentHighestBid *
//                                             5 *
//                                             index ~/
//                                             100 +
//                                         auction.currentHighestBid)
//                                     .toString();
//                       });
//                     },
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   _buildBidTextField(Auction auction) {
//     return BlocBuilder<PusherCubit, PusherState>(
//       builder: (context, state) {
//         final bidState = context.watch<PusherCubit>().state;
//         return Form(
//           key: _bidKey,
//           child: Flexible(
//             child: TextFormField(
//               controller: bidEditingController,
//               cursorColor: AppColors.kMove,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               validator: (bidValue) {
//                 if (bidValue.isEmpty)
//                   return 'Bids field is required'.tr();
//                 else if (int.parse(bidValue) <= 100)
//                   return 'Bid value must be greater than 100'.tr();
//                 else if (bidState.bidEventPusherResponse != null) if (int.parse(
//                         bidValue) <=
//                     bidState.bidEventPusherResponse.auctionLiveData
//                         .currentHighestBid)
//                   return 'Bid value must be greater than current highest bid'
//                       .tr();
//                 else if (bidState.bidEventPusherResponse ==
//                     null) if (int.parse(bidValue) <= auction.currentHighestBid)
//                   return 'Bid value must be greater than current highest bid'
//                       .tr();
//                 else if (int.parse(bidValue) >= 10000000)
//                   return 'Bid value must be less than 10000000'.tr();
//                 return null;
//               },
//               decoration: InputDecoration(
//                 hintText: "Place_your_bid".tr(),
//                 hintStyle: TextStyle(
//                   fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                   fontSize: 14.0.sp,
//                   color: AppColors.kGray,
//                 ),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(2.0.w)),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(2.0.w),
//                     borderSide: BorderSide(color: AppColors.kGreen)),
//                 focusColor: Colors.blue,
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(2.0.w),
//                     borderSide: BorderSide(color: AppColors.kGray)),
//                 errorStyle: TextStyle(
//                     fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                     fontSize: 6.0.sp),
//               ),
//               style: TextStyle(
//                 fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                 fontSize: 16.0.sp,
//                 color: Colors.black,
//                 decoration: TextDecoration.none,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   BlocConsumer<BidCubit, BidState> _buildAuctionBidButton(
//       BuildContext context) {
//     return BlocConsumer<BidCubit, BidState>(
//       listener: (ctx, state) {
//         if (state is BidSuccess) {
//           bidEditingController.clear();
//           FocusScope.of(context).unfocus();
//           return Fluttertoast.showToast(msg: state.message);
//         } else if (state is BidError)
//           return Fluttertoast.showToast(msg: state.message);
//       },
//       builder: (ctx, state) {
//         if (state is BidLoading) return LoadingCircularWidget();
//         return TextButton(
//           child: Text(
//             'Bid'.tr(),
//           ),
//           style: ButtonStyle(
//               foregroundColor: MaterialStateProperty.all(AppColors.kWhite),
//               backgroundColor: MaterialStateProperty.all(AppColors.kGreen),
//               fixedSize: MaterialStateProperty.all(Size(20.0.w, 9.5.h))),
//           onPressed: () {
//             if (_bidKey.currentState.validate())
//               context.read<BidCubit>().bidOnAuction(
//                     bidRequestModel: BidRequestModel(
//                       auctionId: widget.auctionId,
//                       bidValue: int.parse(bidEditingController.text),
//                     ),
//                   );
//           },
//         );
//       },
//     );
//   }
//
//   Expanded _buildAuctionLeaderBoard(Auction auction, PusherState bidState) {
//     return Expanded(
//       flex: 2,
//       child: auction.auctionTopBidders.isEmpty &&
//               bidState.bidEventPusherResponse == null
//           ? _buildLeaderBoardWhenThereAreNotAnyTopBidders()
//           : _buildLeaderBoardWhenThereAreTopBidders(bidState, auction),
//     );
//   }
//
//   Container _buildLeaderBoardWhenThereAreTopBidders(
//       PusherState bidState, Auction auction) {
//     return Container(
//       padding: EdgeInsets.all(1.0.w),
//       margin:
//           lang ? EdgeInsets.only(right: 5.0.w) : EdgeInsets.only(left: 5.0.w),
//       decoration: ConstantWidgets.RoundedBoxWithLightShadow,
//       child: bidState.bidEventPusherResponse != null
//           ? ListView.separated(
//               shrinkWrap: true,
//               itemCount: bidState.bidEventPusherResponse.auctionLiveData
//                       .auctionTopBidders.length +
//                   2,
//               itemBuilder: (context, index) {
//                 return Container(
//                   width: 40.0.w,
//                   child: Row(
//                     mainAxisAlignment: index == 0
//                         ? MainAxisAlignment.center
//                         : MainAxisAlignment.spaceAround,
//                     children: [
//                       index == 0
//                           ? Container(
//                               child: Text(
//                                 'Leaderboard'.tr(),
//                                 style: TextStyle(color: AppColors.kMove),
//                               ),
//                             )
//                           : index == 1
//                               ? Text(
//                                   'Name'.tr(),
//                                   style: TextStyle(
//                                       fontSize: 8.0.sp, color: AppColors.kMove),
//                                 )
//                               : Text(
//                                   bidState
//                                       .bidEventPusherResponse
//                                       .auctionLiveData
//                                       .auctionTopBidders[index - 2]
//                                       .userDisplayName,
//                                   style: TextStyle(fontSize: 8.0.sp),
//                                 ),
//                       index == 0
//                           ? Container()
//                           : index == 1
//                               ? Text(
//                                   'Bid'.tr(),
//                                   style: TextStyle(
//                                       fontSize: 8.0.sp, color: AppColors.kMove),
//                                 )
//                               : Container(
//                                   width: 10.0.w,
//                                   child: FittedBox(
//                                     alignment: lang
//                                         ? Alignment.centerRight
//                                         : Alignment.centerLeft,
//                                     fit: BoxFit.scaleDown,
//                                     child: Text(
//                                       bidState
//                                           .bidEventPusherResponse
//                                           .auctionLiveData
//                                           .auctionTopBidders[index - 2]
//                                           .bidValue
//                                           .toString(),
//                                       style: TextStyle(fontSize: 8.0.sp),
//                                     ),
//                                   ),
//                                 ),
//                     ],
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return Divider(
//                   color: AppColors.kGreen,
//                 );
//               },
//             )
//           : ListView.separated(
//               shrinkWrap: true,
//               itemCount: auction.auctionTopBidders.length + 2,
//               itemBuilder: (context, index) {
//                 return Container(
//                   width: 40.0.w,
//                   child: Row(
//                     mainAxisAlignment: index == 0
//                         ? MainAxisAlignment.center
//                         : MainAxisAlignment.spaceAround,
//                     children: [
//                       index == 0
//                           ? Container(
//                               child: Text(
//                                 'Leaderboard'.tr(),
//                                 style: TextStyle(color: AppColors.kMove),
//                               ),
//                             )
//                           : index == 1
//                               ? Text(
//                                   'Name'.tr(),
//                                   style: TextStyle(
//                                       fontSize: 8.0.sp, color: AppColors.kMove),
//                                 )
//                               : Text(
//                                   auction.auctionTopBidders[index - 2]
//                                       .userDisplayName,
//                                   style: TextStyle(fontSize: 8.0.sp),
//                                 ),
//                       index == 0
//                           ? Container()
//                           : index == 1
//                               ? Text(
//                                   'Bid'.tr(),
//                                   style: TextStyle(
//                                       fontSize: 8.0.sp, color: AppColors.kMove),
//                                 )
//                               : Container(
//                                   width: 10.0.w,
//                                   child: FittedBox(
//                                     alignment: lang
//                                         ? Alignment.centerRight
//                                         : Alignment.centerLeft,
//                                     fit: BoxFit.scaleDown,
//                                     child: Text(
//                                       auction
//                                           .auctionTopBidders[index - 2].bidValue
//                                           .toString(),
//                                       style: TextStyle(fontSize: 8.0.sp),
//                                     ),
//                                   ),
//                                 ),
//                     ],
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return Divider(
//                   color: AppColors.kGreen,
//                 );
//               },
//             ),
//     );
//   }
//
//   Container _buildLeaderBoardWhenThereAreNotAnyTopBidders() {
//     return Container(
//       padding: EdgeInsets.all(1.0.w),
//       margin:
//           lang ? EdgeInsets.only(right: 5.0.w) : EdgeInsets.only(left: 5.0.w),
//       decoration: ConstantWidgets.RoundedBoxWithLightShadow,
//       child: ListView(
//         shrinkWrap: true,
//         children: [
//           Center(
//             child: Container(
//               child: Text(
//                 'Leaderboard'.tr(),
//                 style: TextStyle(color: AppColors.kMove),
//               ),
//             ),
//           ),
//           Divider(
//             color: AppColors.kGreen,
//           ),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//             Text(
//               'Name'.tr(),
//               style: TextStyle(fontSize: 8.0.sp, color: AppColors.kMove),
//             ),
//             Text(
//               'Bid'.tr(),
//               style: TextStyle(fontSize: 8.0.sp, color: AppColors.kMove),
//             )
//           ])
//         ],
//       ),
//     );
//   }
//
//   Expanded _buildAuctionDetails(Auction auction, PusherState bidState) {
//     return Expanded(
//       flex: 3,
//       child: Container(
//         width: 30.0.w,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 2.0.w),
//               padding: EdgeInsets.symmetric(horizontal: 5.0.w),
//               child: FittedBox(
//                 fit: BoxFit.scaleDown,
//                 alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
//                 child: Text(
//                   auction.auctionName,
//                   style: TextStyle(
//                       fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                       fontSize: 14.0.sp,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.kBlack),
//                 ),
//               ),
//             ),
//             _buildAuctionDetailItem(
//                 title: "Your Auction Name".tr(),
//                 value: auction.userDisplayName,
//                 valueContainerColor: AppColors.kMove),
//             _buildAuctionDetailItem(
//                 title: "Total Enrollments".tr(),
//                 value: bidState.bidEventPusherResponse != null
//                     ? bidState
//                         .bidEventPusherResponse.auctionLiveData.totalEnrollments
//                         .toString()
//                     : auction.userEnrollmentsCount.toString(),
//                 valueContainerColor: AppColors.kGray.withOpacity(0.5)),
//             _buildAuctionDetailItem(
//                 title: "Total Bidders".tr(),
//                 value: bidState.bidEventPusherResponse != null
//                     ? bidState
//                         .bidEventPusherResponse.auctionLiveData.totalBidders
//                         .toString()
//                     : auction.totalBidders.toString() + "Bids".tr(),
//                 valueContainerColor: AppColors.kGray.withOpacity(0.5)),
//             _buildAuctionDetailItem(
//                 title: "Current highest bid".tr(),
//                 value: bidState.bidEventPusherResponse != null
//                     ? bidState.bidEventPusherResponse.auctionLiveData
//                         .currentHighestBid
//                         .toString()
//                     : auction.currentHighestBid.toString(),
//                 valueContainerColor: AppColors.kMove)
//           ],
//         ),
//       ),
//     );
//   }
//
//   Container _buildAuctionDetailItem(
//       {Color valueContainerColor, String title, String value}) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 2.0.w),
//       padding: EdgeInsets.symmetric(horizontal: 5.0.w),
//       child: FittedBox(
//         fit: BoxFit.scaleDown,
//         alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
//         child: Row(
//           children: [
//             Container(
//               padding: EdgeInsets.all(2.0.w),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(1.0.w),
//                   color: AppColors.kGray.withOpacity(0.06)),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                     fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                     fontSize: 10.0.sp,
//                     color: AppColors.kGray.withOpacity(0.4)),
//               ),
//             ),
//             SizedBox(
//               width: 1.0.w,
//             ),
//             Container(
//               padding: EdgeInsets.all(2.0.w),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(1.0.w),
//                   color: valueContainerColor),
//               child: Text(
//                 value,
//                 style: TextStyle(
//                     fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                     fontSize: 10.0.sp,
//                     color: AppColors.kWhite),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Container _buildAuctionImagesSlider(Auction auction) {
//     return Container(
//       width: 100.0.w,
//       height: 33.0.h,
//       child: ExpandablePageView(
//         onPageChanged: (imageIndex) {
//           setState(() {
//             index = imageIndex;
//           });
//         },
//         physics: PageScrollPhysics(),
//         children: [
//           if (auction.images.isEmpty)
//             BuildProductImage(
//               productImage: AppSettings.BASE_URL + auction.auctionMainImage,
//             ),
//           for (var image in auction.images)
//             BuildProductImage(
//               productImage: AppSettings.BASE_URL + image.imageName,
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class BuildComment extends StatelessWidget {
//   const BuildComment({
//     Key key,
//     this.userName,
//     this.creationTime,
//     this.comment,
//   }) : super(key: key);
//   final String userName;
//   final String creationTime;
//   final String comment;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(5.0.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             backgroundColor: AppColors.kGreen,
//             foregroundColor: AppColors.kWhite,
//             radius: 8.0.w,
//             child: Image.asset(
//               AppAssets.userIcon,
//               width: 10.0.w,
//               fit: BoxFit.contain,
//             ),
//           ),
//           SizedBox(
//             width: 5.0.w,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 65.0.w,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       userName,
//                       style: TextStyle(
//                           fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                           fontSize: 12.0.sp),
//                     ),
//                     Text(creationTime,
//                         style: TextStyle(
//                             fontFamily:
//                                 lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                             fontSize: 10.0.sp)),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 2.0.h,
//               ),
//               AutoSizeText(comment)
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
