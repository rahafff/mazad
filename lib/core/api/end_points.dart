class EndPoints {
  static const String baseUrl = 'https://api.malnokhba.qa/';
  static const String checkOutPublicApiKey =
      'pk_sbox_ysigfcdm37jtpf7yytm37ke3lmn';
  static const String checkOutSecretApiKey =
      'sk_sbox_wfopwnifwxzy2bnps3ds7qxxvyt';

  static const String api = '${baseUrl}api/';
  static const String user = '${api}user/';
  static const String appleStoreUrl =
      'https://apps.apple.com/app/mazad-alnokhba/id1597116939';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.sdnone.elite_auction';
  static const String googleSearchPlacesBaseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const String googleSearchPlacesDeBaseUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';
  //splash
  static const String getApplicationVersion = '${api}mobile_localization';
  //cart

  static const String addToCart = '${api}add_product_to_cart';
  static const String deleteFromCart = '${api}remove_product_from_cart';
  static const String getDetailedCart = '${api}detailed_cart';
  static const String payOnDelivery = '${api}cash_on_delivery';
  static const String createPayment = '${api}create_payment';
  static const String checkout = '${api}checkout';
  static const String searchLocation =
      'https://nominatim.openstreetmap.org/search';
  //wishlist
  static const String addToWishlist = '${api}add_product_to_wishlist';
  static const String deleteFromWishlist = '${api}remove_product_from_wishlist';
  static const String getDetailedWishlist = '${api}detailed_wishlist';
  // navBar
  static const String getCartAndWishlistItemCount =
      '${api}cart_wishlist_items_count';
  //settings++

  static const String currencies = '${api}currencies';
  static const String orders = '${api}orders';
  static const String customerProducts = '${api}customer_products';
  static const String aboutUs = '${api}about_us';
  static const String companyInfo = '${api}company_info';
  static const String customerProductDetailes =
      '${api}customer_product_detailes';
  static const String orderDetails = '${api}order_details';
  static Uri termsUrl = Uri.parse('https://malnokhba.qa/terms');
  static Uri privacyUrl = Uri.parse('https://malnokhba.qa/privacy');
  //home
  static const String shops = '${api}shops';
  static const String shopProducts = '${api}shop_products';
  static const String subcategoryProducts = '${api}subcategories_products';
  static const String subsubcategoryProducts = '${api}subsubcategory_products';
  static const String allCustomersProducts = '${api}all_customers_products';
  static const String searchAllProducts = '${api}search';
  static const String shopCategories = '${api}shop';
  static const String product = '${api}product';
  static const String shopProduct = '${api}shop_product';
  static const String categories = '${api}categories';
  static const String subcategories = '${api}subcategories';
  static const String subsubcategories = '${api}subsubcategories';
  static const String advertisements = '${api}sliders';
  static const String ownerSimilarProducts = '${api}owner_similar_products';
  static const String shopSimilarProducts = '${api}shop_similar_products';
  static const String lastAddedProducts = '${api}home_latest_products';
  static const String mostPurchasedProducts =
      '${api}home_most_purchased_products';
  static const String mostPopularProducts = '${api}home_highlighted_products';
  static const String addReview = '${api}add_review';
  static const String addProduct = '${api}add_product';
  static const String getReview = '${api}user_review_on_product';
  //user
  static const String register = "${api}register";
  static const String login = "${api}login";
  static const String updatePassword = "${user}update_password";
  static const String updateUserInfo = "${user}update";
  static const String updateUserAddress = "${user}update_address";
  static const String deleteAccount = "${api}delete_account";
}
