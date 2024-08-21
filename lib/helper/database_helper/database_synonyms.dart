abstract class DatabaseSynonyms {
  /// collections
  // users -----------------------
  static const usersCollection = 'users';
  static const adsListCollection = 'adsList';
  static const userSubmittedAdCollection = 'userSubmittedAd';

  // managers -----------------------
  static const managerUsersCollection = 'managerUsers';

  /// fields
  // users -----------------------
  static const emailField = 'email';
  static const passwordField = 'password';
  static const userNameField = 'username';
  static const phoneNumberField = 'phoneNumber';
  static const adNameField = 'adName';
  static const adStatusField = 'adStatus';
  static const addedDateField = 'addedDate';
  static const adIdField = 'adId';
  static const uIdField = 'uId';
}

abstract class DatabaseStatusSynonyms {
  // users -----------------------
  static const showAdStatus = 'show';
  static const blockedAdStatus = 'blocked';
}
