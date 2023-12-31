import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_shopy/constants/constants.dart';
import 'package:smart_shopy/models/category_model/category_model.dart';
import 'package:smart_shopy/models/product_model/product_model.dart';
import 'package:smart_shopy/models/user_model/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //* Category model
  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = await querySnapshot.docs
          .map(
            (e) => CategoryModel.fromJson(
              e.data(),
            ),
          )
          .toList();
      return categoriesList;
    } catch (e) {
      showMessage(
        e.toString(),
      );
      return [];
    }
  }

  //* Product model
  Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = await querySnapshot.docs
          .map(
            (e) => ProductModel.fromJson(
              e.data(),
            ),
          )
          .toList();
      return productModelList;
    } catch (e) {
      showMessage(
        e.toString(),
      );
      return [];
    }
  }

  //* category view product model
  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();

      List<ProductModel> productModelList = await querySnapshot.docs
          .map(
            (e) => ProductModel.fromJson(
              e.data(),
            ),
          )
          .toList();
      return productModelList;
    } catch (e) {
      showMessage(
        e.toString(),
      );
      return [];
    }
  }

  //* User information
  Future<UserModel> getUserInfo() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return UserModel.fromJson(
      querySnapshot.data()!,
    );
  }
}
