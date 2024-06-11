import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(TaskModel.COLLECTION_NAME)
        .withConverter<TaskModel>(fromFirestore: (snapshot, _) {
      return TaskModel.fromJSON(snapshot.data()!);
    }, toFirestore: (task, _) {
      return task.toJSON();
    });
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(int date) {
    return getTasksCollection()
        .where("date", isEqualTo: date)
        .where("user_id", isEqualTo: getCurrentUser()!.uid)
        .snapshots(); // real-time read
    //return getTaskCollection().where("date",isEqualTo: date).get(); //one-time read
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel task) {
    return getTasksCollection().doc(task.id).update(task.toJSON());
  }

  //==========auth===============================
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.COLLECTION_NAME)
        .withConverter<UserModel>(fromFirestore: (snapshot, _) {
      return UserModel.fromJSON(snapshot.data()!);
    }, toFirestore: (user, _) {
      return user.toJSON();
    });
  }

  static void addUser(UserModel user, String userId) {
    var collection = getUsersCollection();
    var docRef = collection.doc(userId);
    user.id = userId;
    docRef.set(user);
  }

  static Future<UserCredential> signUp(String email, String password) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> login(String email, String password) {
    var userCredential =  FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
