/*
PROFILE REPOSITORY

- It is responsible for handling all the CRUD operations for the profile feature.
*/

import 'package:social_platform/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> fetchUserProfile(String uid);
  Future<void> updateProfile(ProfileUser updatedProfile);
}
