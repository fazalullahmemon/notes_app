import 'package:notes_app/data/note.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class AddNoteScreenEvent extends HomeEvent {
  AddNoteScreenEvent();
}

class EditNoteScreenEvent extends HomeEvent {
  final Note? note;
  EditNoteScreenEvent(this.note);
}

class AddNoteEvent extends HomeEvent {
  AddNoteEvent();
}

class CancelAddEditNoteEvent extends HomeEvent {
  CancelAddEditNoteEvent();
}

class UpdateNoteEvent extends HomeEvent {
  final Note? note;

  UpdateNoteEvent(this.note);
}

class DeleteNoteEvent extends HomeEvent {
  final Note? note;

  DeleteNoteEvent(this.note);
}

class LogoutRequested extends HomeEvent {
  LogoutRequested();
}
