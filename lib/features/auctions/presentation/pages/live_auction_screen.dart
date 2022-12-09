// import 'package:better_player/better_player.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:elite_auction/features/auctions/presentation/widgets/auctions_shared_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sizer/sizer.dart';
// import 'dart:ui' as ui;
// import '../../../../core/constants/AppColors.dart';
// import '../../../../core/widgets/loading.dart';
// import '../../../../global.dart';
// import '../../data/add_comment_request_model.dart';
// import '../../domain/normal_auction_domain/comments_cubit.dart';
//
// class LiveAuctionScreen extends StatefulWidget {
//   @override
//   State<LiveAuctionScreen> createState() => _LiveAuctionScreenState();
// }
//
// class _LiveAuctionScreenState extends State<LiveAuctionScreen> {
//   BetterPlayerController _betterPlayerController;
//   final TextEditingController commentController = TextEditingController();
//   final GlobalKey<FormState> _commentKey = GlobalKey();
//   @override
//   void initState() {
//     super.initState();
//     BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       "https://live.api.video/li5Xn3jbKEJ4sQ5zOi2k3TIC.m3u8",
//       liveStream: true,
//     );
//     _betterPlayerController = BetterPlayerController(
//         BetterPlayerConfiguration(
//             autoPlay: true,
//             looping: false,
//             expandToFill: false,
//             controlsConfiguration: BetterPlayerControlsConfiguration(
//               iconsColor: AppColors.kGreen,
//               enableFullscreen: false,
//               controlBarColor: AppColors.kWhite,
//               enablePlayPause: false,
//               enableSubtitles: false,
//               enablePlaybackSpeed: false,
//               enableSkips: false,
//             ),
//             aspectRatio: 9 / 16,
//             autoDispose: false),
//         betterPlayerDataSource: betterPlayerDataSource);
//     _betterPlayerController.addEventsListener((event) {
//       print("Better player event: ${event.betterPlayerEventType}");
//     });
//   }
//
//   @override
//   void dispose() {
//     _betterPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext auctionContext) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AuctionsSharedAppBar(
//             context: context, appBarTitle: 'Live Auction', canGoBack: true),
//         backgroundColor: AppColors.kWhite,
//         body: Column(children: [
//           Expanded(
//             child: BetterPlayer(
//               controller: _betterPlayerController,
//             ),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "Comments".tr(),
//                   style: TextStyle(
//                       fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                       color: AppColors.kBlack,
//                       fontSize: 14.0.sp),
//                 ), //todo translate
//                 Divider(
//                   color: AppColors.kMove,
//                   thickness: 2.0,
//                 ),
//                 // context.watch<PusherCubit>().state.commentEventPusherResponse ==
//                 //             null &&
//                 //         context.read<PusherCubit>().auctionComments.isEmpty
//                 //     ?
//                 Expanded(
//                   child: Center(
//                     child: Text('There are no comments for this auction'.tr()),
//                   ),
//                 ),
//                 // : _buildCommentsWhenItIsNotEmpty(),
//
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       flex: 8,
//                       child: _buildCommentsTextField(),
//                     ),
//                     SizedBox(
//                       width: 2.0.w,
//                     ),
//                     _buildCommentSubmitButton(context),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ]),
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
//                 // if (_commentKey.currentState.validate())
//                 //   context.read<CommentsCubit>().addComment(
//                 //       commentRequestModel: CommentRequestModel(
//                 //           auctionId: widget.auctionId,
//                 //           comment: commentController.text));
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
// }
