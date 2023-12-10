import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dundaser/models/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dundaser/widgets/change_username.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _usernameController = TextEditingController();
  late Future<DocumentSnapshot> userDataFuture;
  late Future<int> userPostCount;
  // ignore: unused_field
  late String _username;

  void updateUsername(String newUsername) {
    setState(() {
      _username = newUsername;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<DocumentSnapshot> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser!;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
  }

  final user = FirebaseAuth.instance.currentUser!;

  Future<int> _getUserPostCount() async {
    QuerySnapshot<Map<String, dynamic>> userPosts = await FirebaseFirestore
        .instance
        .collection('drinks')
        .where('userId', isEqualTo: user.uid)
        .get();

    return userPosts.size;
  }

  @override
  void initState() {
    super.initState();
    userDataFuture = _getUserData();
    userPostCount = _getUserPostCount();
    _usernameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _usernameController = TextEditingController();
    return FutureBuilder(
      future: userDataFuture,
      builder: (ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (userSnapshot.hasError) {
          return const Center(
            child: Text('Something Went Wrong Try Again Later'),
          );
        }

        var userData = userSnapshot.data!.data() as Map<String, dynamic>;

        String userImage = userData['image_url'];

        // ignore: unused_local_variable
        String username = userData['username'];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          appBar: AppBar(
            elevation: 5,
            shadowColor: const Color.fromARGB(116, 255, 13, 13),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            centerTitle: true,
            title: Text(
              'Profile',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
          ),
          body: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 250,
                    width: 230,
                    decoration: ShapeDecoration(
                      shape: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                          ) +
                          Border.all(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            width: 2,
                          ) +
                          Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 1,
                          ),
                    ),
                    child: Image.network(
                      userImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, left: 62, right: 62, bottom: 40),
                    child: Row(
                      children: [
                        const SizedBox(width: 40),
                        Center(
                            child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              elevation: 4,
                              shadowColor:
                                  Theme.of(context).colorScheme.surfaceTint,
                              shape: StadiumBorder(
                                side: BorderSide(
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          label: Text(
                            'Change Profile Photo',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.camera_alt),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        width: 10,
                        color: const Color.fromARGB(100, 100, 100, 100),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(top: 25.5, bottom: 25.5),
                      height: 200,
                      width: 300,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(colors: [
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          Theme.of(context).colorScheme.primary.withOpacity(0.2)
                        ]),
                        shape: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.5,
                            ) +
                            Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 1,
                            ) +
                            Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 0.5,
                            ),
                      ),
                      child: Column(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(100, 100, 100, 100)),
                            ),
                            child: Text(
                              ' Current Username: ',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            username,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                          ),
                          const SizedBox(height: 18),
                          Center(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  shadowColor:
                                      Theme.of(context).colorScheme.surfaceTint,
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                        width: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              label: Text(
                                'Change Username',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return UsernameChangeDialog(
                                          currentUsername: username,
                                          onUpdate: updateUsername);
                                    });
                              },
                              icon: const Icon(Icons.threesixty_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        width: 10,
                        color: const Color.fromARGB(100, 100, 100, 100),
                      ),
                    ),
                    child: FutureBuilder(
                      future: userPostCount,
                      builder: (ctx, postSnapshot) {
                        if (postSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (postSnapshot.hasError) {
                          return Text(
                              'Error fetching post count: ${postSnapshot.error}');
                        } else {
                          int postCount = postSnapshot.data!;
                          return Opacity(
                            opacity: 0.8,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              height: 50,
                              width: 300,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2)
                                ]),
                                shape: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 1.5,
                                    ) +
                                    Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      width: 1,
                                    ) +
                                    Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 0.5,
                                    ),
                              ),
                              child: Text(
                                // ignore: unnecessary_brace_in_string_interps
                                'Total Reviews: ${postCount}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: const BottomNavigation(),
        );
      },
    );
  }
}
