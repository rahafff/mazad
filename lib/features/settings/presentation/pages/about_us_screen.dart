import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/widgets/loading_circular.dart';
import '../../domain/entities/about_us_entity.dart';
import '../manager/about_us_cubit.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutUsCubit>(
      create: (context) => di.sl<AboutUsCubit>()..emitGetAboutUs(),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.aboutUs.tr(),
              ),
              leading: const BackButtonWidget(),
            ),
            body: ListView(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              padding:
                  EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.0.h),
              children: [
                Image.asset(
                  ImageAssetsManager.eliteLogoWithEliteWords,
                  fit: BoxFit.contain,
                  height: 40.h,
                ),
                _buildAboutUsText(),
              ],
            ),
          ),
        );
      }),
    );
  }

  _buildAboutUsText() {
    return BlocBuilder<AboutUsCubit, StandardState<AboutUsEntity>>(
      builder: (context, state) {
        return state.when(
            loading: () => Padding(
                  padding: EdgeInsets.all(10.0.h),
                  child: LoadingCircularWidget(),
                ),
            success: (entity) {
              String description = context
                  .read<AboutUsCubit>()
                  .parseHtmlString(entity.aboutUs?.aboutUsDescription ?? '');
              return AutoSizeText(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              );
            },
            error: (error) => const SizedBox.shrink());
      },
    );
  }
}
