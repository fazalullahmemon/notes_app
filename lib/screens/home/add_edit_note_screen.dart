import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/screens/home/bloc/home_bloc.dart';
import 'package:notes_app/screens/home/bloc/home_event.dart';
import 'package:notes_app/screens/home/bloc/home_state.dart';
import 'package:notes_app/services/internet_service/internet_service_bloc.dart';
import 'package:notes_app/services/internet_service/internet_service_state.dart';
import 'package:notes_app/utils/constants.dart';
import 'package:notes_app/utils/frequent_functions.dart';
import 'package:notes_app/utils/relative_sizer.dart';
import 'package:notes_app/widgets/custom_elevated_button.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class AddEditNoteScreen extends StatefulWidget {
  const AddEditNoteScreen({super.key});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityDisconnected) {
          Fluttertoast.showToast(
              msg: noInternetMsg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        }
      },
      child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
        if (state is FailedState) {
          FrequentFunctions.showErrorDialog(state.errorMsg ?? "", context);
        }

        if (state is NoteAddedState) {
          Navigator.pop(context);
        }
        if (state is AddEditCancelledState) {
          Navigator.pop(context);
        }
        if (state is NoteUpdatedState) {
          Navigator.pop(context);
        }
        if (state is NoteDeletedState) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                context.read<HomeBloc>().add(CancelAddEditNoteEvent());
              },
            ),
            title: state.isEditNote
                ? const Text("Edit Note")
                : const Text("Add Note"),
            actions: [
              if (state.isEditNote)
                IconButton(
                  onPressed: () {
                    if (context.read<ConnectivityBloc>().state
                        is ConnectivityConnected) {
                      context.read<HomeBloc>().add(DeleteNoteEvent(state.note));
                    } else {
                      Fluttertoast.showToast(
                          msg: noInternetMsg,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM);
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
            ],
          ),
          body: Container(
            height: context.h,
            padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.03, vertical: context.h * 0.04),
            child: ListView(
              children: [
                CustomTextField(
                  controller: state.titleTEC,
                  label: "",
                  hint: "Title",
                  hasError: state.isTitleEmpty,
                  errorText: "Title is required",
                ),
                context.spaceV1,
                CustomTextField(
                  controller: state.descTEC,
                  maxLines: 20,
                  label: "",
                  hint: "Description",
                  errorText: "Description is required",
                  inputType: TextInputType.multiline,
                  hasError: state.isDescEmpty,
                ),
                context.spaceV4,
                CustomElevatedButton(
                    onTap: () {
                      if (context.read<ConnectivityBloc>().state
                          is ConnectivityConnected) {
                        if (state.isEditNote) {
                          context
                              .read<HomeBloc>()
                              .add(UpdateNoteEvent(state.note));
                        } else {
                          context.read<HomeBloc>().add(AddNoteEvent());
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: noInternetMsg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM);
                      }
                    },
                    text: state.isEditNote ? "Edit Note" : "Add Note")
              ],
            ),
          ),
        );
      }),
    );
  }
}
