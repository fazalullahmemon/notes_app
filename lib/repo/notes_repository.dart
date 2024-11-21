import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/data/note.dart';

class NotesRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String notesCollectionName = "Notes";

  /// Creates a new note for the authenticated user
  Future<bool> createNote({required String title, required String body}) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return false;
      }
      var note = Note(
              userId: user.uid,
              title: title,
              body: body,
              createdAt: DateTime.now().toString(),
              updatedAt: DateTime.now().toString())
          .toJson();
      note.remove("id");

      await _firestore.collection(notesCollectionName).add(note);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Fetches all notes for the authenticated user, ordered by creation date
  Stream<List<Note>> getNotes() {
    try {
      final user = _auth.currentUser;

      return _firestore
          .collection(notesCollectionName)
          .where('userId', isEqualTo: user?.uid)
          .orderBy('updatedAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                var docData = doc.data()..["id"] = doc.id;
                print(docData);
                return Note.fromJson(docData);
              }).toList());
    } catch (e) {
      rethrow;
    }
  }

  /// Updates an existing note identified by noteId
  Future<bool> updateNote(
      {required String noteId,
      required String title,
      required String body}) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return false;
      }

      await _firestore.collection(notesCollectionName).doc(noteId).update({
        "id": noteId,
        "title": title,
        "body": body,
        "updatedAt": DateTime.now().toString(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Deletes a note identified by noteId
  Future<bool> deleteNote({required String noteId}) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return false;
      }

      await _firestore.collection(notesCollectionName).doc(noteId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
