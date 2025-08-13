enum HelpdeskStatus {
  createHelpdesk('create_helpdesk'),
  inProgressHelpdesk('progress'),
  pendingHelpdesk('pendingHelpdesk'),
  doneHelpdesk('doneHelpdesk');

  final String value;
  const HelpdeskStatus(this.value);

  String get label {
    return (switch (this) {
      HelpdeskStatus.createHelpdesk => 'Dibuat',
      HelpdeskStatus.inProgressHelpdesk => 'Dalam Proses',
      HelpdeskStatus.pendingHelpdesk => 'Pending',
      HelpdeskStatus.doneHelpdesk => '  Selesai',
    });
  }

  // reverse this
  //  HelpdeskStatus get orderStatus {
  //   // return HelpdeskStatus.workInProgress;
  //   return (switch (additionalInfo.currentActivity) {
  //     1000 => HelpdeskStatus.offering,
  //     1002 => HelpdeskStatus.rejected,
  //     1003 => HelpdeskStatus.pendingPayment,
  //     1010 => HelpdeskStatus.expired,
  //     1012 => HelpdeskStatus.readyToProceed,
  //     1013 => HelpdeskStatus.canceled,
  //     1005 => HelpdeskStatus.workInProgress,
  //     1006 => HelpdeskStatus.resultSent,
  //     1007 => HelpdeskStatus.finished,
  //     1008 => HelpdeskStatus.workInRevision,
  //     1014 => HelpdeskStatus.cancellationRequest,
  //     int() => throw UnimplementedError(),
  //   });
  // }

  int get code {
    return (switch (this) {
      HelpdeskStatus.createHelpdesk => 1,
      HelpdeskStatus.inProgressHelpdesk => 3,
      HelpdeskStatus.pendingHelpdesk => 2,
      HelpdeskStatus.doneHelpdesk => 4,
    });
  }
}
