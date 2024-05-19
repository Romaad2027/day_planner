import 'package:day_planner/common/widgets/flushbar.dart';
import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/auth/bloc/auth_bloc.dart';
import 'package:day_planner/features/profile/bloc/profile_bloc.dart';
import 'package:day_planner/features/profile/bloc/profile_event.dart';
import 'package:day_planner/features/profile/bloc/profile_state.dart';
import 'package:day_planner/features/profile/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  bool _isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: _profileListener,
        builder: (context, state) {
          final userProfile = state.userProfile;
          _nameController.text = userProfile!.name;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: context.textStyle(TextScale.titleLarge),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isEditMode = !_isEditMode;
                        });
                      },
                      child: _isEditMode ? const Text('Cancel') : const Text('Edit'),
                    )
                  ],
                ),
                const SizedBox(height: 32),
                ProfileTextField(
                  controller: _nameController,
                  hintText: 'Name',
                  isEditMode: _isEditMode,
                ),
                const SizedBox(height: 16),
                ProfileTextField(
                  initialValue: userProfile.phoneNumber,
                  hintText: 'Phone Number',
                  isEditMode: false,
                ),
                const SizedBox(height: 64),
                if (_isEditMode)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: FilledButton(
                        onPressed: state.profileStatus.isLoading
                            ? null
                            : () {
                                context.read<ProfileBloc>().add(UpdateUser(name: _nameController.text));
                              },
                        child: state.profileStatus.isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : const Text('Save'),
                      ),
                    ),
                  ),
                Center(
                  child: FilledButton(
                    onPressed: () => context.read<AuthBloc>().add(const LogOut()),
                    child: const Text('Log out'),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _profileListener(BuildContext context, ProfileState state) {
    if (state.profileStatus.isSuccess) {
      setState(() {
        _isEditMode = false;
      });
    }
    if (state.profileStatus.isError) {
      showSnackBar(context, status: FlushbarStatus.error);
    }
  }
}
