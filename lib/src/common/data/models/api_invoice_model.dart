import '../../domain/entity/invoice_entity.dart';

class ApiInvoiceModel {
  final String? invoiceUrl;
  final String? invoiceId;

  ApiInvoiceModel({required this.invoiceUrl, required this.invoiceId});

  factory ApiInvoiceModel.fromJson(Map<String, dynamic> json) =>
      ApiInvoiceModel(invoiceUrl: json["invoice_url"], invoiceId: json["invoiceId"] ?? json["invoiceId"].toString());
}

extension ApiInvoiceModelMapper on ApiInvoiceModel {
  InvoiceEntity get map => InvoiceEntity(invoiceUrl: invoiceUrl ?? "", invoiceId: invoiceId);
}
