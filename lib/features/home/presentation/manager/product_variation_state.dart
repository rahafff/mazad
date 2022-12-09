import '../../domain/entities/product_response_entity.dart';

class ProductVariationState {
  final List<ProductVariation>? colors;
  final List<ProductVariation>? sizes;
  final int? variationId;
  final int pickedColorId;
  final int pickedSizeId;
  final String? variationPrice;
  final String? variationPriceAfterDiscount;
  final int? variationQuantity;
  final bool isSearchingByColor;
  final bool isSearchingBySize;

  const ProductVariationState({
    this.isSearchingByColor = false,
    this.isSearchingBySize = false,
    this.pickedColorId = -1,
    this.pickedSizeId = -1,
    this.colors,
    this.sizes,
    this.variationId,
    this.variationPrice,
    this.variationPriceAfterDiscount,
    this.variationQuantity,
  });

  ProductVariationState dispose() {
    return const ProductVariationState(
      colors: null,
      sizes: null,
      variationId: null,
      pickedColorId: -1,
      pickedSizeId: -1,
      variationPrice: null,
      variationPriceAfterDiscount: null,
      variationQuantity: null,
      isSearchingByColor: false,
      isSearchingBySize: false,
    );
  }

  ProductVariationState copyWith({
    List<ProductVariation>? colors,
    List<ProductVariation>? sizes,
    int? variationId,
    int? pickedColorId,
    int? pickedSizeId,
    String? variationPrice,
    String? variationPriceAfterDiscount,
    int? variationQuantity,
    bool? isSearchingByColor,
    bool? isSearchingBySize,
  }) {
    return ProductVariationState(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      variationId: variationId ?? this.variationId,
      pickedColorId: pickedColorId ?? this.pickedColorId,
      pickedSizeId: pickedSizeId ?? this.pickedSizeId,
      variationPrice: variationPrice,
      variationPriceAfterDiscount: variationPriceAfterDiscount,
      variationQuantity: variationQuantity ?? this.variationQuantity,
      isSearchingByColor: isSearchingByColor ?? this.isSearchingByColor,
      isSearchingBySize: isSearchingBySize ?? this.isSearchingBySize,
    );
  }
}
