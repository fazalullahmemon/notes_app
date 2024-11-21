import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/common_imports.dart';
import 'package:notes_app/data/note.dart';
import 'package:notes_app/screens/home/add_edit_note_screen.dart';
import 'package:notes_app/screens/home/bloc/home_bloc.dart';
import 'package:notes_app/screens/home/bloc/home_event.dart';
import 'package:notes_app/screens/home/bloc/home_state.dart';
import 'package:notes_app/screens/sign_in/sign_in_screen.dart';
import 'package:notes_app/services/internet_service/internet_service_bloc.dart';
import 'package:notes_app/services/internet_service/internet_service_state.dart';
import 'package:notes_app/utils/frequent_functions.dart';
import 'package:notes_app/widgets/custom_elevated_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          if (state is LoggedOutState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false,
            );
          }

          if (state is FailedState) {
            FrequentFunctions.showErrorDialog(state.errorMsg ?? "", context);
          }

          if (state is AddEditNewNoteState) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddEditNoteScreen(),
            ));
          }
          if (state is NoteDeletedState) {
            Fluttertoast.showToast(
              msg: "Note Deleted",
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.shade700,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }, builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<HomeBloc>().add(AddNoteScreenEvent());
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              centerTitle: false,
              title: const Text("Notes"),
              actions: [
                IconButton(
                    onPressed: () async {
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirm Logout"),
                          content:
                              const Text("Are you sure you want to log out?"),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(false), // Cancel
                              child: const Text("Cancel"),
                            ),
                            CustomElevatedButton(
                              width: 100,
                              onTap: () =>
                                  Navigator.of(context).pop(true), // Confirm
                              text: "Logout",
                            ),
                          ],
                        ),
                      );
                      if (shouldLogout == true) {
                        context.read<HomeBloc>().add(LogoutRequested());
                      }
                    },
                    icon: const Icon(Icons.power_settings_new))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.03, vertical: context.h * 0.02),
              child: StreamBuilder<List<Note>>(
                stream: state.repo!.getNotes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }

                  final notes = snapshot.data ?? [];
                  if (notes.isEmpty) {
                    return const Center(
                      child: Text("Start Adding Notes"),
                    );
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 16 / 9,
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<HomeBloc>()
                              .add(EditNoteScreenEvent(note));
                        },
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black26),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Text(note.title ?? ""),
                          subtitle: SizedBox(
                            height: context.h * 0.08,
                            child: Text(
                              note.body ?? "",
                              // maxLines: 4,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );

          // Scaffold(
          //   appBar: AppBar(
          //     title: Text("Notes"),
          //   ),
          //   floatingActionButton: FloatingActionButton(
          //     onPressed: () {
          //       context.read<HomeBloc>().add(AddNoteScreenEvent());
          //     },
          //     child: const Icon(Icons.add),
          //   ),
          //   body: const Center(
          //     child: Text("Start Adding Notes"),
          //   ),
          // );
        }));
  }
}
