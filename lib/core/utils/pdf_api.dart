import 'dart:io';

import 'package:easy_localization/easy_localization.dart' as ln;
import 'package:elite_auction/features/settings/domain/entities/order_entity.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sizer/sizer.dart';

import '../resources/strings_manager.dart';
import 'global.dart';

class PdfGenerator {
  static late Font arfont;

  static init()async{
    arfont = Font.ttf( await rootBundle.load("assets/fonts/Cairo-Medium.ttf"));
  }
  static Future<File> createPdf(PaginatedOrderEntity order) async {
    final pdf = Document();
    pdf.addPage(  _createPdfPage(order)
    );
    return openDocument(name: 'order.pdf', pdf: pdf);
  }

  static Page _createPdfPage(PaginatedOrderEntity order){
    return  MultiPage(
      maxPages: 1,
      // margin: EdgeInsets.zero,
      pageTheme: PageTheme(
        textDirection: lang?TextDirection.ltr:TextDirection.rtl,
        theme: ThemeData.withFont(base: arfont),
        margin: EdgeInsets.zero,
      ),
      header: (context) => _buildCustomHeader(),
      build: (context) => [
        DecoratedBox(
          decoration: BoxDecoration(
            color: PdfColor.fromHex("#F8F8F8"),
          ),
          child: Container(
            color: PdfColor.fromHex('#F8F8F8'),
            padding:  const EdgeInsets.symmetric(vertical: PdfPageFormat.cm/1.71 ),
            child: SizedBox(
              height: 10 * PdfPageFormat.inch,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            child: invoiceTotals(
                              order.totals!.subTotal!,
                              order.totals!.overallTotal!,
                              order.totals!.deliveryFees!,
                            )),
                        // SizedBox(width: PdfPageFormat.cm / 2),
                        Expanded(
                          child: orderInformation(
                              order.orderCode!,
                              order.paymentStatus!,
                              order.paymentMethod!,
                              order.orderStatus!,
                              order.createdAt!),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: PdfPageFormat.cm/2),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: orderAddress(
                              order.customerName!,
                              order.customerZoneNumber!,
                              order.customerAddressStreet ?? '',
                              order.customerAddressBuildingNumber ?? ''),
                        ),
                        // SizedBox(width: PdfPageFormat.cm / 2),
                        Expanded(
                          child: orderItems(order.items!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );

  }


  static Future<File> openDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }



  static Future<String> saveDocument({
    required String name,
    required File pdf,
  }) async {
    final dir = await getExternalStorageDirectory();
    final file = File('${dir?.path}/+$name');
    await file.writeAsBytes(await pdf.readAsBytes());
    return file.path;
  }

  static Widget invoiceTotals(final String subTotal, final String totalAmount,
      final String deliveryFees) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: PdfPageFormat.cm / 2,vertical: PdfPageFormat.cm / 2 ),
      decoration: BoxDecoration(
        color: PdfColor.fromHex('#FFFFFF'),
        borderRadius: BorderRadius.all(
          Radius.circular(5.w),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal:  PdfPageFormat.cm/3, vertical: PdfPageFormat.cm/3),
      child: Column(
        children: [
          Align(
            alignment: lang ?Alignment.topLeft:Alignment.topRight,
            child: Text(
              AppStrings.yourInvoice.tr(),
              style: TextStyle(
                fontSize: 22.sp,
                color: PdfColor.fromHex('4E8075'),
              ),
            ),
          ),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(AppStrings.subTotal, "$subTotal $appCurrency"),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(
              AppStrings.deliveryFees, "$deliveryFees $appCurrency"),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(
              AppStrings.totalAmount, "$totalAmount $appCurrency"),
        ],
      ),
    );
  }

  static Widget orderInformation(
      final String trackCode,
      final String paymentStatus,
      final String paymentMethod,
      final String orderStatus,
      final String createdAt,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: PdfPageFormat.cm / 2,vertical: PdfPageFormat.cm / 2 ),
      decoration: BoxDecoration(
        color: PdfColor.fromHex('#FFFFFF'),
        borderRadius: BorderRadius.all(
          Radius.circular(5.w),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal:  PdfPageFormat.cm/3, vertical: PdfPageFormat.cm/3),
      child: Column(
        children: [
          Align(
            alignment: lang ?Alignment.topLeft:Alignment.topRight,
            child: Text(
              AppStrings.orderInformation.tr(),
              style: TextStyle(
                fontSize: 22.sp,
                color: PdfColor.fromHex('4E8075'),
              ),
            ),
          ),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(AppStrings.trackCode, trackCode),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(AppStrings.paymentStatus, paymentStatus.tr()),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(AppStrings.paymentMethod, paymentMethod.tr()),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(AppStrings.orderStatus, orderStatus.tr()),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(AppStrings.createdAt, createdAt),
        ],
      ),
    );
  }
  static Widget orderAddress(
      final String customerName,
      final String zoneNumber,
      final String street,
      final String buildingNumber,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: PdfPageFormat.cm / 2,vertical: PdfPageFormat.cm / 2 ),
      decoration: BoxDecoration(
        color: PdfColor.fromHex('#FFFFFF'),
        borderRadius: BorderRadius.all(
          Radius.circular(5.w),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal:  PdfPageFormat.cm/3, vertical: PdfPageFormat.cm/3),
      child: Column(
        children: [
          Align(
            alignment: lang ?Alignment.topLeft:Alignment.topRight,
            child: Text(
              AppStrings.orderAddress.tr(),
              style: TextStyle(
                fontSize: 22.sp,
                color: PdfColor.fromHex('4E8075'),
              ),
            ),
          ),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(AppStrings.myName, customerName),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(AppStrings.zoneNumber, zoneNumber),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(AppStrings.street, street),
          SizedBox(height: PdfPageFormat.cm),
          informationRow(AppStrings.buildingNumber, buildingNumber),
        ],
      ),
    );
  }

  static Widget orderItems(final List<Items> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: PdfPageFormat.cm / 2,vertical: PdfPageFormat.cm / 2 ),
      decoration: BoxDecoration(
        color: PdfColor.fromHex('#FFFFFF'),
        borderRadius: BorderRadius.all(
          Radius.circular(5.w),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal:  PdfPageFormat.cm/3, vertical: PdfPageFormat.cm/3),
      child: Column(
        children: [
          Align(
            alignment: lang ?Alignment.topLeft:Alignment.topRight,
            child: Text(
              AppStrings.orderPurchasedItems.tr(),
              style: TextStyle(
                fontSize: 22.sp,
                color: PdfColor.fromHex('4E8075'),
              ),
            ),
          ),
          SizedBox(height: PdfPageFormat.cm),
          for (var item in items)...[
            informationRow(AppStrings.name, item.productName!),
            SizedBox(height: PdfPageFormat.cm),
            informationRow(
                AppStrings.price, item.productPriceAfterDiscount!=null ?"${item.productPriceAfterDiscount!} $appCurrency":"${item!.productPrice!} $appCurrency"),
            SizedBox(height: PdfPageFormat.cm),
            informationRow(
                AppStrings.quantity, "${item.productQuantity!}"),
          ]
        ],
      ),
    );
  }


  static Widget informationRow(final String title, final String value) {
    return lang? Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '${title.tr()} :',
            style: TextStyle(color: PdfColor.fromHex("#96999B"), fontSize: 14.sp),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            overflow: TextOverflow.visible,
            value,
            style: TextStyle(color: PdfColor.fromHex("#4E8075",), fontSize: 14.sp),
          ),
        ),
      ],
    ):
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            overflow: TextOverflow.visible,
            value,
            style: TextStyle(color: PdfColor.fromHex("#4E8075",), fontSize: 14.sp),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '${title.tr()} :',
            style: TextStyle(color: PdfColor.fromHex("#96999B"), fontSize: 14.sp),
          ),
        ),
      ],
    );
  }


  static Widget _buildCustomHeader() => Container(
    margin: EdgeInsets.zero,
    height: 3 * PdfPageFormat.cm,
    padding: const EdgeInsets.symmetric(vertical: 3 * PdfPageFormat.mm),
    decoration: BoxDecoration(
      color: PdfColor.fromHex('4E8075'),
    ),
    child: Row(
      mainAxisAlignment:lang? MainAxisAlignment.start:MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.5 * PdfPageFormat.cm),
        child:  Text(
          AppStrings.orderSummery.tr(),
          style: TextStyle(
            fontSize: 30.sp,
            color: PdfColors.white,
          ),
        ),
  )
      ],
    ),
  );

}
