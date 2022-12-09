import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:elite_auction/features/home/presentation/manager/product_variation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_response_entity.dart';

const noColors = 1;
const noSizes = 2;
const colorsAndSizesExist = 3;

class ProductVariationCubit extends Cubit<ProductVariationState> {
  ProductVariationCubit() : super(const ProductVariationState());
  late List<ProductVariation> colors;
  late List<ProductVariation> sizes;
  late List<ProductVariation> originalVariations;
  late int variationStatusCode;
  void sortSizesByColorIdOrSelectColorWhenAlreadySortingBySizes(
      int colorId,
      int variationId,
      String? price,
      String? priceAfterDiscount,
      int quantity) {
    if (!state.isSearchingBySize) {
      sortSizesByColorId(
          colorId, variationId, price, priceAfterDiscount, quantity);
    } else {
      selectColorWhenAlreadySortingBySizes(
          variationId, price, priceAfterDiscount, colorId, quantity);
    }
  }

  void selectColorWhenAlreadySortingBySizes(int variationId, String? price,
      String? priceAfterDiscount, int colorId, int quantity) {
    emit(
      state.copyWith(
          variationId: variationId,
          variationPrice: price,
          variationPriceAfterDiscount: priceAfterDiscount,
          pickedColorId: colorId,
          variationQuantity: quantity),
    );
  }

  void sortSizesByColorId(int colorId, int variationId, String? price,
      String? priceAfterDiscount, int quantity) {
    List<ProductVariation> sizes = [];
    for (var element in originalVariations) {
      if (element.color!.id == colorId) {
        sizes.add(element);
      }
    }
    emit(
      state.copyWith(
          variationId: variationId,
          sizes: sizes,
          variationPrice: price,
          variationPriceAfterDiscount: priceAfterDiscount,
          pickedColorId: colorId,
          pickedSizeId: -1,
          isSearchingByColor: true,
          isSearchingBySize: false,
          variationQuantity: quantity),
    );
  }

  void sortColorsBySizeIdOrSelectSizeWhenAlreadySortingByColors(
      int sizeId,
      int variationId,
      String? price,
      String? priceAfterDiscount,
      int quantity) {
    if (!state.isSearchingByColor) {
      sortColorsBySizeId(
          sizeId, variationId, price, priceAfterDiscount, quantity);
    } else {
      selectSizeWhenAlreadySortingByColors(
          variationId, price, priceAfterDiscount, sizeId, quantity);
    }
  }

  void selectSizeWhenAlreadySortingByColors(int variationId, String? price,
      String? priceAfterDiscount, int sizeId, int quantity) {
    emit(
      state.copyWith(
        variationId: variationId,
        variationPrice: price,
        variationPriceAfterDiscount: priceAfterDiscount,
        pickedSizeId: sizeId,
        variationQuantity: quantity,
      ),
    );
  }

  void sortColorsBySizeId(int sizeId, int variationId, String? price,
      String? priceAfterDiscount, int quantity) {
    List<ProductVariation> colors = [];
    for (var element in originalVariations) {
      if (element.size!.id == sizeId) {
        colors.add(element);
      }
    }
    emit(
      state.copyWith(
          variationId: variationId,
          colors: colors,
          variationPrice: price,
          variationPriceAfterDiscount: priceAfterDiscount,
          pickedSizeId: sizeId,
          pickedColorId: -1,
          isSearchingBySize: true,
          isSearchingByColor: false,
          variationQuantity: quantity),
    );
  }

  void initColorsAndSizes(List<ProductVariation> variations) {
    sizes = [];
    colors = [];
    originalVariations = variations;
    for (int index = 0; index < variations.length; index++) {
      if (colors.isEmpty) {
        colors.add(variations[index]);
      } else {
        if (!isColorDuplicated(variations[index].colorId!)) {
          colors.add(variations[index]);
        }
      }

      if (sizes.isEmpty) {
        sizes.add(variations[index]);
      } else {
        if (!isSizeDuplicated(variations[index].sizeId!)) {
          sizes.add(variations[index]);
        }
      }
    }
    if (colors.isEmpty) {
      variationStatusCode = noColors;
    } else if (sizes.isEmpty) {
      variationStatusCode = noSizes;
    } else {
      variationStatusCode = colorsAndSizesExist;
    }

    emit(
      ProductVariationState(
        colors: colors,
        sizes: sizes,
      ),
    );
  }

  bool isColorDuplicated(int id) {
    for (var color in colors) {
      if (color.colorId == id) {
        return true;
      }
    }
    return false;
  }

  bool isSizeDuplicated(int id) {
    for (var size in sizes) {
      if (size.sizeId == id) {
        return true;
      }
    }
    return false;
  }

  bool isVariationSelected() {
    return state.variationId != null;
  }

  bool colorPicked() {
    return state.pickedColorId != -1;
  }

  bool sizePicked() {
    return state.pickedSizeId != -1;
  }

  void disposeStateValues() {
    emit(state.dispose());
  }
}
