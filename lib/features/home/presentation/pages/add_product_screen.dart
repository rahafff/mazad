import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as p;
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/global_states/posting_state.dart';
import '../../../../core/global_states/standard_state.dart';
import '../../../../core/models/empty_success_response_entity.dart';
import '../../../../core/resources/app_validation_functions.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/theme_manager.dart';
import '../../../../core/utils/global.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/image_place_holder.dart';
import '../../../../core/widgets/loading_circular.dart';
import '../../../../core/widgets/sized_box_functions.dart';
import '../../../../core/widgets/video_place_holder.dart';
import '../../../../injection_container.dart';
import '../../domain/bodies/add_product_body.dart';
import '../../domain/entities/subsubcategories_entity.dart';
import '../manager/product_operations_cubit.dart';
import '../manager/subsubcategories_cubit.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen(
      {Key? key,
      required this.categoryName,
      required this.subcategoryName,
      required this.subcategoryId})
      : super(key: key);
  final String categoryName;
  final String subcategoryName;
  final int subcategoryId;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final String qatarFlag = "qa".toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  double videoSize = 200;
  final GlobalKey<FormState> addFormKey = GlobalKey();
  VideoPlayerController? videoController;
  bool isMediaArrayFull = false;
  List<File>? mediaArray = [];
  int maxAssets = 2;
  File? pickedVideo;
  XFile? capturedVideo;
  File? mainImage;
  File? firstOptionalImage;
  File? secondOptionalImage;
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _productNameAr = TextEditingController();
  final TextEditingController _productNameEn = TextEditingController();
  final TextEditingController _productDescriptionAr = TextEditingController();
  final TextEditingController _productDescriptionEn = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productQuantity = TextEditingController();
  Subsubcategory? selectedSubsubcategory;

  File convertToFile(XFile xFile) => File(xFile.path);


  Future<List<AssetEntity>?> _getPickedMedia(
      {required int maxAssets,
      bool isPickingImagesOnly = false,
      bool isMainImageButton = false,
      // required bool isAllowedRecordVideo
      }) async {
    const AssetPickerTextDelegate englishTextDelegate =
        EnglishAssetPickerTextDelegate();
    AssetPickerTextDelegate arabicTextDelegate = const ArabicAssetPickerTextDelegate();
    List<AssetEntity>? result;
    result = await AssetPicker.pickAssets(context,
        pickerConfig: AssetPickerConfig(
          textDelegate: lang ? englishTextDelegate : arabicTextDelegate,
          maxAssets: isPickingImagesOnly ? 1 : maxAssets,
          filterOptions: FilterOptionGroup(
            containsLivePhotos: true,
          ),
          requestType:
              isPickingImagesOnly ? RequestType.image : RequestType.common,
          specialItemPosition: SpecialItemPosition.prepend,
          pickerTheme: getApplicationTheme(),
          specialItemBuilder: (
            BuildContext context,
            AssetPathEntity? path,
            int length,
          ) {
            if (path?.isAll != true) {
              return null;
            }
            return Semantics(
              label: lang
                  ? englishTextDelegate.sActionUseCameraHint
                  : arabicTextDelegate.sActionUseCameraHint,
              button: true,
              onTapHint: lang
                  ? englishTextDelegate.sActionUseCameraHint
                  : arabicTextDelegate.sActionUseCameraHint,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  result = await _pickFromCamera(context,
                      isMainImageButton: isMainImageButton,
                      // isAllowedRecordVideo: isAllowedRecordVideo
                  );
                },
                child: Center(
                  child: Icon(Icons.camera_alt_rounded, size: 8.w),
                ),
              ),
            );
          },
        ));
    return result;
  }




  _initController(File video) async {
    _getFileSize(video);
    videoController = VideoPlayerController.file(video!)
      ..initialize().then((_) {
        setState(() {
          videoController!.pause();
        });
      });
  }

  double _getFileSize(File? file) {
    int sizeInBytes = file!.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  _pickFromCamera(BuildContext c,
      {
        required bool isMainImageButton,
        // required bool isAllowedRecordVideo
      }) {
    EnglishCameraPickerTextDelegate englishTextDelegate =
        const EnglishCameraPickerTextDelegate();

    return CameraPicker.pickFromCamera(
      c,
      pickerConfig: CameraPickerConfig(
        textDelegate: englishTextDelegate,
        // enablePinchToZoom: isAllowedRecordVideo,
        // maximumRecordingDuration:
            // isAllowedRecordVideo ? const Duration(minutes: 1) : null,
        // enableExposureControlOnPoint: isAllowedRecordVideo,
        // enablePullToZoomInRecord: isAllowedRecordVideo,
        // enableAudio: isAllowedRecordVideo,
        // enableScaledPreview: isAllowedRecordVideo,
        // enableSetExposure: isAllowedRecordVideo,
        // enableRecording: isAllowedRecordVideo,
        // onXFileCaptured: isAllowedRecordVideo
        //     ? (XFile file, CameraPickerViewType viewType) {
        //         if (file != null) {
        //           if (viewType == CameraPickerViewType.video) {
        //             capturedVideo = file;
        //           }
        //         }
        //         // Pass the file out of the saving method's scope.
        //         // Pop twice without any result to exit the picker.
        //         // Navigator.of(context).pop();
        //         // Navigator.of(context).pop();
        //         return pickedVideo != null;
        //       }
        //     : null,
        onEntitySaving: (context, viewType, file) {
          // if (viewType == CameraPickerViewType.video) {
          //   pickedVideo = convertToFile(capturedVideo!);
          //   mediaArray!.add(pickedVideo!);
          //   // _initController(pickedVideo!);
          // }
          // else
          //   {
            if (isMainImageButton == true) {
              mainImage ??= file;
            } else {
              if (firstOptionalImage != null) {
                mediaArray!.add(file);
                secondOptionalImage = file;
              } else if (pickedVideo != null) {
                mediaArray!.add(file);
                firstOptionalImage = file;
              } else if (capturedVideo != null) {
                pickedVideo = convertToFile(capturedVideo!);
                mediaArray!.add(pickedVideo!);
                _initController(pickedVideo!);
              } else {
                mediaArray!.add(file);
                firstOptionalImage = file;
              }
            }
          // }
          Fluttertoast.showToast(
              msg: AppStrings.savedSuccessfully.tr(),
              toastLength: Toast.LENGTH_SHORT);
          setState(() {});
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void dispose()
  {
    mediaArray!.clear();
    _phone.dispose();
    mainImage == null;
    firstOptionalImage == null;
    secondOptionalImage == null;
    pickedVideo == null;
    capturedVideo == null;
    _productDescriptionAr.dispose();
    _productNameAr.dispose();
    _productDescriptionEn.dispose();
    _productNameEn.dispose();
    _productQuantity.dispose();
    _productPrice.dispose();
    if (videoController != null && videoController!.value.isInitialized) {
      videoController!.dispose();
    }
    super.dispose();
  }

  Duration videoDuration = const Duration(seconds: 2);

  @override
  Widget build(BuildContext context)
  {
    isMediaArrayFull=(mediaArray!.length == 2);
    return BlocProvider<ProductOperationsCubit>(
      create: (context) => sl<ProductOperationsCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.addProduct.tr(),),
          leading: const BackButtonWidget(),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<SubsubcategoriesCubit>(
              create: (context) => sl<SubsubcategoriesCubit>()
                ..emitGetSubsubategories(widget.subcategoryId),
            ),
          ],
          child: SingleChildScrollView(
            child: Form(
              key: addFormKey,
              child: Column(
                 children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                    child: Column(
                      children: [
                        SizedBoxFunctions.verticalSizedBox(3),
                        Row(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        widget.categoryName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        widget.subcategoryName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ),
                                    BlocBuilder<SubsubcategoriesCubit,
                                        StandardState<List<Subsubcategory?>>>(
                                      builder: (context, state) {
                                        return state.maybeWhen(
                                          orElse: () => const SizedBox.shrink(),
                                          success: (data) => data.isEmpty
                                              ? const SizedBox.shrink()
                                              : DropdownButtonHideUnderline(
                                                  child: DropdownButton<
                                                      Subsubcategory>(
                                                    items: data
                                                        .map<
                                                            DropdownMenuItem<
                                                                Subsubcategory>>(
                                                          (subsubcategory) =>
                                                              DropdownMenuItem(
                                                            value:
                                                                subsubcategory,
                                                            child: Text(
                                                                subsubcategory!
                                                                    .subsubcategoryName!),
                                                          ),
                                                        )
                                                        .toList(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                    itemHeight: 10.h,
                                                    hint: Text(
                                                      AppStrings
                                                          .selectSubcategory
                                                          .tr(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                    ),
                                                    isExpanded: true,
                                                    onChanged: (selectedValue) {
                                                      setState(() {
                                                        selectedSubsubcategory =
                                                            selectedValue;
                                                      });
                                                    },
                                                    value:
                                                        selectedSubsubcategory,
                                                  ),
                                                ),
                                        );
                                      },
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () async {
                                          if (mainImage == null) {
                                            _getPickedMedia(
                                                    maxAssets: 1,
                                                    isPickingImagesOnly: true,
                                                    isMainImageButton: true,
                                                    // isAllowedRecordVideo: false
                                            )
                                                .then((value) async {
                                              if (value != null) {
                                                mainImage =
                                                    await value![0].file;
                                                setState(() {});
                                              }
                                            });
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: mainImage == null
                                                ? Colors.green
                                                : Colors.grey,
                                            foregroundColor:
                                                ColorManager.kWhite),
                                        child: Row(
                                          children: [
                                            SizedBoxFunctions.horizontalSizedBox(2),
                                            Text(
                                              AppStrings.addPicture.tr(),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: ColorManager
                                                          .kWhite),
                                            ),
                                            const Spacer(),
                                            const Icon(Icons.add),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBoxFunctions.horizontalSizedBox(2),
                            mainImage != null
                                ? ImagePlaceHolder.imagePlacer(
                                    index: 0, image: mainImage)
                                : buildHolder(isMainImage: true),
                          ],
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        TextButton(
                          onPressed: () async {
                            isMediaArrayFull
                                ? null
                                : _getPickedMedia(
                                        maxAssets: maxAssets,
                                        isPickingImagesOnly:
                                            pickedVideo != null ? true : false,
                                        // isAllowedRecordVideo:
                                        //     pickedVideo == null ? true : false
                            )
                                    .then((value) async {
                                    if (value != null) {
                                      for (int i = 0; i < value.length; i++) {
                                        // a loop to check if values I've chosen are video or images
                                        File? file = await value[i]
                                            .file; // get file from AssetEntity
                                        if (value[i].type == AssetType.video) {
                                          //the chosen value is video
                                          if (_getFileSize(file) < videoSize) {
                                            String fileExtension = p.extension(file!.path).toUpperCase();
                                            //if the size of chosen video less than 200 MB
                                            if (fileExtension=='.MP4'|| fileExtension=='.WEBM'||fileExtension=='.MOV'  || fileExtension=='.OGG') // to check format of video
                                            {
                                              pickedVideo = file; // store video
                                              mediaArray!.add(
                                                  file!); // add it to list has created for files
                                              // maxAssets=maxAssets-1;
                                              _initController(
                                                  pickedVideo!); //initializing controller
                                              setState(() {});
                                            } else {
                                              // var file = await DefaultCacheManager().putFile(realPath + "/WhatCarCanYouGetForAGrand.mp4", bytes, fileExtension: 'mp4');
                                              Fluttertoast.showToast(
                                                  msg: AppStrings
                                                      .sorryCouldntUploadThisTypeOfVideo
                                                      .tr()); //if the format of chosen video unsupported
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: AppStrings
                                                    .sorryYourVideoIsTooLargePleaseChooseAnotherOne
                                                    .tr()); //if the size of chosen video greater than 200 MB
                                          }
                                        } else //chosen values are images
                                        {
                                          mediaArray!
                                              .add(file!); // add it to the list
                                          if (value.length ==
                                              2) //choosing 2 images by single click on button
                                          {
                                            i == 0
                                                ? firstOptionalImage =
                                                    await value[0].file
                                                : secondOptionalImage =
                                                    await value[1]
                                                        .file; //put the first item of array in firstImage and second item in secondImage
                                            setState(() {});
                                          } else //choosing one image by single click on button
                                          {
                                            firstOptionalImage != null
                                                ? secondOptionalImage =
                                                    await value[0].file
                                                : firstOptionalImage = await value[
                                                        0]
                                                    .file; //if I've chosen image before then put item in secondImage otherwise (this is the first time I choose image) then put value in secondImage
                                            maxAssets = maxAssets - 1; //when choosing one image decrease max value
                                            setState(() {});
                                          }
                                        }
                                      }
                                    }
                                  });
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: isMediaArrayFull
                                  ? ColorManager.grayText
                                  : ColorManager.kGreen,
                              foregroundColor: ColorManager
                                  .kWhite), // AssetEntity(id: 648 , type: AssetType.image)
                          child: Row(
                            children: [
                              SizedBoxFunctions.horizontalSizedBox(2),
                              Text(
                                AppStrings.addMedia.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: ColorManager.kWhite),
                              ),
                              const Spacer(),
                              const Icon(Icons.add),
                            ],
                          ),
                          ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        Row(
                          children: [
                            Visibility(
                                visible: mediaArray!.isEmpty ||
                                    mediaArray!.length == 1,
                                child: buildHolder()),
                            Visibility(
                                visible: mediaArray!.isEmpty,
                                child: buildHolder()),
                            firstOptionalImage != null
                                ? ImagePlaceHolder.imagePlacer(
                                    index: 0, image: firstOptionalImage)
                                : SizedBox.shrink(),
                            secondOptionalImage != null
                                ? ImagePlaceHolder.imagePlacer(
                                    index: 1, image: secondOptionalImage)
                                : SizedBox.shrink(),
                            pickedVideo != null
                                ? VideoPlaceHolder.videoPlacer(
                                    video: pickedVideo,
                                    videoController: videoController,
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        CustomTextFormField(
                          validator: (value) {
                            return AppValidation.validateOnArabicCharacters(
                                value!);
                          },
                          labelText: AppStrings.productArabicName.tr(),
                          controller: _productNameAr,
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        CustomTextFormField(
                          validator: (value) {
                            return AppValidation.validateOnArabicCharacters(value!);
                          },
                          labelText: AppStrings.productArabicDescription.tr(),
                          controller: _productDescriptionAr,
                          maxLines: null,
                          keyBoardType: TextInputType.multiline,
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        CustomTextFormField(
                          validator: (value) {
                            return AppValidation.validateOnEnglishCharacters(
                                value!);
                          },
                          labelText: AppStrings.productEnglishName.tr(),
                          controller: _productNameEn,
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        CustomTextFormField(
                          validator: (value) {
                            return AppValidation.validateOnEnglishCharacters(
                                value!);
                          },
                          labelText: AppStrings.productEnglishDescription.tr(),
                          maxLines: null,
                          keyBoardType: TextInputType.multiline,
                          controller: _productDescriptionEn,
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        CustomTextFormField(
                          validator: (value) {
                            return AppValidation.validateOnNumbers(value!);
                          },
                          labelText: AppStrings.phone.tr(),
                          prefixText: "+974",
                          controller: _phone,
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
                    color: ColorManager.lightGrayButtonColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.productPricing.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: ColorManager.grayText),
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        TextFormField(
                          controller: _productPrice,
                          validator: (value) {
                            return AppValidation.validateOnNumbers(value!);
                          },
                          decoration: InputDecoration(
                            disabledBorder: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(),
                            errorBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: ColorManager.kWhite,
                            focusedBorder: const OutlineInputBorder(),
                            focusedErrorBorder: const OutlineInputBorder(),
                            hintText: AppStrings.placePriceInQA.tr(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 3.0.w),
                            suffixIconConstraints: const BoxConstraints(),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                qatarFlag,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: ColorManager.kWhite,
                            border: Border.all(color: ColorManager.midumeGray),
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.w),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(AppStrings.quantity.tr()),
                              ),
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  validator: (value) {
                                    return AppValidation.validateOnNumbers(
                                        value!);
                                  },
                                  controller: _productQuantity,
                                  decoration: InputDecoration(
                                    disabledBorder: const OutlineInputBorder(),
                                    enabledBorder: const OutlineInputBorder(),
                                    errorBorder: const OutlineInputBorder(),
                                    filled: true,
                                    fillColor: ColorManager.kWhite,
                                    isDense: true,
                                    focusedBorder: const OutlineInputBorder(),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.h,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        SizedBox(
                          width: double.infinity,
                          height: 10.h,
                          child: BlocConsumer<ProductOperationsCubit,
                              PostingState<EmptySuccessResponseEntity>>(
                            listener: (context, state) {
                              state.whenOrNull(
                                success: (entity) {
                                   Fluttertoast.showToast(
                                      msg: entity.message,
                                      toastLength: Toast.LENGTH_SHORT);
                                  Navigator.restorablePopAndPushNamed(
                                      context, Routes.myProductsRoute);
                                },
                                error: (error) {
                                   Fluttertoast.showToast(
                                      msg: NetworkExceptions.getErrorMessage(
                                          error),
                                      toastLength: Toast.LENGTH_SHORT);
                                },
                              );
                            },
                            builder: (context, state) {
                              return state.maybeWhen(
                                loading: () => LoadingCircularWidget(),
                                orElse: () => TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: ColorManager.kGreen,
                                      foregroundColor: ColorManager.kWhite),
                                  onPressed: () async {
                                    if (addFormKey.currentState!.validate()) {
                                      if (mainImage == null) {
                                        Fluttertoast.showToast(
                                            msg: AppStrings
                                                .pleasePickTheMainPicture
                                                .tr());
                                        return;
                                      } else if (selectedSubsubcategory ==
                                              null &&
                                          context
                                              .read<SubsubcategoriesCubit>()
                                              .state
                                              .maybeWhen(
                                                orElse: () => true,
                                                success: (data) =>
                                                    data.isNotEmpty,
                                              )) {
                                        Fluttertoast.showToast(
                                            msg: AppStrings
                                                .pleaseSelectASubcategory
                                                .tr());
                                        return;
                                      }
                                      context
                                          .read<ProductOperationsCubit>()
                                          .emitAddProduct(
                                            AddProductBody(
                                                productNameEn:
                                                    _productNameEn.text,
                                                productNameAr:
                                                    _productNameAr.text,
                                                subcategoryId:
                                                    widget.subcategoryId,
                                                productPrice:
                                                    _productPrice.text,
                                                phone: "+974${_phone.text}",
                                                subsubcategoryId:
                                                    selectedSubsubcategory !=
                                                            null
                                                        ? selectedSubsubcategory
                                                            ?.id as int
                                                        : null,
                                                productDescriptionAr:
                                                    _productDescriptionAr.text,
                                                productDescriptionEn:
                                                    _productDescriptionEn.text,
                                                firstOptionalImage:
                                                    firstOptionalImage,
                                                secondOptionalImage:
                                                    secondOptionalImage ??
                                                        pickedVideo,
                                                productQuantity: int.parse(
                                                    _productQuantity.text),
                                                mainImage: mainImage!),
                                          );
                                    }
                                  },
                                  child: Text(AppStrings.addYourProduct.tr()),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBoxFunctions.verticalSizedBox(3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
