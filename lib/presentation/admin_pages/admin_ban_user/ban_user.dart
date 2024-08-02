// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:blog_app/core/const.dart';
import 'package:blog_app/core/models/usermodel/user_model.dart';
import 'package:blog_app/hive_database/hive_database.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BanUserAccount extends StatelessWidget {
  const BanUserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarbackground,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: appbaritemcolor,
          ),
        ),
        title: Text(
          'Users',
          style: GoogleFonts.cabin(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: appbaritemcolor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Listview users
            ValueListenableBuilder(
              valueListenable: Hive.box<UserModel>('userBox').listenable(),
              builder: (context, Box<UserModel> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text('No users available'),
                  );
                }
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        final user = box.getAt(index) as UserModel;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: colorList[index % colorList.length],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Text(
                                      user.username[0],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.username,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          user.email,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  BanUserWidget(user: user),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BanUserWidget extends StatelessWidget {
  final UserModel user;

  const BanUserWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> _isBannedNotifier = ValueNotifier(user.isBanned);

    return Row(
      children: [
        Container(
          height: 20,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              "Ban",
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
        const SizedBox(width: 5),
        ValueListenableBuilder<bool>(
          valueListenable: _isBannedNotifier,
          builder: (context, isBanned, _) {
            return Checkbox(
              onChanged: (bool? value) async {
                if (value != null) {
                  if (value) {
                    await HiveDatabase().banUser(user.id);
                  } else {
                    await HiveDatabase().unbanUser(user.id);
                  }
                  _isBannedNotifier.value = value;
                }
              },
              value: isBanned,
            );
          },
        ),
      ],
    );
  }
}
