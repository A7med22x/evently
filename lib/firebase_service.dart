import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:evently/models/event_model.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventCollection() =>
      FirebaseFirestore.instance
          .collection('events')
          .withConverter<EventModel>(
            fromFirestore: (snapshot, _) =>
                EventModel.fromJson(snapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
          );

  static CollectionReference<UserModel> getUserCollection() => FirebaseFirestore
      .instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  static Future<void> createEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference<EventModel> doc = eventCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<EventModel>> getEvents() async {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    QuerySnapshot<EventModel> querySnapshot = await eventCollection
        .orderBy('timestamp')
        .get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference<EventModel> doc = eventCollection.doc(event.id);
    return doc.delete();
  }

  static Future<void> updateEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference<EventModel> doc = eventCollection.doc(event.id);

    return doc.update({
      'categoryId': event.category.id,
      'title': event.title,
      'description': event.description,
      'timestamp': Timestamp.fromDate(event.dateTime),
    });
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
      favoriteEventsIds: [],
    );

    CollectionReference<UserModel> userCollection = getUserCollection();
    userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentSnapshot<UserModel> docSnapshot = await userCollection
        .doc(credential.user!.uid)
        .get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<UserModel> registerWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn.instance;
    await GoogleSignIn.instance.initialize(
      clientId:
          "123054204839-7brd2cifr1fsdv3lf2332odsscbdiiad.apps.googleusercontent.com",
      serverClientId:
          "123054204839-dbgf4nkpnp3ib29cv5a240ilron7fgn6.apps.googleusercontent.com",
    );
    GoogleSignInAccount account = await googleSignIn.authenticate();
    GoogleSignInAuthentication googleAuth = account.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    UserModel user = UserModel(
      id: userCredential.user!.uid,
      name:
          userCredential.user!.displayName ??
          account.displayName ??
          'User Name',
      email: userCredential.user!.email ?? account.email,
      favoriteEventsIds: [],
    );

    CollectionReference<UserModel> userCollection = getUserCollection();
    userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> loginWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn.instance;
    await GoogleSignIn.instance.initialize(
      clientId:
          "123054204839-7brd2cifr1fsdv3lf2332odsscbdiiad.apps.googleusercontent.com",
      serverClientId:
          "123054204839-dbgf4nkpnp3ib29cv5a240ilron7fgn6.apps.googleusercontent.com",
    );
    GoogleSignInAccount account = await googleSignIn.authenticate();
    GoogleSignInAuthentication googleAuth = account.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentSnapshot<UserModel> docSnapshot = await userCollection
        .doc(userCredential.user!.uid)
        .get();
    return docSnapshot.data()!;
  }

  static Future<void> addEventToFavorites(String eventId) async{
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDoc = userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid);
        return userDoc.update({'favoriteEventsIds': FieldValue.arrayUnion([eventId])});
  }

  static Future<void> removeEventFromFavorites(String eventId) async{
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDoc = userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid);
        return userDoc.update({'favoriteEventsIds': FieldValue.arrayRemove([eventId])});
  }
}
