class CustomerModel {
  final String name;
  final String payType;
  final int totalAmount;
  final int account;
  final int phone;
  final bool isActive;
  final DateTime date;

  CustomerModel({
    this.name,
    this.payType,
    this.totalAmount,
    this.account,
    this.isActive,
    this.date,
    this.phone,
  });
}
