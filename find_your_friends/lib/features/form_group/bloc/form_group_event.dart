part of 'form_group_bloc.dart';

enum GroupActions { create, update, delete }

@immutable
sealed class FormGroupEvent extends Equatable {}

class GroupNameChanged extends FormGroupEvent {
  final String groupName;
  GroupNameChanged(this.groupName);

  @override
  List<Object?> get props => [groupName];
}

class CreatorChanged extends FormGroupEvent {
  final String creator;
  CreatorChanged(this.creator);

  @override
  List<Object?> get props => [creator];
}

class MembersChanged extends FormGroupEvent {
  final List<String> members;
  MembersChanged(this.members);

  @override
  List<Object?> get props => [members];
}

class DescriptionChanged extends FormGroupEvent {
  final String description;
  DescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class FormGroupSubmitted extends FormGroupEvent {
  final GroupActions value;
  FormGroupSubmitted({required this.value});

  @override
  List<Object?> get props => [value];
}

class FormGroupSucceeded extends FormGroupEvent {
  FormGroupSucceeded();

  @override
  List<Object?> get props => [];
}
