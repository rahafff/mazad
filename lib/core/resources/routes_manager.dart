
import 'package:elite_auction/features/app_navigation_bar/presentation/pages/app_bottom_navigation_bar.dart';
import 'package:elite_auction/features/cart/presentation/pages/cart_screen.dart';
import 'package:elite_auction/features/cart/presentation/pages/shipping_address_screen.dart';
import 'package:elite_auction/features/home/presentation/pages/home_screen.dart';
import 'package:elite_auction/features/home/presentation/pages/product_screen.dart';
import 'package:elite_auction/features/home/presentation/pages/search_screen.dart';
import 'package:elite_auction/features/home/presentation/pages/shops_screen.dart';
import 'package:elite_auction/features/home/presentation/pages/subcategories_screen.dart';
import 'package:elite_auction/features/home/presentation/pages/subcategory_products_screen.dart';
import 'package:elite_auction/features/home/presentation/pages/subsubcategory_products_screen.dart';
import 'package:elite_auction/features/settings/presentation/pages/about_us_screen.dart';
import 'package:elite_auction/features/settings/presentation/pages/contact_us_screen.dart';
import 'package:elite_auction/features/settings/presentation/pages/my_product_details_screen.dart';
import 'package:elite_auction/features/splash/presentation/pages/splash_screen.dart';
import 'package:elite_auction/features/user/presentation/pages/login_screen.dart';
import 'package:elite_auction/features/user/presentation/pages/sign_up_loading_screen.dart';
import 'package:elite_auction/features/user/presentation/pages/signup_screen.dart';
import 'package:elite_auction/features/user/presentation/pages/user_info_screen.dart';
import 'package:elite_auction/features/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../features/home/presentation/pages/add_product_screen.dart';
import '../../features/home/presentation/pages/preview_video_screen.dart';
import '../../features/home/presentation/pages/shop_products_screen.dart';
import '../../features/settings/presentation/pages/my_products_screen.dart';
import '../../features/settings/presentation/pages/order_track_screen.dart';
import '../../features/settings/presentation/pages/orders_screen.dart';
import '../../features/settings/presentation/pages/settings_screen.dart';
import '../../features/user/presentation/pages/update_password_screen.dart';
import '../../features/user/presentation/pages/verification_code_screen.dart';

class Routes {
  // bottom navigation bar
  static const String bottomNavigationBarRoute = "/bottomNavigationBar";

  //auth
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String registerLoadingRoute = "/registerLoading";
  static const String myProfileRoute = "/myProfile";
  static const String verificationCodeRoute = "/verificationCode";
  static const String updatePasswordRoute = "/updatePassword";
  //home
  static const String shopsRoute = "/shops";
  static const String shopRoute = "/shop";
  static const String home = "/home";
  static const String subcategories = "/subcategories";
  static const String subcategoryProducts = "/subcategoryProducts";
  static const String subsubcategoryProducts = "/subsubcategoryProducts";
  static const String product = "/product";
  static const String resizeVideo = "/resizeVideo";

  static const String search = "/search";

  static const String addProductRoute = "/addProduct";

  static const String customerProductDetails = "/customerProductDetails";


  //settings
  static const String settingsRout = "/settings";
  static const String aboutUsRout = "/aboutUs";
  static const String contactUsRout = "/contactUs";
  static const String ordersRout = "/orders";
  static const String orderTrackRout = "/orderTrack";

  static const String myProductsRoute = "/myProducts";

  static const String myProductDetails = "/myProductDetails";

