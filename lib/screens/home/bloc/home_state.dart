import 'package:flutter/material.dart';
import 'package:notes_app/data/note.dart';
import 'package:notes_app/repo/notes_repository.dart';

sealed class HomeState {
  HomeState({
    this.titleTEC,
    this.descTEC,
    this.repo,
    this.isEditNote = false,
    this.isDescEmpty = false,
    this.isTitleEmpty = false,
    this.note,
    this.errorMsg,
  });
  final TextEditingController? titleTEC;
  final TextEditingController? descTEC;
  final NotesRepository? repo;
  bool isEditNote;
  final Note? note;
  final bool isTitleEmpty;
  final bool isDescEmpty;
  String? errorMsg;
}

class IdleHomeState extends HomeState {
  IdleHomeState(
      {super.titleTEC,
      super.descTEC,
      super.repo,
      super.isEditNote,
      super.note,
      super.isTitleEmpty,
      super.isDescEmpty,
      super.errorMsg});

  IdleHomeState copyWith({
    TextEditingController? titleTEC,
    TextEditingController? descTEC,
    NotesRepository? repo,
    Note? note,
    bool isEditNote = false,
    bool isTitleEmpty = false,
    bool isDescEmpty = false,
    String? errorMsg,
  }) {
    return IdleHomeState(
      titleTEC: titleTEC ?? this.titleTEC,
      descTEC: descTEC ?? this.descTEC,
      repo: repo ?? this.repo,
      isEditNote: isEditNote,
      note: note ?? this.note,
      isTitleEmpty: isTitleEmpty,
      isDescEmpty: isDescEmpty,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

class AddEditNewNoteState extends HomeState {
  AddEditNewNoteState({
    super.titleTEC,
    super.descTEC,
    super.repo,
  });
}

class NoteAddedState extends HomeState {
  NoteAddedState({
    super.titleTEC,
    super.descTEC,
    super.repo,
  });
}

class NoteUpdatedState extends HomeState {
  NoteUpdatedState({
    super.titleTEC,
    super.descTEC,
    super.repo,
  });
}

class NoteDeletedState extends HomeState {
  NoteDeletedState({
    super.titleTEC,
    super.descTEC,
    super.repo,
  });
}

class AddEditCancelledState extends HomeState {
  AddEditCancelledState({
    super.titleTEC,
    super.descTEC,
    super.repo,
  });
}

class InvalidFieldsState extends HomeState {
  InvalidFieldsState({
    super.titleTEC,
    super.descTEC,
    super.repo,
  });
}

class LoggedOutState extends HomeState {
  LoggedOutState();
}

class FailedState extends HomeState {
  FailedState({super.errorMsg});
}
