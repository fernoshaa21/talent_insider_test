enum NotificationListType {
  order('ORDER'),
  keuangan('KEUANGAN'),
  broadcast('BROADCAST'),
  helpdesk('HELPDESK'),
  chat('CHAT'),
  auth('AUTH'),
  product('PRODUCT'),
  user('USER');

  final String value;
  const NotificationListType(this.value);

  static NotificationListType fromMasterId(String masterId) {
    switch (masterId) {
      case '1': // Menunggu Pembayaran
      case '2': // Pesanan Diproses
      case '3': // Pesanan Selesai
      case '4': // Pesanan Telah Dibatalkan
      case '5': // Menunggu Konfirmasi
      case '6': // Pesanan Ditolak
      case '7': // Pembayaran Selesai
      case '14': // Revisi
      case '15': // Mengajukan Pembatalan
      case '16': // Pembatalan Ditolak
      case '18': // Meminta Konfirmasi
      case '20': // Checkout
        return NotificationListType.order;

      case '8': // Penarikan
      case '10': // Penghasilan
      case '11': // Refund
        return NotificationListType.keuangan;

      case '9': // Broadcast
        return NotificationListType.broadcast;

      case '12': // Helpdesk
        return NotificationListType.helpdesk;

      case '13': // Chat
        return NotificationListType.chat;

      case '17': // Pembuatan Akun
        return NotificationListType.auth;

      case '19': // Pembuatan Jasa
        return NotificationListType.product;

      case '21': // Verifikasi Berhasil
      case '22': // Verifikasi Gagal
      case '23': // Registrasi Penjual
        return NotificationListType.user;

      default:
        return NotificationListType.broadcast;
    }
  }

  bool get isOrderType => this == NotificationListType.order;
  bool get isFinanceType => this == NotificationListType.keuangan;
  bool get isChatType => this == NotificationListType.chat;
  bool get isUserType => this == NotificationListType.user;
}
