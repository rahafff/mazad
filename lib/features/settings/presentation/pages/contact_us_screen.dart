import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/core/widgets/loading_circular.dart';
import 'package:elite_auction/core/widgets/sized_box_functions.dart';
import 'package:elite_auction/features/settings/domain/entities/company_info_entity.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/resources/assets_manager.dart';
import '../manager/contact_us_cubit.dart';
import '../widgets/contact_us_card.dart';
import '../widgets/contacting_method_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactUsCubit>(
      create: (_) => di.sl<ContactUsCubit>()..emitGetCompanyInfo(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.contactUs.tr(),
            ),
            leading: const BackButtonWidget(),
          ),
          body: BlocBuilder<ContactUsCubit, StandardState<CompanyInfo>>(
            builder: (context, state) {
              return state.when(
                loading: () => LoadingCircularWidget(),
                success: (entity) {
                  return Container(
                    height: 100.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage(ImageAssetsManager.contactUsBackground),
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                          left: 5.w, right: 5.0.w, top: 3.0.h, bottom: 5.0.h),
                      children: [
                        ContactUsCard(
                          cardTitle: AppStrings.ourLocation.tr(),
                          cardContent: Text(
                            entity.address,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        ContactUsCard(
                          cardTitle: AppStrings.conUsAnyTime.tr(),
                          cardContent: Column(
                            children: [
                              ContactingMethod(
                                methodContent: entity.phone,
                                methodTitle: AppStrings.phone.tr(),
                                onTappingMethod: () {
                                  launchUrl(
                                    Uri(
                                      scheme: 'tel',
                                      path: entity.phone,
                                    ),
                                  );
                                },
                              ),
                              SizedBoxFunctions.verticalSizedBox(1),
                              ContactingMethod(
                                methodContent: entity.email,
                                methodTitle: AppStrings.email.tr(),
                                onTappingMethod: () {
                                  launchUrl(
                                    Uri.parse('mailto:${entity.email}'),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        ContactUsCard(
                          cardTitle: AppStrings.policies.tr(),
                          cardContent: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launchUrl(EndPoints.privacyUrl);
                                },
                                child: Text(
                                  AppStrings.priPolicy.tr(),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                              SizedBoxFunctions.verticalSizedBox(1),
                              GestureDetector(
                                onTap: () {
                                  launchUrl(EndPoints.termsUrl);
                                },
                                child: Text(
                                  AppStrings.termsAndCond.tr(),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                error: (error) => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }
}
