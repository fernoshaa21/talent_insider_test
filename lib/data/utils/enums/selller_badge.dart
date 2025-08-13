enum SellerBadge {
  newComer(1),
  guardian(2),
  master(3),
  grandMaster(4),
  unstoppable(5),
  ;

  final int value;

  const SellerBadge(this.value);

  String get text {
    switch (this) {
      case SellerBadge.newComer:
        return 'New Comer';
      case SellerBadge.guardian:
        return 'Guardian';
      case SellerBadge.master:
        return 'Master';
      case SellerBadge.grandMaster:
        return 'Grandmaster Ancient';
      case SellerBadge.unstoppable:
        return 'Unstoppable Boss';
    }
  }
}
