import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'form_validation_event.dart';
part 'form_validation_state.dart';

class FormValidationBloc extends Bloc<FormValidationEvent, FormValidationState> {
  FormValidationBloc() : super(FormValidationInitial()) {
    on<FormValidationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
