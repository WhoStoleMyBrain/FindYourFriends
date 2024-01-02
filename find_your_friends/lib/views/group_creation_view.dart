import 'package:find_your_friends/features/authentication/authentication_repository.dart';
import 'package:find_your_friends/features/form_group/bloc/form_group_bloc.dart';
import 'package:find_your_friends/models/user_model.dart';
import 'package:find_your_friends/utils/constants.dart';
import 'package:find_your_friends/views/group_overview_view.dart';
import 'package:find_your_friends/views/home_view.dart';
import 'package:find_your_friends/views/sign_in_view.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));

class GroupCreationView extends StatelessWidget {
  const GroupCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<FormGroupBloc, FormGroupValidate>(
          listener: (context, state) async {
            // print(state);
            if (state.errorMessage.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(errorMessage: state.errorMessage),
              );
            } else if (state.isFormSuccessful) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => GroupOverviewView(),
                  ),
                  (route) => false);
            } else if (state.isFormValid && !state.isLoading) {
              context.read<FormGroupBloc>().add(FormGroupSucceeded());
            } else if (state.isFormValidateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(Constants.textFixIssues)));
            }
            if (state.creator == "" && !state.isCreatorValid) {
              if (kDebugMode) {
                //TODO: Refactor usage of build context across async gaps
                print(
                    "Using build context across async here, since we need the user once at the beginning of the form... refactor but not sure how");
              }
              UserModel user =
                  await AuthenticationRepositoryImpl().getCurrentUser().first;
              context.read<FormGroupBloc>().add(CreatorChanged(user.uid!));
            }
          },
        )
      ],
      child: Scaffold(
        backgroundColor: Constants.kPrimaryColor,
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                Constants.textCreateGroup,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Constants.kBlackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.02),
              ),
              const _GroupNameField(),
              SizedBox(
                height: size.height * 0.01,
              ),
              const _GroupDescriptionField(),
              SizedBox(
                height: size.height * 0.01,
              ),
              const _GroupMembersField(),
              SizedBox(
                height: size.height * 0.01,
              ),
              const _SubmitButton(),
            ],
          ),
        )),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ),
                (route) => false);
          },
          child: const Text('Home'),
        ),
      ),
    );
  }
}

class _GroupNameField extends StatelessWidget {
  const _GroupNameField();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormGroupBloc, FormGroupValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: false,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText:
                  '''Group Name should be at least 3 characters long!''',
              helperMaxLines: 2,
              labelText: 'Group Name',
              errorMaxLines: 2,
              errorText: !state.isGroupNameValid
                  ? '''Group Name should be at least 3 characters long!'''
                  : null,
            ),
            onChanged: (value) {
              context.read<FormGroupBloc>().add(GroupNameChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _GroupDescriptionField extends StatelessWidget {
  const _GroupDescriptionField();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormGroupBloc, FormGroupValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: false,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText: '''Enter Group Description''',
              helperMaxLines: 2,
              labelText: 'Group Description',
              errorMaxLines: 2,
              errorText: !state.isDescriptionValid
                  ? '''Group Description is not valid!'''
                  : null,
            ),
            onChanged: (value) {
              context.read<FormGroupBloc>().add(DescriptionChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _GroupMembersField extends StatelessWidget {
  const _GroupMembersField();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormGroupBloc, FormGroupValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: false,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText:
                  '''Enter Group Members from your friendlist or via email''',
              helperMaxLines: 2,
              labelText: 'Group Members',
              errorMaxLines: 2,
              errorText: !state.isMembersValid
                  ? '''Group Members can be empty, however still faced an unknown error. Please contact the support!'''
                  : null,
            ),
            onChanged: (value) {
              if (kDebugMode) {
                print("Need to implement other users adding");
              }
              context.read<FormGroupBloc>().add(MembersChanged([value]));
            },
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormGroupBloc, FormGroupValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: size.width * 0.8,
                child: OutlinedButton(
                  onPressed: !state.isFormValid
                      ? () => context
                          .read<FormGroupBloc>()
                          .add(FormGroupSubmitted(value: GroupActions.create))
                      : null,
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Constants.kPrimaryColor),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Constants.kBlackColor),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none)),
                  child: const Text(Constants.textCreateGroupButton),
                ),
              );
      },
    );
  }
}
