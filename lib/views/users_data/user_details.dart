import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/blocs/profile/profile_bloc.dart';
import 'package:tourist_guide/models/user.dart';
import 'package:tourist_guide/views/users_data/management/change_avatar.dart';
import 'package:tourist_guide/views/users_data/management/edit_user.dart';

// ignore: must_be_immutable
class UserDetailsPage extends StatelessWidget {
  User user;
  int userIndex;
  final Function(User) onUpdate;
  final Function(User) onDelete;

  UserDetailsPage({
    super.key,
    required this.user,
    required this.onUpdate,
    required this.onDelete,
    required this.userIndex,
  });

  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                try {
                  await onDelete(user);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete user: $e')),
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            user = state.users[userIndex];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(state.users[userIndex].avatar),
                          radius: 70,
                        ),
                        Positioned(
                          bottom: 25,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AvatarsList(
                                      onAvatarUpdate: (avatarUrl) {
                                        context
                                            .read<ProfileBloc>()
                                            .add(UpdateAvatar(user, avatarUrl));
                                      },
                                    ),
                                  ));
                            },
                            child: Container(
                              color: Colors.black54,
                              child: Row(
                                children: [
                                  Text(
                                    'Change Avatar',
                                    style:
                                        TextStyle(color: Colors.teal.shade50),
                                  ),
                                  const Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: Colors.teal,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUserPage(
                                user: user,
                                onUpdate: onUpdate,
                              ),
                            ),
                          );
                        },
                        child: const Text("Edit Profile"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.person),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "First Name:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Text(' ${user.firstName}'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.person),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Last Name:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Text(' ${user.lastName}'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.email_rounded),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Email:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Text(' ${user.email}'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
          return Container();
        },
      ),
    );
  }
}
