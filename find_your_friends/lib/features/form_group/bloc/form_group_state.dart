part of 'form_group_bloc.dart';

@immutable
sealed class FormGroupState extends Equatable {}

final class FormGroupCreationInitial extends FormGroupState {
  @override
  List<Object?> get props => [];
}

class FormGroupValidate extends FormGroupState {
  FormGroupValidate({
    required this.groupName,
    required this.creator,
    required this.members,
    required this.description,
    required this.isGroupNameValid,
    required this.isCreatorValid,
    required this.isMembersValid,
    required this.isDescriptionValid,
    required this.isFormValid,
    required this.isFormValidateFailed,
    this.isFormSuccessful = false,
    required this.isLoading,
    this.errorMessage = "",
  });
  final String groupName;
  final String creator;
  final List<String> members;
  final String description;
  final bool isGroupNameValid;
  final bool isCreatorValid;
  final bool isMembersValid;
  final bool isDescriptionValid;
  final bool isFormValid;
  final bool isFormValidateFailed;
  final bool isFormSuccessful;
  final bool isLoading;
  final String errorMessage;

  FormGroupValidate copyWith({
    String? groupName,
    String? creator,
    List<String>? members,
    String? description,
    bool? isGroupNameValid,
    bool? isCreatorValid,
    bool? isMembersValid,
    bool? isDescriptionValid,
    bool? isFormValid,
    bool? isFormValidateFailed,
    bool? isFormSuccessful,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FormGroupValidate(
      groupName: groupName ?? this.groupName,
      creator: creator ?? this.creator,
      members: members ?? this.members,
      description: description ?? this.description,
      isGroupNameValid: isGroupNameValid ?? this.isGroupNameValid,
      isCreatorValid: isCreatorValid ?? this.isCreatorValid,
      isMembersValid: isMembersValid ?? this.isMembersValid,
      isDescriptionValid: isDescriptionValid ?? this.isDescriptionValid,
      isFormValid: isFormValid ?? this.isFormValid,
      isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
      isFormSuccessful: isFormSuccessful ?? this.isFormSuccessful,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [groupName, creator, members, description];
}
