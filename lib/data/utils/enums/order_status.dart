enum OrderStatus {
  sendingOffer('sending_offer'),
  offerAccepted('offer_accepted'),
  offerRejected('offer_rejected'),
  pendingPayment('pending_payment'),
  verifiedPayment('verified_payment'),
  workInProgress('work_in_progress'),
  agreementToFinish('agreement_to_finish'),
  finished('finished'),
  workInRevision('work_in_revision'),
  cancelBeforePayment('cancel_before_payment'),
  expiredPayment('expired_payment'),
  expiredOffer('expired_offer'),
  awaitingConfirmation('awaiting_confirmation'),
  orderCanceled('order_canceled'),
  cancellationRequested('cancellation_requested'),
  cancellationAccepted('cancellation_accepted'),
  cancellationRejected('cancellation_rejected'),
  goalAchieved('goal_achieved'),
  checkout('checkout');

  final String value;
  const OrderStatus(this.value);

  String get label {
    return (switch (this) {
      OrderStatus.sendingOffer => 'Mengirim Penawaran',
      OrderStatus.offerAccepted => 'Penawaran Diterima',
      OrderStatus.offerRejected => 'Penawaran Ditolak',
      OrderStatus.pendingPayment => 'Menunggu Pembayaran',
      OrderStatus.verifiedPayment => 'Pembayaran Terverifikasi',
      OrderStatus.workInProgress => 'Proses Pengerjaan',
      OrderStatus.agreementToFinish => 'Persetujuan Pekerjaan Selesai',
      OrderStatus.finished => 'Pekerjaan Selesai',
      OrderStatus.workInRevision => 'Revisi Pekerjaan',
      OrderStatus.cancelBeforePayment => 'Order Dibatalkan Sebelum Bayar',
      OrderStatus.expiredPayment => 'Waktu Pembayaran Kedaluwarsa',
      OrderStatus.expiredOffer => 'Penawaran Kadaluarsa',
      OrderStatus.awaitingConfirmation => 'Menunggu Konfirmasi Pihak Kedua',
      OrderStatus.orderCanceled => 'Order Dibatalkan',
      OrderStatus.cancellationRequested => 'Pengajuan Pembatalan',
      OrderStatus.cancellationAccepted => 'Pembatalan Diterima',
      OrderStatus.cancellationRejected => 'Pembatalan Ditolak',
      OrderStatus.goalAchieved => 'Pencapaian Selesai',
      OrderStatus.checkout => 'Melakukan Check-out',
    });
  }

  int get code {
    return (switch (this) {
      OrderStatus.sendingOffer => 1,
      OrderStatus.offerAccepted => 2,
      OrderStatus.offerRejected => 3,
      OrderStatus.pendingPayment => 4,
      OrderStatus.verifiedPayment => 5,
      OrderStatus.workInProgress => 6,
      OrderStatus.agreementToFinish => 7,
      OrderStatus.finished => 8,
      OrderStatus.workInRevision => 9,
      OrderStatus.cancelBeforePayment => 10,
      OrderStatus.expiredPayment => 11,
      OrderStatus.expiredOffer => 12,
      OrderStatus.awaitingConfirmation => 13,
      OrderStatus.orderCanceled => 14,
      OrderStatus.cancellationRequested => 15,
      OrderStatus.cancellationAccepted => 16,
      OrderStatus.cancellationRejected => 17,
      OrderStatus.goalAchieved => 18,
      OrderStatus.checkout => 19,
    });
  }
}