  //cart
  static const String cartRout = "/cart";
  static const String shippingAddressRout = "/shippingAddress";
  //wishlist
  static const String wishlistRout = "/wishlist";
  //splash
  static const String splash = "/splash";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.bottomNavigationBarRoute:
        return MaterialPageRoute(
            builder: (_) => const AppBottomNavigationBar());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case Routes.updatePasswordRoute:
        return MaterialPageRoute(builder: (_) => const UpdatePasswordScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.registerLoadingRoute:
        return MaterialPageRoute(builder: (_) => const SignUpLoadingScreen());
      case Routes.verificationCodeRoute:
        return MaterialPageRoute(
            builder: (_) => const VerificationCodeScreen());
      case Routes.shopsRoute:
        return MaterialPageRoute(builder: (_) => const ShopsScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.shopRoute:
        {
          final args = routeSettings.arguments as ShopArguments;
          return MaterialPageRoute(
            builder: (_) => ShopScreen(
              shopName: args.shopName,
              shopId: args.shopId,
            ),
          );
        }
      case Routes.product:
        {
          final args = routeSettings.arguments as ProductArguments;
          return MaterialPageRoute(
            builder: (_) => ProductScreen(
              productId: args.productId,
              productName: args.productName,
              shopId: args.shopId,
            ),
          );
        }
      case Routes.subcategories:
        {
          final args = routeSettings.arguments as SubcategoriesArguments;
          return MaterialPageRoute(
            builder: (_) => SubcategoriesScreen(
              categoryId: args.categoryId,
              categoryName: args.categoryName,
            ),
          );
        }
      case Routes.subcategoryProducts:
        {
          final args = routeSettings.arguments as SubcategoryArguments;
          return MaterialPageRoute(
            builder: (_) => SubcategoryProductsScreen(
              subcategoryId: args.subcategoryId,
              categoryId: args.categoryId,
              subcategoryName: args.subcategoryName,
            ),
          );
        }
      case Routes.addProductRoute:
        {
          final args = routeSettings.arguments as AddProductArguments;
          return MaterialPageRoute(
            builder: (_) => AddProductScreen(
              subcategoryId: args.subcategoryId,
              subcategoryName: args.subcategoryName,
              categoryName: args.categoryName,
            ),
          );
        }
      case Routes.search:
        {
          final args = routeSettings.arguments as SearchArguments;
          return MaterialPageRoute(
            builder: (_) => SearchScreen(
              subcategoryId: args.subcategoryId,
              subsubcategoryId: args.subsubcategoryId,
              categoryId: args.categoryId,
              search: args.search,
              shopId: args.shopId,
            ),
          );
        }
   case Routes.subsubcategoryProducts:
        {
          final args = routeSettings.arguments as SubsubcategoryArguments;
          return MaterialPageRoute(
            builder: (_) => SubsubcategoryProductsScreen(
              subsubcategoryName: args.subsubcategoryName,
              subsubcategoryId: args.subsubcategoryId,
              categoryId: args.categoryId,
             
            ),
          );
        }

      case Routes.settingsRout:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case Routes.aboutUsRout:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      case Routes.myProductsRoute:
        return MaterialPageRoute(builder: (_) => const MyProductsScreen());
      case Routes.myProfileRoute:
        return MaterialPageRoute(builder: (_) => MyProfileScreen());
      case Routes.contactUsRout:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());
      case Routes.ordersRout:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case Routes.orderTrackRout:
        {
          final args = routeSettings.arguments as OrderTrackArguments; //todo
          return MaterialPageRoute(
            builder: (_) => OrderTrackScreen(
              orderId: args.orderId,
              status: args.statusCode,
            ),
          );
        }
      case Routes.cartRout:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.shippingAddressRout:
        return MaterialPageRoute(builder: (_) => const ShippingAddressScreen());
      case Routes.wishlistRout:
        return MaterialPageRoute(builder: (_) => const WishlistScreen());
      case Routes.myProductDetails:
        {
          final args = routeSettings.arguments as MyProductDetailsArguments;
          return MaterialPageRoute(
            builder: (_) =>  MyProductDetailsScreen(
              productId: args.productId,
            ),
          );
        }

      case Routes.resizeVideo:
        {
          PreviewVideoArguments args = routeSettings.arguments  as PreviewVideoArguments;
          return MaterialPageRoute(
            builder: (_) =>   PreviewVideoScreen(
              videoController: args.videoController,
            ),
          );
        }
     
       
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}

class MyProductDetailsArguments {
   final int productId;
  MyProductDetailsArguments({required this.productId});
}

class PreviewVideoArguments {
    VideoPlayerController videoController;
   PreviewVideoArguments({
     required this.videoController,
   });
}



class ShopArguments {
  final String shopName;
  final int shopId;

  ShopArguments(this.shopName, this.shopId);
}

class OrderTrackArguments {
  final String statusCode;
  final int orderId;

  OrderTrackArguments({required this.statusCode, required this.orderId});
}

class SearchArguments {
  final int? shopId;

  final int? subcategoryId;
  final int? categoryId;
  final int? subsubcategoryId;
  final String search;

  const SearchArguments({
    this.shopId,
    this.subcategoryId,
    this.subsubcategoryId,
  this.categoryId,
    required this.search,
  });
}

class SubcategoriesArguments {
  final String categoryName;
  final int categoryId;

  SubcategoriesArguments(this.categoryName, this.categoryId);
}

class SubcategoryArguments {
  final String subcategoryName;
  final int categoryId;
  final int subcategoryId;

  const SubcategoryArguments({
    required this.subcategoryName,
    required this.categoryId,
    required this.subcategoryId,
  });
}

class SubsubcategoryArguments
{
  final String subsubcategoryName;
  final int categoryId;
  final int subsubcategoryId;
  const SubsubcategoryArguments({required this.subsubcategoryName, required this.categoryId, required this.subsubcategoryId,});
}

class AddProductArguments {
  final String subcategoryName;
  final String categoryName;
  final int subcategoryId;

  const AddProductArguments({
    required this.subcategoryName,
    required this.categoryName,
    required this.subcategoryId,});
}

class ProductArguments {
  final String productName;
  final int productId;
  final int? shopId;

  ProductArguments({required this.productName, required this.productId, this.shopId});
}
