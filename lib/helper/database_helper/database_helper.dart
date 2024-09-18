import 'dart:developer';
import 'package:RatingRadar_app/helper/database_helper/database_synonyms.dart';
import 'package:RatingRadar_app/modules/admin/homepage/model/admin_homepage_recent_manager_model.dart';
import 'package:RatingRadar_app/modules/manager/manager_signup/model/manager_signup_model.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant/strings.dart';
import '../../modules/admin/admin_manager/model/manager_model.dart';
import '../../modules/admin/admin_signin/model/admin_signin_model.dart';
import '../../modules/admin/admin_view_ad/admin_ad_comments_data.dart';
import '../../modules/admin/homepage/model/admin_homepage_recent_user_company_model.dart';
import '../../modules/signin/model/signin_model.dart';
import '../../modules/user/user_ads_list_menu/model/user_submitted_ads_list_data_model.dart';
import '../../modules/user/user_homepage/model/user_ads_list_data_model.dart';
import '../../modules/user/user_signup/model/user_signup_model.dart';
import '../../modules/user/user_submit_ad/model/user_submit_ad_data_model.dart';
import '../../modules/user/user_wallet/model/user_transaction_interface.dart';
import '../../modules/user/user_wallet/model/user_transaction_model.dart';
import '../shared_preferences_manager/preferences_manager.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();

  static DatabaseHelper get instance => _instance;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStoreInstance = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> signUpUser({required UserDataModel userSignupModel}) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: userSignupModel.email,
        password: userSignupModel.password,
      );
      await PreferencesManager.setUserUid(uid: userCredential.user?.uid ?? '');
      await sendLinkToEmail();

      await fireStoreInstance.collection(DatabaseSynonyms.usersCollection).doc(userCredential.user!.uid).set(userSignupModel.toMap());
      return CustomStatus.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return CustomStatus.userExists;
      } else {
        log("Exception: $e", name: "Exception");
      }
      return CustomStatus.userNotRegistered;
    }
  }

  Future addReferredByUserAmount(String referredByUserId) async {
    try {
      CollectionReference usersCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);
      DocumentSnapshot userDoc = await usersCollectionReference.doc(referredByUserId).get();
      if (userDoc.exists) {
        num userCurrentBalance = userDoc['userBalance'] as num;
        num increasedBalance = userCurrentBalance + 100;
        await usersCollectionReference.doc(referredByUserId).update({
          DatabaseSynonyms.userBalanceField: increasedBalance, // Updating the field
        });
      }
    } catch (e) {
      log("Exception: $e");
    }
  }

  Future<bool> checkIsUserVerified() async {
    User? user = firebaseAuth.currentUser;
    await user?.reload();
    user = firebaseAuth.currentUser;
    return user?.emailVerified ?? false;
  }

  Future<String> deleteUser() async {
    try {
      User? user = firebaseAuth.currentUser;
      await user?.delete();
      await fireStoreInstance.collection(DatabaseSynonyms.usersCollection).doc(user?.uid).delete();
      await PreferencesManager.deleteUserUid();
      return CustomStatus.success;
    } catch (e) {
      return CustomStatus.failedToLogout;
    }
  }

  Future<String> logoutUser() async {
    try {
      await PreferencesManager.deleteAllUserPreferences();
      await firebaseAuth.signOut();
      return CustomStatus.success;
    } catch (e) {
      return CustomStatus.failedToLogout;
    }
  }

  Future<void> sendLinkToEmail() async {
    try {
      User? user = firebaseAuth.currentUser;
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        AppUtility.showSnackBar('weHaveBlockedAllRequestsFromThisDeviceDueToUnusualActivityTryAfterSomeTime'.tr);
      } else {
        log("FirebaseAuthException: $e");
      }
    } catch (e) {
      log("Exception: $e");
    }
  }

  Future<String> signInUser({required UserSignInModel userSignInModel}) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: userSignInModel.email,
        password: userSignInModel.password,
      );
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        /// store data in shared preferences
        await PreferencesManager.setUserUid(uid: userCredential.user?.uid ?? '');
        return CustomStatus.success;
      } else if (userCredential.user?.emailVerified == false) {
        return CustomStatus.userNotVerified;
      } else {
        return CustomStatus.wrongEmailPassword;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return CustomStatus.wrongEmailPassword;
      } else {
        return CustomStatus.userNotFound;
      }
    } catch (e) {
      return CustomStatus.userNotFound;
    }
  }

  Future<String> signUpManager({required ManagerSignupModel managerSignupModel}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: managerSignupModel.email,
        password: managerSignupModel.password,
      );

      /// store data in shared preferences
      await PreferencesManager.setManagerUid(uid: userCredential.user?.uid ?? '');

      await FirebaseFirestore.instance
          .collection(DatabaseSynonyms.managerUsersCollection)
          .doc(userCredential.user!.uid)
          .set(managerSignupModel.toMap());
      return CustomStatus.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return CustomStatus.userExists;
      } else {
        log("Exception: $e", name: "Exception");
      }
      return CustomStatus.userNotRegistered;
    }
  }

  Future<QuerySnapshot?> getManagerSignInData({required UserSignInModel userSignInModel}) async {
    try {
      CollectionReference collection = fireStoreInstance.collection(DatabaseSynonyms.managerUsersCollection);
      Query emailQuery = collection
          .where(DatabaseSynonyms.emailField, isEqualTo: userSignInModel.email)
          .where(DatabaseSynonyms.passwordField, isEqualTo: userSignInModel.password);
      QuerySnapshot emailSnapshot = await emailQuery.get();

      if (emailSnapshot.docs.isNotEmpty) {
        return emailSnapshot;
      } else {
        Query userNameQuery = collection
            .where(DatabaseSynonyms.userNameField, isEqualTo: userSignInModel.email)
            .where(DatabaseSynonyms.passwordField, isEqualTo: userSignInModel.password);
        QuerySnapshot userNameSnapshot = await userNameQuery.get();
        if (userNameSnapshot.docs.isNotEmpty) {
          return userNameSnapshot;
        } else {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> signInManager({required UserSignInModel userSignInModel}) async {
    try {
      final snapshot = await getManagerSignInData(userSignInModel: userSignInModel);

      if (snapshot?.docs.isNotEmpty ?? false) {
        /// store data in shared preferences
        await PreferencesManager.setManagerUid(uid: snapshot?.docs.first.id ?? '');
        return CustomStatus.success;
      } else {
        return CustomStatus.wrongEmailPassword;
      }
    } catch (e) {
      return CustomStatus.userNotFound;
    }
  }

  Future<bool> checkUserExists({required String email}) async {
    try {
      CollectionReference collection = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);
      Query emailQuery = collection.where(DatabaseSynonyms.emailField, isEqualTo: email);
      QuerySnapshot emailSnapshot = await emailQuery.get();

      if (emailSnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkManagerExists({required String email}) async {
    try {
      CollectionReference collection = fireStoreInstance.collection(DatabaseSynonyms.managerUsersCollection);
      Query emailQuery = collection.where(DatabaseSynonyms.emailField, isEqualTo: email);
      QuerySnapshot emailSnapshot = await emailQuery.get();

      if (emailSnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String?> getUserName({required String uId}) async {
    try {
      DocumentReference userDocumentReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection).doc(uId);
      DocumentSnapshot userDocumentSnapshot = await userDocumentReference.get();
      if (userDocumentSnapshot.exists) {
        return userDocumentSnapshot.get('username');
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<UserAdsListDataModel>?> getLimitedAdsList({
    required int limit,
  }) async {
    try {
      Query query = fireStoreInstance
          .collection(DatabaseSynonyms.adsListCollection)
          .where(DatabaseSynonyms.adStatusField, isEqualTo: CustomStatus.active)
          .orderBy(DatabaseSynonyms.adStatusField, descending: false)
          .limit(limit);

      QuerySnapshot querySnapshot = await query.get();
      List<UserAdsListDataModel> adsList =
          querySnapshot.docs.map((docs) => UserAdsListDataModel.fromMap(docs.data() as Map<String, dynamic>, docId: docs.id)).toList();
      return adsList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  /*  Future<List<UserAdsListDataModel>?> getLimitedAdsList({
    required int limit,
    required int sortBy,
  }) async {
    try {
      Timestamp? startTimestamp;
      Timestamp? endTimestamp;

      final DateTime currentDate = DateTime.now();

      switch (sortBy) {
        case 0:

          /// Today
          {
            DateTime startDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
            DateTime endDate = DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);
            startTimestamp = Timestamp.fromDate(startDate);
            endTimestamp = Timestamp.fromDate(endDate);
            break;
          }
        case 1:

          /// Last week
          {
            DateTime startDate = currentDate.subtract(const Duration(days: 7));
            DateTime endDate = DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);
            startTimestamp = Timestamp.fromDate(startDate);
            endTimestamp = Timestamp.fromDate(endDate);
            break;
          }
        case 2:

          /// Last month
          {
            DateTime lastMonth = DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
            DateTime startDate = DateTime(lastMonth.year, lastMonth.month, 1);
            DateTime endDate = DateTime(lastMonth.year, lastMonth.month + 1, 0, 23, 59, 59);
            startTimestamp = Timestamp.fromDate(startDate);
            endTimestamp = Timestamp.fromDate(endDate);
            break;
          }
        case 3:

          /// Last year
          {
            DateTime startDate = DateTime(currentDate.year - 1, 1, 1);
            DateTime endDate = DateTime(currentDate.year - 1, 12, 31, 23, 59, 59);
            startTimestamp = Timestamp.fromDate(startDate);
            endTimestamp = Timestamp.fromDate(endDate);
            break;
          }
        default:
          {
            startTimestamp = null;
            endTimestamp = null;
            break;
          }
      }

      late Query query;
      if (startTimestamp != null && endTimestamp != null) {
        query = fireStoreInstance
            .collection(DatabaseSynonyms.adsListCollection)
            .where(DatabaseSynonyms.addedDateField, isGreaterThanOrEqualTo: startTimestamp)
            .where(DatabaseSynonyms.addedDateField, isLessThanOrEqualTo: endTimestamp)
            .orderBy(DatabaseSynonyms.addedDateField, descending: false)
            .limit(limit);
      } else {
        query = fireStoreInstance.collection(DatabaseSynonyms.adsListCollection).orderBy(DatabaseSynonyms.adNameField, descending: false).limit(limit);
      }

      QuerySnapshot querySnapshot = await query.get();
      List<UserAdsListDataModel> adsList = querySnapshot.docs.map((docs) => UserAdsListDataModel.fromMap(docs.data() as Map<String, dynamic>, docId: docs.id)).toList();
      return adsList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }*/

  Future<int> getTotalAdsCount() async {
    try {
      QuerySnapshot snapshot = await fireStoreInstance
          .collection(DatabaseSynonyms.adsListCollection)
          .where(DatabaseSynonyms.adStatusField, isEqualTo: CustomStatus.active)
          .get();
      return snapshot.size; // This gives the count of documents
    } catch (e) {
      log("Error fetching document count: $e");
      return 0;
    }
  }

  Future<List<UserAdsListDataModel>?> getAllAdsList({required int nDataPerPage, UserAdsListDataModel? adLastDocument}) async {
    try {
      CollectionReference adsCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.adsListCollection);

      /// store the last document id
      String? lastDocumentId = adLastDocument?.docId;
      List<UserAdsListDataModel> usersAdList = [];
      Query query = adsCollectionReference.where(DatabaseSynonyms.adStatusField, isEqualTo: CustomStatus.active).limit(nDataPerPage);

      if (lastDocumentId != null) {
        /// get the data after last document id
        DocumentSnapshot lastDocumentSnapshot = await adsCollectionReference.doc(lastDocumentId).get();
        query = query.startAfterDocument(lastDocumentSnapshot);
      }

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        usersAdList
            .addAll(querySnapshot.docs.map((docs) => UserAdsListDataModel.fromMap(docs.data() as Map<String, dynamic>, docId: docs.id)).toList());
      }
      return usersAdList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<UserAdsListDataModel?> getAdDataByDocId({required String docId}) async {
    try {
      CollectionReference adsCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.adsListCollection);

      UserAdsListDataModel? usersAdData;

      DocumentSnapshot documentSnapshot = await adsCollectionReference.doc(docId).get();
      final documentData = documentSnapshot.data();
      if (documentSnapshot.exists) {
        usersAdData = UserAdsListDataModel.fromMap(documentData as Map<String, dynamic>, docId: docId);
      }
      return usersAdData;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<int> getTotalSubmittedAdsCountLast24Hours({required String adId}) async {
    try {
      DateTime now = DateTime.now();
      DateTime yesterday = now.subtract(const Duration(hours: 24));
      Timestamp yesterdayTimestamp = Timestamp.fromDate(yesterday);

      QuerySnapshot snapshot = await fireStoreInstance
          .collection(DatabaseSynonyms.userSubmittedAdCollection)
          .where(DatabaseSynonyms.adIdField, isEqualTo: adId)
          .where(DatabaseSynonyms.addedDateField, isGreaterThan: yesterdayTimestamp)
          .get();

      return snapshot.size;
    } catch (e) {
      log("Error fetching document count: $e");
      return 0;
    }
  }

  Future<UserSubmitAdDataModel?> getUserSubmittedAdDetailData({required String uId, required String adId}) async {
    try {
      CollectionReference collectionRef = fireStoreInstance.collection(DatabaseSynonyms.userSubmittedAdCollection);
      QuerySnapshot querySnapshot =
          await collectionRef.where(DatabaseSynonyms.uIdField, isEqualTo: uId).where(DatabaseSynonyms.adIdField, isEqualTo: adId).get();
      if (querySnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        UserSubmitAdDataModel submittedAdData =
            UserSubmitAdDataModel.fromMap(documentSnapshot.data() as Map<String, dynamic>, submittedAdDocId: documentSnapshot.id);
        return submittedAdData;
      } else {
        return null;
      }
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<List<String>?> storeUserSubmittedAdImages({required List<XFile> filesList, required String uid, required String adId}) async {
    try {
      List<String> uploadedFilesUrl = [];
      for (XFile filesData in filesList) {
        final fileBytes = await filesData.readAsBytes();
        String filepath = 'ADID-$adId/UID-$uid/${filesData.name.split('.')[0]}';
        Reference storageRef = firebaseStorage.ref().child('user-submitted-ads/$filepath');

        // Create metadata with the correct MIME type
        final metadata = SettableMetadata(
          contentType: filesData.mimeType,
        );

        // Upload to Firebase Storage using putData
        UploadTask uploadTask = storageRef.putData(fileBytes, metadata);

        // Wait for the upload to complete
        await uploadTask;

        // Get the download URL
        String downloadURL = await storageRef.getDownloadURL();
        uploadedFilesUrl.add(downloadURL.split('&token')[0]);
      }
      return uploadedFilesUrl.isNotEmpty ? uploadedFilesUrl : null;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<String?> storeUserSubmittedAds({required UserSubmitAdDataModel userSubmitAdDataModel}) async {
    try {
      CollectionReference collectionRef = fireStoreInstance.collection(DatabaseSynonyms.userSubmittedAdCollection);
      DocumentReference documentReference = await collectionRef.add(userSubmitAdDataModel.toMap());
      return documentReference.id;
    } catch (e) {
      return null;
    }
  }

  Future<int> getsUserSubmittedAdsListCount({required String uId}) async {
    try {
      QuerySnapshot snapshot =
          await fireStoreInstance.collection(DatabaseSynonyms.userSubmittedAdCollection).where(DatabaseSynonyms.uIdField, isEqualTo: uId).get();
      return snapshot.size;
    } catch (e) {
      log("Error fetching document count: $e");
      return 0;
    }
  }

  Future<List<UserSubmittedAdsListDataModel>?> getUserSubmittedAdsList({
    required String uId,
    required int nDataPerPage,
    required int pageNumber,
    required int sortBy,
    String? searchTerm,
  }) async {
    try {
      CollectionReference userAdsCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.userSubmittedAdCollection);

      int startAt = (pageNumber - 1) * nDataPerPage;

      List<UserSubmittedAdsListDataModel> usersSubmittedAdsList = [];

      // Initial query to get the correct starting point
      // Query initialQuery = userAdsCollectionReference.orderBy(DatabaseSynonyms.adIdField);
      late Query initialQuery;
      if (searchTerm?.isNotEmpty ?? false) {
        String startSearch = searchTerm!;
        String endSearch = '$searchTerm\uf8ff';
        initialQuery = userAdsCollectionReference
            .where(DatabaseSynonyms.adNameField, isGreaterThanOrEqualTo: startSearch)
            .where(DatabaseSynonyms.adNameField, isLessThanOrEqualTo: endSearch)
            .where(DatabaseSynonyms.uIdField, isEqualTo: uId)
            .orderBy(
              DatabaseSynonyms.adNameField,
            );
      } else {
        initialQuery =
            userAdsCollectionReference.where(DatabaseSynonyms.uIdField, isEqualTo: uId).orderBy(DatabaseSynonyms.uIdField, descending: sortBy == 0);
      }

      QuerySnapshot? startSnapshot;

      if (startAt > 0) {
        startSnapshot = await initialQuery.limit(startAt).get();
      }

      Query paginatedQuery;

      if (startSnapshot != null && startSnapshot.docs.isNotEmpty) {
        DocumentSnapshot startDocument = startSnapshot.docs.last;
        paginatedQuery = initialQuery.startAfterDocument(startDocument).limit(nDataPerPage);
      } else {
        paginatedQuery = initialQuery.limit(nDataPerPage);
      }

      QuerySnapshot querySnapshot = await paginatedQuery.get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var snapshotData in querySnapshot.docs) {
          // DocumentSnapshot userData = await userCollectionReference.doc(snapshotData[DatabaseSynonyms.uIdField]).get();

          usersSubmittedAdsList.add(
            UserSubmittedAdsListDataModel(
              email: firebaseAuth.currentUser?.email ?? '',
              taskName: snapshotData['adName'],
              adId: snapshotData['adId'],
              date: (snapshotData['addedDate'] as Timestamp).toDate(),
              submittedAdDocId: snapshotData.id,
              adStatus: snapshotData['status'],
              company: snapshotData['company'],
              adPrice: snapshotData['adPrice'] as num,
            ),
          );
        }
      }

      return usersSubmittedAdsList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<List<UserTransactionModel>?> getUserTransactionsList({
    required int nDataPerPage,
    UserTransactionModel? adLastDocument,
    required bool isTransactionTypeWithdraw,
  }) async {
    try {
      CollectionReference userTransactionsCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.userTransactionsCollection);

      /// store the last document id
      String? lastDocumentId = adLastDocument?.transactionCollectionDocId;
      List<UserTransactionModel> usersTransactionsList = [];
      late Query query;
      if (isTransactionTypeWithdraw) {
        query = userTransactionsCollectionReference
            .where(DatabaseSynonyms.transactionTypeField, isEqualTo: 'withdraw')
            .orderBy(DatabaseSynonyms.dateField, descending: true)
            .limit(nDataPerPage);
      } else {
        query = userTransactionsCollectionReference
            .where(DatabaseSynonyms.transactionTypeField, isEqualTo: 'deposit')
            .orderBy(DatabaseSynonyms.dateField, descending: true)
            .limit(nDataPerPage);
      }

      if (lastDocumentId != null) {
        /// get the data after last document id
        DocumentSnapshot lastDocumentSnapshot = await userTransactionsCollectionReference.doc(lastDocumentId).get();
        query = query.startAfterDocument(lastDocumentSnapshot);
      }

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        usersTransactionsList.addAll(
            querySnapshot.docs.map((docs) => UserTransactionModel.fromMap(docs.data() as Map<String, dynamic>, transactionDocId: docs.id)).toList());
      }
      return usersTransactionsList.isNotEmpty ? usersTransactionsList : null;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<int> getUserApprovedAdsCount() async {
    try {
      QuerySnapshot snapshot = await fireStoreInstance
          .collection(DatabaseSynonyms.userSubmittedAdCollection)
          .where(DatabaseSynonyms.statusField, isEqualTo: CustomStatus.approved)
          .get();
      return snapshot.size;
    } catch (e) {
      log("Error fetching document count: $e");
      return 0;
    }
  }

  Future<int> getWithdrawTransactionsCount() async {
    try {
      QuerySnapshot snapshot = await fireStoreInstance
          .collection(DatabaseSynonyms.userTransactionsCollection)
          .where(DatabaseSynonyms.transactionTypeField, isEqualTo: 'withdraw')
          .get();
      return snapshot.size;
    } catch (e) {
      log("Error fetching document count: $e");
      return 0;
    }
  }

  Future<int> getDepositTransactionsCount() async {
    try {
      QuerySnapshot snapshot = await fireStoreInstance
          .collection(DatabaseSynonyms.userTransactionsCollection)
          .where(DatabaseSynonyms.transactionTypeField, isEqualTo: 'deposit')
          .get();
      return snapshot.size;
    } catch (e) {
      log("Error fetching document count: $e");
      return 0;
    }
  }

  Future<List<UserTransactionModel>?> getUserAdsTransactionList({
    required String uId,
    required int nDataPerPage,
    UserTransactionModel? adLastDocument,
  }) async {
    try {
      CollectionReference userAdsCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.userSubmittedAdCollection);

      /// store the last document id
      String? lastDocumentId = adLastDocument?.submittedAdDocId;
      List<UserTransactionModel> usersAdsTransactionsList = [];
      Query query = userAdsCollectionReference.where(DatabaseSynonyms.statusField, isEqualTo: CustomStatus.approved).limit(nDataPerPage);

      if (lastDocumentId != null) {
        /// get the data after last document id
        DocumentSnapshot lastDocumentSnapshot = await userAdsCollectionReference.doc(lastDocumentId).get();
        query = query.startAfterDocument(lastDocumentSnapshot);
      }

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var snapshotData in querySnapshot.docs) {
          usersAdsTransactionsList.add(
            UserTransactionModel(
              uId: snapshotData['uId'],
              status: snapshotData['status'],
              date: (snapshotData['addedDate'] as Timestamp).toDate(),
              amount: snapshotData['adPrice'],
              transactionId: '-',
              transactionType: 'ads',
              submittedAdDocId: snapshotData.id,
              transactionCollectionDocId: '',
            ),
          );
        }
      }
      return usersAdsTransactionsList.isNotEmpty ? usersAdsTransactionsList : null;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<String?> getUserCurrentBalance({required String uId}) async {
    try {
      CollectionReference usersCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);

      DocumentSnapshot userDoc = await usersCollectionReference.doc(uId).get();
      if (userDoc.exists) {
        num userCurrentBalance = userDoc['userBalance'] as num;
        return userCurrentBalance.toStringAsFixed(2);
      } else {
        return null;
      }
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<UserTransactionInterface> withdrawUserBalanceFromAdmin({
    required String uId,
    required num newBalance,
  }) async {
    try {
      CollectionReference usersCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);

      DocumentSnapshot userDoc = await usersCollectionReference.doc(uId).get();
      if (userDoc.exists) {
        num userCurrentBalance = userDoc['userBalance'] as num;
        if (userCurrentBalance >= newBalance) {
          num decreasedBalance = userCurrentBalance - newBalance;
          await usersCollectionReference.doc(uId).update({
            DatabaseSynonyms.userBalanceField: decreasedBalance, // Updating the field
          });
          return SuccessWithdrawResult(decreasedBalance);
        } else {
          return InsufficientBalanceWithdrawResult(userCurrentBalance);
        }
      } else {
        return const UnsuccessfulTransactionResult();
      }
    } catch (e) {
      log("Exception: $e");
      return const UnsuccessfulTransactionResult();
    }
  }

  Future<UserTransactionInterface> depositUserBalanceFromAdmin({
    required String uId,
    required num newBalance,
  }) async {
    try {
      CollectionReference usersCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);

      DocumentSnapshot userDoc = await usersCollectionReference.doc(uId).get();
      if (userDoc.exists) {
        num userCurrentBalance = userDoc['userBalance'] as num;
        num increasedBalance = userCurrentBalance + newBalance;
        await usersCollectionReference.doc(uId).update({
          DatabaseSynonyms.userBalanceField: increasedBalance, // Updating the field
        });
        return SuccessDepositResult(increasedBalance);
      } else {
        return const UnsuccessfulTransactionResult();
      }
    } catch (e) {
      log("Exception: $e");
      return const UnsuccessfulTransactionResult();
    }
  }

  Future<String?> storeUserTransaction({required UserTransactionModel userTransactionModel}) async {
    try {
      CollectionReference collectionRef = fireStoreInstance.collection(DatabaseSynonyms.userTransactionsCollection);
      DocumentReference documentReference = await collectionRef.add(userTransactionModel.toMap());
      return documentReference.id;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getUserProfilePicture({required String uId}) async {
    try {
      CollectionReference usersCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);

      String? userProfileImage;
      DocumentSnapshot userDoc = await usersCollectionReference.doc(uId).get();
      if (userDoc.exists) {
        userProfileImage = userDoc[DatabaseSynonyms.profileImageField];
        return userProfileImage;
      } else {
        return null;
      }
    } catch (e) {
      log('Exception : $e');
      return null;
    }
  }

  Future<UserDataModel?> getSpecificUserData({required String uId}) async {
    try {
      CollectionReference usersCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);

      UserDataModel? userData;
      DocumentSnapshot userDoc = await usersCollectionReference.doc(uId).get();
      if (userDoc.exists) {
        userData = UserDataModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return userData;
      } else {
        return null;
      }
    } catch (e) {
      log('Exception : $e');
      return null;
    }
  }

  Future<String?> updateUserProfilePictureInFireStore({required String profilePictureUrl, required String uId}) async {
    try {
      CollectionReference usersCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);
      await usersCollectionReference.doc(uId).update({DatabaseSynonyms.profileImageField: profilePictureUrl});
      return CustomStatus.success;
    } catch (e) {
      log('Exception : $e');
      return null;
    }
  }

  Future<String?> updateUserData({required UserDataModel userDataModel}) async {
    try {
      CollectionReference usersCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);
      await usersCollectionReference.doc(userDataModel.uId).update({
        DatabaseSynonyms.userNameField: userDataModel.username,
        DatabaseSynonyms.cityField: userDataModel.city,
        DatabaseSynonyms.genderField: userDataModel.gender,
        DatabaseSynonyms.panNumberField: userDataModel.panNumber,
        DatabaseSynonyms.phoneNumberField: userDataModel.phoneNumber,
        DatabaseSynonyms.stateField: userDataModel.state,
      });
      return CustomStatus.success;
    } catch (e) {
      log('Exception : $e');
      return null;
    }
  }

  Future<String?> updateUserPassword({required String newPassword}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      CollectionReference usersCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);

      if (user != null) {
        String? oldPassword;
        DocumentSnapshot userDoc = await usersCollectionReference.doc(user.uid).get();
        if (userDoc.exists) {
          oldPassword = await userDoc[DatabaseSynonyms.passwordField];
        }
        if (newPassword != oldPassword) {
          await user.updatePassword(newPassword);

          /// update user password in user table
          await usersCollectionReference.doc(user.uid).update({DatabaseSynonyms.passwordField: newPassword});
          return CustomStatus.success;
        } else {
          return CustomStatus.passwordExists;
        }
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return CustomStatus.requiresRecentLogin;
      } else {
        return null;
      }
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<String?> deleteUserUsingPassword({required String userPassword}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      CollectionReference usersCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);

      if (user != null) {
        String? password;
        DocumentSnapshot userDoc = await usersCollectionReference.doc(user.uid).get();
        if (userDoc.exists) {
          password = await userDoc[DatabaseSynonyms.passwordField];
        }
        if (userPassword == password) {
          /// delete user in user table
          await usersCollectionReference.doc(user.uid).delete();

          /// delete user in preferences
          await PreferencesManager.deleteAllUserPreferences();

          /// delete user in authentication
          await user.delete();

          return CustomStatus.success;
        } else {
          return CustomStatus.wrongEmailPassword;
        }
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return CustomStatus.requiresRecentLogin;
      } else {
        return null;
      }
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future removeUserProfilePictureInStorage({required String oldProfileImageUrl}) async {
    try {
      Reference oldFileRef = firebaseStorage.ref().child(oldProfileImageUrl);
      await oldFileRef.delete();
    } catch (e) {
      log('Exception : $e');
      return null;
    }
  }

  Future<String?> updateUserProfilePictureInStorage({
    XFile? newFileData,
    required String uId,
    String? oldProfileImage,
  }) async {
    try {
      if (newFileData != null) {
        if (oldProfileImage != null && oldProfileImage != '') {
          /// delete old file from firebase storage
          await removeUserProfilePictureInStorage(oldProfileImageUrl: oldProfileImage);
        }

        /// convert new file in bytes and store into storage
        String? uploadedFilesUrl;
        final fileBytes = await newFileData.readAsBytes();
        String filepath = 'Profile-Picture-UID-$uId/${newFileData.name.split('.')[0]}';
        Reference storageRef = firebaseStorage.ref().child('userProfileImages/$filepath');

        // Create metadata with the correct MIME type
        final metadata = SettableMetadata(
          contentType: newFileData.mimeType,
        );

        // Upload to Firebase Storage using putData
        UploadTask uploadTask = storageRef.putData(fileBytes, metadata);

        // Wait for the upload to complete
        await uploadTask;

        // Get the download URL
        String downloadURL = await storageRef.getDownloadURL();
        uploadedFilesUrl = downloadURL.split('&token')[0];

        return uploadedFilesUrl.isNotEmpty ? uploadedFilesUrl : null;
      } else {
        return null;
      }
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  ///  ---------------------------------------------- Admin Methods -------------------------------------------------

  Future<String> signInAdmin({required AdminSignInModel adminSignInModel}) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: adminSignInModel.email,
        password: adminSignInModel.password,
      );
      if (userCredential.user != null) {
        /// store data in shared preferences
        await PreferencesManager.setAdminUid(adminUid: userCredential.user?.uid ?? '');
        return CustomStatus.success;
      } else if (userCredential.user?.emailVerified == false) {
        return CustomStatus.userNotVerified;
      } else {
        return CustomStatus.wrongEmailPassword;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return CustomStatus.wrongEmailPassword;
      } else {
        return CustomStatus.userNotFound;
      }
    } catch (e) {
      return CustomStatus.userNotFound;
    }
  }

  Future<UserAdsListDataModel?> getAdminSubmittedAdDetailData({required String adId}) async {
    try {
      CollectionReference collectionRef = fireStoreInstance.collection(DatabaseSynonyms.adsListCollection);
      QuerySnapshot querySnapshot = await collectionRef.where(DatabaseSynonyms.adIdField, isEqualTo: adId).get();
      if (querySnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        UserAdsListDataModel submittedAdData =
            UserAdsListDataModel.fromMap(documentSnapshot.data() as Map<String, dynamic>, docId: documentSnapshot.id);
        return submittedAdData;
      } else {
        return null;
      }
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

// fetch Limited users data
  Future<List<AdminHomepageRecentUserCompanyModel>?> getLimitedUserList({
    required int limit,
  }) async {
    try {
      Query query =
          fireStoreInstance.collection(DatabaseSynonyms.usersCollection).orderBy(DatabaseSynonyms.createdAtField, descending: false).limit(limit);

      QuerySnapshot querySnapshot = await query.get();
      List<AdminHomepageRecentUserCompanyModel> userList =
          querySnapshot.docs.map((docs) => AdminHomepageRecentUserCompanyModel.fromMap(docs.data() as Map<String, dynamic>, docId: docs.id)).toList();
      return userList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<List<ManagerModel>?> getLimitedManagerList({
    required int limit,
  }) async {
    try {
      Query query = fireStoreInstance
          .collection(DatabaseSynonyms.managerUsersCollection)
          .orderBy(DatabaseSynonyms.createdAtField, descending: false)
          .limit(limit);

      QuerySnapshot querySnapshot = await query.get();
      List<ManagerModel> managerList = querySnapshot.docs
          .map((docs) => ManagerModel.fromMap(
                docs.data() as Map<String, dynamic>,
              ))
          .toList();
      return managerList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<String> getCurrentAdminEmail() async {
    User? user = firebaseAuth.currentUser;
    return user?.email ?? '';
  }

  Future<List<UserAdsListDataModel>?> getsAdminTotalAdsList({
    required int nDataPerPage,
    required int pageNumber,
    required int sortBy,
    String? searchTerm,
  }) async {
    try {
      CollectionReference adminAdsCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.adsListCollection);

      int startAt = (pageNumber - 1) * nDataPerPage;

      List<UserAdsListDataModel> adminSubmittedAdsList = [];

      // Initial query to get the correct starting point
      // Query initialQuery = userAdsCollectionReference.orderBy(DatabaseSynonyms.adIdField);
      late Query initialQuery;
      if (searchTerm?.isNotEmpty ?? false) {
        String startSearch = searchTerm!;
        String endSearch = '$searchTerm\uf8ff';
        initialQuery = adminAdsCollectionReference
            .where(DatabaseSynonyms.adNameField, isGreaterThanOrEqualTo: startSearch)
            .where(DatabaseSynonyms.adNameField, isLessThanOrEqualTo: endSearch)
            .orderBy(
              DatabaseSynonyms.companyAdAction,
            );
      } else {
        initialQuery = adminAdsCollectionReference.orderBy(DatabaseSynonyms.adStatusField, descending: sortBy == 0);
      }

      QuerySnapshot? startSnapshot;

      if (startAt > 0) {
        startSnapshot = await initialQuery.limit(startAt).get();
      }

      Query paginatedQuery;

      if (startSnapshot != null && startSnapshot.docs.isNotEmpty) {
        DocumentSnapshot startDocument = startSnapshot.docs.last;
        paginatedQuery = initialQuery.startAfterDocument(startDocument).limit(nDataPerPage);
      } else {
        paginatedQuery = initialQuery.limit(nDataPerPage);
      }

      QuerySnapshot querySnapshot = await paginatedQuery.get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var snapshotData in querySnapshot.docs) {
          // DocumentSnapshot userData = await userCollectionReference.doc(snapshotData[DatabaseSynonyms.uIdField]).get();
          adminSubmittedAdsList.add(
            UserAdsListDataModel(
              adName: snapshotData['adName'],
              addedDate: (snapshotData['addedDate'] as Timestamp).toDate(),
              byCompany: snapshotData['byCompany'],
              adPrice: snapshotData['adPrice'],
              adContent: snapshotData['adContent'],
              docId: snapshotData.id,
              adStatus: snapshotData['adStatus'],
              adLocation: snapshotData['adLocation'],
              companyAdAction: snapshotData['companyAdAction'],
              imageUrl: [],
            ),
          );
        }
      }

      return adminSubmittedAdsList;
    } catch (e) {
      log("Exception2: $e");
      return null;
    }
  }

// insert ads data
  Future<List<UserAdsListDataModel>> storeAllAdminSubmittedAds() async {
    try {
      QuerySnapshot querySnapshot = await fireStoreInstance.collection(DatabaseSynonyms.adsListCollection).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((documentSnapshot) {
          return UserAdsListDataModel.fromMap(documentSnapshot.data() as Map<String, dynamic>, docId: documentSnapshot.id);
        }).toList();
      } else {
        log("No documents found in collection ${DatabaseSynonyms.adsListCollection}.");
        return [];
      }
    } catch (e) {
      log("Exception while fetching documents: $e");
      return [];
    }
  }

  Future<int> getsAdminSubmittedAdsListCount() async {
    try {
      QuerySnapshot snapshot = await fireStoreInstance.collection(DatabaseSynonyms.adsListCollection).get();
      return snapshot.size;
    } catch (e) {
      log("Error fetching document count: $e");
      return 0;
    }
  }

  Future<List<String>?> storeAdminSubmittedAdImages({required List<XFile> filesList, required String uid, required String adId}) async {
    try {
      List<String> uploadedFilesUrl = [];
      for (XFile filesData in filesList) {
        final fileBytes = await filesData.readAsBytes();
        String filepath = 'ADID-$adId/UID-$uid/${filesData.name.split('.')[0]}';
        Reference storageRef = firebaseStorage.ref().child('user-submitted-ads/$filepath');

        // Create metadata with the correct MIME type
        final metadata = SettableMetadata(
          contentType: filesData.mimeType,
        );

        // Upload to Firebase Storage using putData
        UploadTask uploadTask = storageRef.putData(fileBytes, metadata);

        // Wait for the upload to complete
        await uploadTask;

        // Get the download URL
        String downloadURL = await storageRef.getDownloadURL();
        uploadedFilesUrl.add(downloadURL.split('&token')[0]);
      }
      return uploadedFilesUrl.isNotEmpty ? uploadedFilesUrl : null;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<List<String>?> storeAdminCreatedAdsImages({required List<XFile> filesList, required String adminId, required String adName}) async {
    try {
      List<String> uploadedFilesUrl = [];
      for (XFile filesData in filesList) {
        final fileBytes = await filesData.readAsBytes();
        String filepath = 'adminId-$adminId/adName-$adName/${filesData.name.split('.')[0]}';
        Reference storageRef = firebaseStorage.ref().child('adsImages/$filepath');

        // Create metadata with the correct MIME type
        final metadata = SettableMetadata(
          contentType: filesData.mimeType,
        );

        // Upload to Firebase Storage using putData
        UploadTask uploadTask = storageRef.putData(fileBytes, metadata);

        // Wait for the upload to complete
        await uploadTask;

        // Get the download URL
        String downloadURL = await storageRef.getDownloadURL();
        uploadedFilesUrl.add(downloadURL.split('&token')[0]);
      }
      return uploadedFilesUrl.isNotEmpty ? uploadedFilesUrl : null;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<String?> storeAdminCreatedAds({required UserAdsListDataModel userAdsListDataModel}) async {
    try {
      CollectionReference collectionRef = fireStoreInstance.collection(DatabaseSynonyms.adsListCollection);
      DocumentReference documentReference = await collectionRef.add(userAdsListDataModel.toMap());
      return documentReference.id;
    } catch (e) {
      return null;
    }
  }

  Future<List<AdminCommentsListUserData>?> getCommentedUsersData({required String adId}) async {
    List<AdminCommentsListUserData> userAdDataList = [];
    try {
      // Fetch comments from userSubmittedAdCollection by adId
      QuerySnapshot adSnapshot =
          await fireStoreInstance.collection(DatabaseSynonyms.userSubmittedAdCollection).where(DatabaseSynonyms.adIdField, isEqualTo: adId).get();

      // Loop through each comment
      for (var adDoc in adSnapshot.docs) {
        Map<String, dynamic> adData = adDoc.data() as Map<String, dynamic>;
        String userId = adData['uId']; // User ID from the comment collection
        String comment = adData['comments']; // Comment from the comment collection

        // Fetch user details from users collection using the userId
        DocumentSnapshot<Map<String, dynamic>> userSnapshot = await fireStoreInstance.collection(DatabaseSynonyms.usersCollection).doc(userId).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

          // Combine user details with comment data
          AdminCommentsListUserData userAdData = AdminCommentsListUserData(
            userId: userId,
            username: userData['username'],
            userProfileImage: userData['profileImage'],
            comment: comment, // Comment from the userSubmittedAdCollection
          );

          // Add to the list
          userAdDataList.add(userAdData);
        }
      }
    } catch (e) {
      log("Error fetching data: $e");
      return null;
    }

    return userAdDataList.isEmpty ? null : userAdDataList;
  }

  Future<String?> updateAdCustomStatus({required String status, required String adId, String? reason, required String action}) async {
    try {
      CollectionReference adsCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.adsListCollection);
      await adsCollectionReference
          .doc(adId)
          .update({DatabaseSynonyms.adStatusField: status, DatabaseSynonyms.companyAdAction: action, DatabaseSynonyms.adBlockReason: reason});
      return CustomStatus.success;
    } catch (e) {
      log('Exception : $e');
      return null;
    }
  }

  Future<String> logoutAdmin() async {
    try {
      await firebaseAuth.signOut();
      await PreferencesManager.deleteUserUid();
      await PreferencesManager.deleteDrawerIndexes();
      return CustomStatus.success;
    } catch (e) {
      return CustomStatus.failedToLogout;
    }
  }

  Future<List<AdminHomepageRecentUserCompanyModel>?> getAllUsersList({
    required int nDataPerPage,
    required int sortBy,
    String? searchTerm,
    DocumentSnapshot? lastDocument, // Optional last document for pagination
  }) async {
    try {
      Query query = fireStoreInstance
          .collection(DatabaseSynonyms.usersCollection)
          .orderBy(DatabaseSynonyms.createdAtField, descending: sortBy == 0)
          .limit(nDataPerPage);

      if (searchTerm?.isNotEmpty ?? false) {
        String startSearch = searchTerm!;
        String endSearch = '$searchTerm\uf8ff';
        query = query
            .where(DatabaseSynonyms.userNameField, isGreaterThanOrEqualTo: startSearch)
            .where(DatabaseSynonyms.userNameField, isLessThanOrEqualTo: endSearch);
      }

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot querySnapshot = await query.get();

      List<AdminHomepageRecentUserCompanyModel> userList = querySnapshot.docs
          .map((doc) =>
              AdminHomepageRecentUserCompanyModel.fromMap(doc.data() as Map<String, dynamic>, docId: doc.id // Store the full document for pagination
                  ))
          .toList();

      return userList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<List<ManagerModel>?> getAllManagersList({
    required int nDataPerPage,
    required int sortBy,
    String? searchTerm,
    DocumentSnapshot? lastDocument, // Optional last document for pagination
  }) async {
    try {
      Query query = fireStoreInstance
          .collection(DatabaseSynonyms.managerUsersCollection)
          .orderBy(DatabaseSynonyms.userNameField, descending: sortBy == 0)
          .limit(nDataPerPage);
      print("Query query nDataPerPage $nDataPerPage \n searchTerm $searchTerm");

      if (searchTerm?.isNotEmpty ?? false) {
        String startSearch = searchTerm!;
        String endSearch = '$searchTerm\uf8ff';
        query = query
            .where(DatabaseSynonyms.userNameField, isGreaterThanOrEqualTo: startSearch)
            .where(DatabaseSynonyms.userNameField, isLessThanOrEqualTo: endSearch);
      }

      print("Query query ${query.parameters}");
      print("Query lastDocument ${lastDocument}");

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }
      print("Query query ${query.parameters}");

      QuerySnapshot querySnapshot = await query.get();
      print("querySnapshot ${querySnapshot.docs}");

      List<ManagerModel> managerList = querySnapshot.docs
          .map((doc) => ManagerModel.fromMap(
                doc.data() as Map<String, dynamic>, // Store the full document for pagination
              ))
          .toList();

      // Add print statement to log the fetched data
      print('Fetched managers: ${managerList.map((manager) => manager.toString()).toList()}');

      return managerList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

/*  Future<List<AdminHomepageRecentUserCompanyModel>?> getAllUserPaginatedList({
    required int nDataPerPage,
    required int sortBy,
    String? searchTerm,
  }) async {
    try {
      // Collection reference
      CollectionReference adminAllUserCollectionReference = fireStoreInstance.collection(DatabaseSynonyms.usersCollection);

      List<AdminHomepageRecentUserCompanyModel> adminAllUsersAdsList = [];

      // Initial query with search term handling
      Query initialQuery;
      if (searchTerm?.isNotEmpty ?? false) {
        String startSearch = searchTerm!;
        String endSearch = '$searchTerm\uf8ff';
        initialQuery = adminAllUserCollectionReference
            .where(DatabaseSynonyms.userNameField, isGreaterThanOrEqualTo: startSearch)
            .where(DatabaseSynonyms.userNameField, isLessThanOrEqualTo: endSearch)
            .orderBy(DatabaseSynonyms.createdAtField, descending: true); // Order by createdAt field.
      } else {
        initialQuery = adminAllUserCollectionReference;
      }

      QuerySnapshot? startSnapshot;
      if (nDataPerPage > 0) {
        // Initial query to get the first set of documents
        startSnapshot = await initialQuery.limit(nDataPerPage).get();
      }

      Query paginatedQuery;

      // Check if pagination should happen
      if (startSnapshot != null && startSnapshot.docs.isNotEmpty) {
        DocumentSnapshot startDocument = startSnapshot.docs.last;
        paginatedQuery = initialQuery.startAfterDocument(startDocument).limit(nDataPerPage);
      } else {
        paginatedQuery = initialQuery.limit(nDataPerPage); // First page
      }

      QuerySnapshot querySnapshot = await paginatedQuery.get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var snapshotData in querySnapshot.docs) {
          // Safely extract data to avoid any missing field errors
          adminAllUsersAdsList.add(
            AdminHomepageRecentUserCompanyModel(
              name: snapshotData[DatabaseSynonyms.userNameField] ?? 'Username',
              createdAt: (snapshotData[DatabaseSynonyms.createdAtField] as Timestamp).toDate(),
              email: snapshotData[DatabaseSynonyms.emailField] ?? 'No Email',
              imageUrl: snapshotData[DatabaseSynonyms.profileImageField] ?? '',
            ),
          );
        }
      }

      return adminAllUsersAdsList;
    } catch (e) {
      log("Exception occurred while fetching data: $e");
      return null; // Return empty list on error or no data found
    }
  }*/
}
