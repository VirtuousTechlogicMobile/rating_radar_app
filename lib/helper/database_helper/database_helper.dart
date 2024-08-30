import 'dart:developer';

import 'package:RatingRadar_app/helper/database_helper/database_synonyms.dart';
import 'package:RatingRadar_app/modules/manager/manager_signup/model/manager_signup_model.dart';
import 'package:RatingRadar_app/modules/user/homepage/model/user_ads_list_data_model.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/strings.dart';
import '../../modules/admin/admin_signin/model/admin_signin_model.dart';
import '../../modules/admin/homepage/model/admin_ads_list_data_model.dart';
import '../../modules/admin/homepage/model/admin_homepage_recent_user_company_model.dart';
import '../../modules/signin/model/signin_model.dart';
import '../../modules/user/user_signup/model/user_signup_model.dart';
import '../../modules/user/user_submit_ad/model/user_submit_ad_data_model.dart';
import '../shared_preferences_manager/preferences_manager.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();

  static DatabaseHelper get instance => _instance;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStoreInstance = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> signUpUser({required UserSignupModel userSignupModel}) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: userSignupModel.email,
        password: userSignupModel.password,
      );
      await PreferencesManager.setUserUid(uid: userCredential.user?.uid ?? '');
      await sendLinkToEmail();

      await fireStoreInstance
          .collection(DatabaseSynonyms.usersCollection)
          .doc(userCredential.user!.uid)
          .set(userSignupModel.toMap());
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

  Future<bool> checkIsUserVerified() async {
    User? user = firebaseAuth.currentUser;
    await user?.reload();
    user = firebaseAuth.currentUser;
    return user?.emailVerified ?? false;
  }

  Future<String> logoutUser() async {
    try {
      User? user = firebaseAuth.currentUser;
      await user?.delete();
      await fireStoreInstance
          .collection(DatabaseSynonyms.usersCollection)
          .doc(user?.uid)
          .delete();
      await PreferencesManager.deleteUserUid(uid: user?.uid ?? '');
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
        AppUtility.showSnackBar(
            'weHaveBlockedAllRequestsFromThisDeviceDueToUnusualActivityTryAfterSomeTime'
                .tr);
      } else {
        log("FirebaseAuthException: $e");
      }
    } catch (e) {
      log("Exception: $e");
    }
  }

  Future<String> signInUser({required UserSignInModel userSignInModel}) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: userSignInModel.email,
        password: userSignInModel.password,
      );
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        /// store data in shared preferences
        await PreferencesManager.setUserUid(
            uid: userCredential.user?.uid ?? '');
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
        print("e : $e");
        return CustomStatus.userNotFound;
      }
    } catch (e) {
      print(e);
      return CustomStatus.userNotFound;
    }
  }

  Future<String> signUpManager(
      {required ManagerSignupModel managerSignupModel}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: managerSignupModel.email,
        password: managerSignupModel.password,
      );

      /// store data in shared preferences
      await PreferencesManager.setManagerUid(
          uid: userCredential.user?.uid ?? '');

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

  Future<QuerySnapshot?> getManagerSignInData(
      {required UserSignInModel userSignInModel}) async {
    try {
      CollectionReference collection =
          fireStoreInstance.collection(DatabaseSynonyms.managerUsersCollection);
      Query emailQuery = collection
          .where(DatabaseSynonyms.emailField, isEqualTo: userSignInModel.email)
          .where(DatabaseSynonyms.passwordField,
              isEqualTo: userSignInModel.password);
      QuerySnapshot emailSnapshot = await emailQuery.get();

      if (emailSnapshot.docs.isNotEmpty) {
        return emailSnapshot;
      } else {
        Query userNameQuery = collection
            .where(DatabaseSynonyms.userNameField,
                isEqualTo: userSignInModel.email)
            .where(DatabaseSynonyms.passwordField,
                isEqualTo: userSignInModel.password);
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

  Future<String> signInManager(
      {required UserSignInModel userSignInModel}) async {
    try {
      final snapshot =
          await getManagerSignInData(userSignInModel: userSignInModel);

      if (snapshot?.docs.isNotEmpty ?? false) {
        /// store data in shared preferences
        await PreferencesManager.setManagerUid(
            uid: snapshot?.docs.first.id ?? '');
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
      CollectionReference collection =
          fireStoreInstance.collection(DatabaseSynonyms.usersCollection);
      Query emailQuery =
          collection.where(DatabaseSynonyms.emailField, isEqualTo: email);
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
      CollectionReference collection =
          fireStoreInstance.collection(DatabaseSynonyms.managerUsersCollection);
      Query emailQuery =
          collection.where(DatabaseSynonyms.emailField, isEqualTo: email);
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
      DocumentReference userDocumentReference = fireStoreInstance
          .collection(DatabaseSynonyms.usersCollection)
          .doc(uId);
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
          .where(DatabaseSynonyms.adStatusField,
              isEqualTo: DatabaseStatusSynonyms.showAdStatus)
          .orderBy(DatabaseSynonyms.adStatusField, descending: false)
          .limit(limit);

      QuerySnapshot querySnapshot = await query.get();
      List<UserAdsListDataModel> adsList = querySnapshot.docs
          .map((docs) => UserAdsListDataModel.fromMap(
              docs.data() as Map<String, dynamic>,
              docId: docs.id))
          .toList();
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
          .where(DatabaseSynonyms.adStatusField,
              isEqualTo: DatabaseStatusSynonyms.showAdStatus)
          .get();
      return snapshot.size; // This gives the count of documents
    } catch (e) {
      log("Error fetching document count: $e");
      return 0;
    }
  }

  Future<List<UserAdsListDataModel>?> getAllAdsList(
      {required int nDataPerPage, UserAdsListDataModel? adLastDocument}) async {
    try {
      CollectionReference adsCollectionReference =
          fireStoreInstance.collection(DatabaseSynonyms.adsListCollection);
      FirebaseFirestore.instance.collection('adsListCollection');

      /// store the last document id
      String? lastDocumentId = adLastDocument?.docId;
      List<UserAdsListDataModel> usersAdList = [];
      Query query = adsCollectionReference
          .where(DatabaseSynonyms.adStatusField,
              isEqualTo: DatabaseStatusSynonyms.showAdStatus)
          .limit(nDataPerPage);

      if (lastDocumentId != null) {
        /// get the data after last document id
        DocumentSnapshot lastDocumentSnapshot =
            await adsCollectionReference.doc(lastDocumentId).get();
        query = query.startAfterDocument(lastDocumentSnapshot);
      }

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        usersAdList.addAll(querySnapshot.docs
            .map((docs) => UserAdsListDataModel.fromMap(
                docs.data() as Map<String, dynamic>,
                docId: docs.id))
            .toList());
      }
      return usersAdList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<UserAdsListDataModel?> documentData({required String docId}) async {
    try {
      CollectionReference adsCollectionReference =
          fireStoreInstance.collection(DatabaseSynonyms.adsListCollection);
      FirebaseFirestore.instance.collection('adsListCollection');

      UserAdsListDataModel? usersAdData;

      DocumentSnapshot documentSnapshot =
          await adsCollectionReference.doc(docId).get();
      final documentData = documentSnapshot.data();
      if (documentSnapshot.exists) {
        usersAdData = UserAdsListDataModel.fromMap(
            documentData as Map<String, dynamic>,
            docId: docId);
      }
      return usersAdData;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<List<String>?> storeUserSubmittedAdImages(
      {required List<XFile> filesList,
      required String uid,
      required String adId}) async {
    try {
      List<String> uploadedFilesUrl = [];
      for (XFile filesData in filesList) {
        final fileBytes = await filesData.readAsBytes();
        String filepath = 'ADID-$adId/UID-$uid/${filesData.name.split('.')[0]}';
        Reference storageRef =
            firebaseStorage.ref().child('user-submitted-ads/$filepath');

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

  Future<String?> storeUserSubmittedAds(
      {required UserSubmitAdDataModel userSubmitAdDataModel}) async {
    try {
      CollectionReference collectionRef = fireStoreInstance
          .collection(DatabaseSynonyms.userSubmittedAdCollection);
      DocumentReference documentReference =
          await collectionRef.add(userSubmitAdDataModel.toMap());
      return documentReference.id;
    } catch (e) {
      return null;
    }
  }

  ///  ---------------------------------------------- Admin Methods -------------------------------------------------

  Future<String> signInAdmin(
      {required AdminSignInModel adminSignInModel}) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: adminSignInModel.email,
        password: adminSignInModel.password,
      );
      if (userCredential.user != null) {
        /// store data in shared preferences
        await PreferencesManager.setAdminUid(
            adminUid: userCredential.user?.uid ?? '');
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
        print("e : $e");
        return CustomStatus.userNotFound;
      }
    } catch (e) {
      print(e);
      return CustomStatus.userNotFound;
    }
  }

  Future<List<AdminAdsListDataModel>?> admingetLimitedAdsList({
    required int limit,
  }) async {
    try {
      Query query = fireStoreInstance
          .collection(DatabaseSynonyms.adsListCollection)
          .where(DatabaseSynonyms.adStatusField,
              isEqualTo: DatabaseStatusSynonyms.showAdStatus)
          .orderBy(DatabaseSynonyms.adStatusField, descending: false)
          .limit(limit);

      QuerySnapshot querySnapshot = await query.get();
      List<AdminAdsListDataModel> adsList = querySnapshot.docs
          .map((docs) => AdminAdsListDataModel.fromMap(
              docs.data() as Map<String, dynamic>,
              docId: docs.id))
          .toList();
      return adsList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

// fetch users data
  Future<List<AdminHomepageRecentUserCompanyModel>?> getLimitedUserList({
    required int limit,
  }) async {
    try {
      Query query = fireStoreInstance
          .collection(DatabaseSynonyms.usersCollection)
          .orderBy(DatabaseSynonyms.createdAt, descending: false)
          .limit(limit);

      QuerySnapshot querySnapshot = await query.get();
      List<AdminHomepageRecentUserCompanyModel> userList = querySnapshot.docs
          .map((docs) => AdminHomepageRecentUserCompanyModel.fromMap(
              docs.data() as Map<String, dynamic>,
              docId: docs.id))
          .toList();
      return userList;
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }
}
