import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/blocs/profile/profile_bloc.dart';
import 'package:tourist_guide/views/users_data/management/add_user.dart';
import 'package:tourist_guide/views/users_data/user_details.dart';
import 'package:tourist_guide/utils/widgets/app_bar.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pagesAppBar(context, "Users' Profiles", () {
        context.read<ProfileBloc>().add(LoadProfile(allowCache: false));
      }),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                        title: Text('${user.firstName} ${user.lastName}'),
                        subtitle: Text(user.email),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserDetailsPage(
                                      user: user,
                                      userIndex: index,
                                      onUpdate: (user) => context
                                          .read<ProfileBloc>()
                                          .add(UpdateProfile(user)),
                                      onDelete: (user) => context
                                          .read<ProfileBloc>()
                                          .add(DeleteProfile(user.id)),
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete User'),
                                    content: const Text(
                                        'Are you sure you want to delete this user?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<ProfileBloc>()
                                              .add(DeleteProfile(user.id));
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailsPage(
                                user: user,
                                userIndex: index,
                                onUpdate: (user) => context
                                    .read<ProfileBloc>()
                                    .add(UpdateProfile(user)),
                                onDelete: (user) => context
                                    .read<ProfileBloc>()
                                    .add(DeleteProfile(user.id)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          }
          if (state is ProfileError) {
            return Center(child: Text(state.errorMsg));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserPage(
                onCreate: (newUser) async {
                  context.read<ProfileBloc>().add(CreateProfile(newUser));
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
