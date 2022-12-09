// import 'dart:math';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:elite_auction/core/constants/app_assets.dart';
// import 'package:elite_auction/features/auctions/domain/auctions_cubit.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/constants/AppColors.dart';
// import '../../../../global.dart';
//
// Widget AuctionsSharedAppBar({
//   BuildContext context,
//   String appBarTitle,
//   int appBarTitleItemCount,
//   bool canGoBack = false,
//   Widget TapBar,
//   Function filterAuctions,
//   String value,
// }) {
//   return AppBar(
//     bottom: TapBar ?? null,
//     elevation: 0,
//     backgroundColor: AppColors.kGreen,
//     centerTitle: true,
//     title: FittedBox(
//       child: RichText(
//         text: TextSpan(
//           text: appBarTitle + ' ',
//           style: TextStyle(
//               fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//               fontSize: 16.0.sp,
//               color: AppColors.kWhite,
//               fontWeight: FontWeight.normal),
//         ),
//       ),
//     ),
//     leading: canGoBack
//         ? lang
//             ? GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Transform.translate(
//                   offset: Offset(0, 2),
//                   child: Transform.scale(
//                       scale: 1.2, child: Image.asset(AppAssets.back)),
//                 ))
//             : GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Transform.translate(
//                   offset: Offset(0, -2),
//                   child: Transform.rotate(
//                       angle: pi,
//                       child: Transform.scale(
//                           scale: 1.2, child: Image.asset(AppAssets.back))),
//                 ))
//         : null,
//   );
// }
