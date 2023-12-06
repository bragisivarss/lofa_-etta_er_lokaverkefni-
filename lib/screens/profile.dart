import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dundaser/screens/auth.dart';
import 'package:dundaser/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<DocumentSnapshot> userDataFuture;
  late Future<int> userPostCount;

  Future<DocumentSnapshot> _fetchUserData() async {
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
    userDataFuture = _fetchUserData();
    userPostCount = _getUserPostCount();
  }

  @override
  Widget build(BuildContext context) {
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
          body: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 1,
                          color: const Color.fromARGB(100, 100, 100, 100)),
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
                    width: 10,
                  ),
                  Text(
                    userData['username'],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(2),
                    top: Radius.circular(6),
                  ),
                  border: Border.all(
                    width: 1,
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
                      return Text(
                        // ignore: unnecessary_brace_in_string_interps
                        ' You Have Made a Total of: ${postCount} reviews ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: FloatingActionButton.extended(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  shape: StadiumBorder(
                    side: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.primary),
                  ),
                  //extendedPadding: EdgeInsets.only(left: 10, right: 10),
                  onPressed: () {},
                  label: Text('Change Username',
                      style: TextStyle(
                          letterSpacing: 0.4,
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer)),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            onTap: (int index) {
              if (index == 0) {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (ctx) => const AuthScreen(),
                    ),
                    (route) => false);
              } else if (index == 1) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const MainScreen()));
              }
            },
            selectedLabelStyle:
                TextStyle(color: Theme.of(context).colorScheme.onBackground),
            unselectedLabelStyle:
                TextStyle(color: Theme.of(context).colorScheme.onBackground),
            selectedItemColor: Theme.of(context)
                .colorScheme
                .onBackground, // Color for selected item
            unselectedItemColor: Theme.of(context).colorScheme.onBackground,
            items: const [
              BottomNavigationBarItem(
                label: 'Exit',
                icon: Icon(Icons.exit_to_app),
              ),
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.verified_outlined),
              ),
            ],
          ),
        );
      },
    );
  }
}
