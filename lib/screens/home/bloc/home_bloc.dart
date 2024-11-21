import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/home/bloc/home_event.dart';
import 'package:notes_app/screens/home/bloc/home_state.dart';
import 'package:notes_app/repo/notes_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(IdleHomeState(
            repo: NotesRepository(),
            titleTEC: TextEditingController(),
            descTEC: TextEditingController())) {
    on<HomeEvent>((event, emit) {
      return switch (event) {
        AddNoteScreenEvent() => _addNoteScreen(event, emit),
        DeleteNoteEvent() => _deleteNote(event, emit),
        AddNoteEvent() => _addUpdateNote(event, emit),
        EditNoteScreenEvent() => _addNoteScreen(event, emit),
        UpdateNoteEvent() => _addUpdateNote(event, emit),
        CancelAddEditNoteEvent() => _cancelAddEditNote(event, emit),
        LogoutRequested() => _logout(event, emit),
      };
    });
  }
  _addNoteScreen(HomeEvent event, Emitter<HomeState> emit) {
    final state = this.state;

    if (state is! IdleHomeState) {
      return;
    }
    if (event is AddNoteScreenEvent) {
      emit(AddEditNewNoteState());
      emit(state.copyWith(isEditNote: false));
    }
    if (event is EditNoteScreenEvent) {
      emit(AddEditNewNoteState());

      emit(state.copyWith(
          note: event.note,
          isEditNote: true,
          titleTEC: TextEditingController(text: event.note?.title ?? ""),
          descTEC: TextEditingController(text: event.note?.body ?? "")));
    }
  }

  _addUpdateNote(HomeEvent event, Emitter<HomeState> emit) async {
    final state = this.state;

    if (state is! IdleHomeState) {
      return;
    }
    if (state.titleTEC!.text.isEmpty || state.descTEC!.text.isEmpty) {
      emit(InvalidFieldsState());
      emit(state.copyWith(
        isTitleEmpty: state.titleTEC!.text.isEmpty,
        isDescEmpty: state.descTEC!.text.isEmpty,
      ));
      return;
    }
    if (event is AddNoteEvent) {
      final res = await state.repo!
          .createNote(title: state.titleTEC!.text, body: state.descTEC!.text);
      if (res) {
        state.titleTEC?.clear();
        state.descTEC?.clear();
        state.isEditNote = false;
        emit(NoteAddedState());
        emit(state);
      } else {
        emit(FailedState(errorMsg: "Failed to Add note, Please try again"));
        emit(state);
      }
    }
    if (event is UpdateNoteEvent) {
      final res = await state.repo!.updateNote(
          noteId: event.note!.id!,
          title: state.titleTEC!.text,
          body: state.descTEC!.text);
      if (res) {
        state.titleTEC?.clear();
        state.descTEC?.clear();
        state.isEditNote = false;
        emit(NoteUpdatedState());
        emit(state);
      } else {
        emit(FailedState(errorMsg: "Failed to Update note, Please try again"));
        emit(state);
      }
    }
  }

  _deleteNote(HomeEvent event, Emitter<HomeState> emit) async {
    final state = this.state;

    if (state is! IdleHomeState) {
      return;
    }
    if (event is! DeleteNoteEvent) {
      return;
    }
    final res = await state.repo!.deleteNote(noteId: event.note?.id ?? "");

    if (res) {
      state.titleTEC?.clear();
      state.descTEC?.clear();
      state.isEditNote = false;

      emit(NoteDeletedState());
      emit(state);
    } else {
      emit(FailedState(errorMsg: "Failed to Delete note, Please try again"));
      emit(state);
    }
  }

  _cancelAddEditNote(HomeEvent event, Emitter<HomeState> emit) {
    final state = this.state;

    if (state is! IdleHomeState) {
      return;
    }

    if (event is! CancelAddEditNoteEvent) {
      return;
    }
    state.titleTEC?.clear();
    state.descTEC?.clear();
    state.isEditNote = false;

    emit(AddEditCancelledState());
    emit(state);
  }

  _logout(HomeEvent event, Emitter<HomeState> emit) async {
    final state = this.state;

    if (state is! IdleHomeState) {
      return;
    }
    await FirebaseAuth.instance.signOut();

    if (event is LogoutRequested) {
      emit(LoggedOutState());
      emit(state);
    }
  }
}
