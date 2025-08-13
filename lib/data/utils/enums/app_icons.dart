enum AppIcons {
  animation('assets/icons/animation.svg'),
  bell('assets/icons/bell.svg'),
  bussiness('assets/icons/bussiness.svg'),
  categoryFilled('assets/icons/category_filled.png'),
  categoryOutlined('assets/icons/category_outlined.png'),
  chatFilled('assets/icons/chat_filled.png'),
  chatOutlined('assets/icons/chat_outlined.png'),
  contentCreator('assets/icons/content_creator.svg'),
  filter('assets/icons/filter.svg'),
  heartFilled('assets/icons/heart_filled.svg'),
  heart('assets/icons/heart.svg'),
  homeFilled('assets/icons/home_filled.png'),
  homeOutlined('assets/icons/home_outlined.png'),
  lifestyle('assets/icons/lifestyle.svg'),
  logoDesign('assets/icons/logodesign.svg'),
  marketing('assets/icons/marketing.svg'),
  onanCoin('assets/icons/onan_coin.svg'),
  profileFilled('assets/icons/profile_filled.png'),
  profileOutlined('assets/icons/profile_outlined.png'),
  search('assets/icons/search.svg'),
  songWriter('assets/icons/song_writer.svg'),
  transactionFilled('assets/icons/transaction_filled.png'),
  transactionOutlined('assets/icons/transaction_outlined.png'),
  translate('assets/icons/translate.svg'),
  videoEditing('assets/icons/video_editing.svg'),
  website('assets/icons/website.svg'),
  clock('assets/icons/icon_clock.svg'),
  share('assets/icons/icon-share.svg'),

  custom(''),

  ///
  ;

  const AppIcons(this.path);
  final String path;

  String val(String path) {
    return path;
  }
}
