import '../../../../core/core.dart';

enum PaymentMethodsEnum {
  electronicPay,
  // applePay,
  wallet;

  const PaymentMethodsEnum();

  String get title {
    switch (this) {
      case PaymentMethodsEnum.electronicPay:
        return appLocalizer.electronicPayment;
      case PaymentMethodsEnum.wallet:
        return appLocalizer.wallet;
      // case PaymentMethodsEnum.applePay:
      //   return appLocalizer.applePay;
    }
  }

  String get icon {
    switch (this) {
      case PaymentMethodsEnum.wallet:
        return "";
      case PaymentMethodsEnum.electronicPay:
        return "";
      // case PaymentMethodsEnum.applePay:
      //   return AppIcons.applePay;
    }
  }

  String get value {
    switch (this) {
      case PaymentMethodsEnum.electronicPay:
        return "electronic_pay";
      case PaymentMethodsEnum.wallet:
        return "wallet";
      // case PaymentMethodsEnum.applePay:
      //   return "apple_pay";
    }
  }

  static PaymentMethodsEnum fromJson(String value) {
    switch (value) {
      case "electronic_pay":
        return PaymentMethodsEnum.electronicPay;
      case "wallet":
        return PaymentMethodsEnum.wallet;
      // case "apple_pay":
      //   return PaymentMethodsEnum.applePay;
      default:
        return PaymentMethodsEnum.electronicPay;
    }
  }
}
