import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:notes/notes/notes.dart';

part 'note_actor_state.dart';

@injectable
class NoteActorCubit extends Cubit<NoteActorState> {
  NoteActorCubit(this._noteRepo) : super(const NoteActorState());

  final NoteRepo _noteRepo;

  Future<void> delete(NoteItem note) async {
    emit(state.copyWith(status: NoteActorStatus.loading));
    final failureOrSuccess = await _noteRepo.delete(note);
    emit(
      failureOrSuccess.fold(
        (error) => state.copyWith(
          status: NoteActorStatus.failure,
          errorCode: error,
        ),
        (_) => state.copyWith(status: NoteActorStatus.success),
      ),
    );
  }
}
