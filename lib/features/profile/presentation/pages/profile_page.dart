// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_platform/features/auth/domain/entities/app_user.dart';
import 'package:social_platform/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_platform/features/profile/presentation/components/bio_box.dart';
import 'package:social_platform/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:social_platform/features/profile/presentation/cubit/profile_states.dart';
import 'package:social_platform/features/profile/presentation/pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //cubits
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  //current user
  late AppUser? currentUser = authCubit.currentUser;

  //on startup
  @override
  void initState() {
    super.initState();

    //load user profile data
    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      //loaded
      if (state is ProfileLoaded) {
        //get the loaded user
        final user = state.profileUser;

        //SCAFFOLD
        return Scaffold(
          appBar: AppBar(
            title: Text(user.name),
            foregroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              //edit profile button
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        user: user,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.settings,
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                //PROFILE PIC
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(120),
                  ),
                  height: 120,
                  width: 120,
                  child: Center(
                    child: Icon(
                      Icons.person_2,
                      size: 70,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                //EMAIL
                Text(
                  user.email,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),

                SizedBox(height: 25),

                //BIO
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text(
                        "Bio",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
                BioBox(
                  text: user.bio,
                ),

                SizedBox(height: 25),

                //POSTS

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text(
                        "Posts : ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }

      //loading...
      else if (state is ProfileLoading) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: Text("No Profile found"),
          ),
        );
      }
    });
  }
}
