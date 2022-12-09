import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/pdf_api.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/core/widgets/invoice_totals.dart';
import 'package:elite_auction/features/settings/domain/entities/order_entity.dart';
import 'package:elite_auction/features/settings/presentation/widgets/customer_information.dart';
import 'package:elite_auction/features/settings/presentation/widgets/order_information.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../../../../core/widgets/sized_box_functions.dart';
import '../../../../core/utils/global.dart';
import '../widgets/order_purchased_items.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  final PaginatedOrderEntity order;



  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  PdfDocument? orderAsPdf;

  @override
  void initState() {
    super.initState();
    if(lang ==false) {
      PdfGenerator.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              AppStrings.orderDetails.tr(),
            ),
            leading: const BackButtonWidget(),
            actions: [
              IconButton(
                onPressed: () async {
                  PdfGenerator.createPdf(widget.order).then(
                    (value) async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PdfViewerScreen(pdfDocument: value),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.picture_as_pdf),
              ),
            ]),
        body: ListView(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 5.0.h),
          children: [
            InvoiceTotals(
              subTotal: widget.order.totals!.subTotal!,
              totalAmount: widget.order.totals!.overallTotal!,
              deliveryFees: widget.order.totals!.deliveryFees!,
            ),
            SizedBoxFunctions.verticalSizedBox(3),
            CustomerInformation(
                zoneNumber: widget.order.customerZoneNumber!,
                street: widget.order.customerAddressStreet ?? '',
                name: widget.order.customerName!,
                buildingNumber: widget.order.customerAddressBuildingNumber ?? ''),
            SizedBoxFunctions.verticalSizedBox(3),
            OrderInformation(
                orderTrackCode: widget.order.orderCode!,
                paymentStatus: widget.order.paymentStatus!,
                paymentMethod: widget.order.paymentMethod!,
                orderStatus: widget.order.orderStatus!,
                createdAt: widget.order.createdAt!),
            SizedBoxFunctions.verticalSizedBox(3),
            OrderPurchasedItems(
              items: widget.order.items!,
            )
          ],
        ),
      ),
    );
    //
  }
}

class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen({super.key, required this.pdfDocument});
  final File pdfDocument;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        actions: [
          IconButton(
            onPressed: () {
              PdfGenerator.saveDocument(name: 'order.pdf', pdf: pdfDocument).then((value) {
                Fluttertoast.showToast(msg: 'PDF path :$value', toastLength: Toast.LENGTH_LONG);
              });
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () async => await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async {
                return pdfDocument.readAsBytes();
              }
            ),
            icon: const Icon(Icons.print),
          ),
        ],
      ),
      body: SfPdfViewer.file(
        pdfDocument,
      ),
    );
  }
}
