import 'package:equatable/equatable.dart';
import 'package:find_your_friends/features/authentication/authentication_repository.dart';
import 'package:find_your_friends/features/database/database_repository.dart';
import 'package:find_your_friends/models/group_model.dart';
import 'package:find_your_friends/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_group_event.dart';
part 'form_group_state.dart';

class FormGroupBloc extends Bloc<FormGroupEvent, FormGroupValidate> {
  final AuthenticationRepository _authenticationRepository;
  final DatabaseRepository _databaseRepository;

  FormGroupBloc(this._authenticationRepository, this._databaseRepository)
      : super(FormGroupValidate(
          groupName: "",
          creator: "",
          creatorId: "",
          members: const [],
          description: "",
          isCreatorValid: false,
          isDescriptionValid: false,
          isFormValid: false,
          isFormValidateFailed: false,
          isGroupNameValid: false,
          isLoading: false,
          isMembersValid: false,
          isFormSuccessful: false,
        )) {
    on<GroupNameChanged>(_onGroupNameChanged);
    on<CreatorChanged>(_onCreatorChanged);
    on<MembersChanged>(_onMembersChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<FormGroupSubmitted>(_onFormSubmitted);
    on<FormGroupSucceeded>(_onFormSucceeded);
  }

  bool _isGroupNameValid(String groupName) {
    return groupName.length > 3 ? true : false;
  }

  bool _isCreatorValid(String creator) {
    return true;
  }

  bool _isMembersValid(List<String> members) {
    return true;
  }

  bool _isDescriptionValid(String description) {
    return true;
  }

  _onGroupNameChanged(
      GroupNameChanged event, Emitter<FormGroupValidate> emit) async {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      groupName: event.groupName,
      isGroupNameValid: _isGroupNameValid(event.groupName),
    ));
  }

  _onCreatorChanged(
      CreatorChanged event, Emitter<FormGroupValidate> emit) async {
    UserModel user = await _authenticationRepository.getCurrentUser().first;
    String? userName = await _authenticationRepository.retrieveUserName(user);
    emit(state.copyWith(
        isFormSuccessful: false,
        isFormValid: false,
        isFormValidateFailed: false,
        errorMessage: "",
        creatorId: event.creator,
        creator: userName,
        isCreatorValid: _isCreatorValid(event.creator)));
  }

  _onMembersChanged(
      MembersChanged event, Emitter<FormGroupValidate> emit) async {
    emit(state.copyWith(
        isFormSuccessful: false,
        isFormValid: false,
        isFormValidateFailed: false,
        errorMessage: "",
        members: event.members,
        isMembersValid: _isMembersValid(event.members)));
  }

  _onDescriptionChanged(
      DescriptionChanged event, Emitter<FormGroupValidate> emit) async {
    emit(state.copyWith(
        isFormSuccessful: false,
        isFormValid: false,
        isFormValidateFailed: false,
        errorMessage: "",
        description: event.description,
        isDescriptionValid: _isDescriptionValid(event.description)));
  }

  _onFormSubmitted(
      FormGroupSubmitted event, Emitter<FormGroupValidate> emit) async {
    GroupModel group = GroupModel(
      groupName: state.groupName,
      creator: state.creator,
      creatorId: state.creatorId,
      members: state.members,
      description: state.description,
    );
    UserModel user = await _authenticationRepository.getCurrentUser().first;
    if (event.value == GroupActions.create) {
      await _createGroup(event, emit, group, user);
    } else if (event.value == GroupActions.update) {
      await _updateGroup(event, emit, group);
    } else if (event.value == GroupActions.delete) {
      await _deleteGroup(event, emit, group);
    }
  }

  _onFormSucceeded(FormGroupSucceeded event, Emitter<FormGroupValidate> emit) {
    emit(state.copyWith(isFormSuccessful: true));
  }

  bool _formValid(FormGroupValidate state) {
    return _isCreatorValid(state.creator) &&
        _isDescriptionValid(state.description) &&
        _isGroupNameValid(state.groupName) &&
        _isMembersValid(state.members);
  }

  _createGroup(FormGroupSubmitted event, Emitter<FormGroupValidate> emit,
      GroupModel group, UserModel user) async {
    // TODO: Somehow, when trying to see if state.isFormValid, this yields false,
    // even though in the FormBloc that exact code works and yields true... check for errors
    print('state form valid: ${state.isFormValid}');
    if (_formValid(state)) {
      print('Form valid!!!');
      try {
        await _databaseRepository.createNewGroup(user, group);
        emit(state.copyWith(
            isLoading: false, errorMessage: "", isFormValid: true));
      } on FirebaseException catch (e) {
        emit(state.copyWith(
            isLoading: false, errorMessage: e.message, isFormValid: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  _updateGroup(FormGroupSubmitted event, Emitter<FormGroupValidate> emit,
      GroupModel group) {
    throw UnimplementedError("Group Updating is not yet implemented");
  }

  _deleteGroup(FormGroupSubmitted event, Emitter<FormGroupValidate> emit,
      GroupModel group) {
    throw UnimplementedError("Group Deletion is not yet implemented");
  }
}
