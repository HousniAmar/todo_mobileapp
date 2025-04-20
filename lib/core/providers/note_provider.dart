import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/note.dart';
import '../repositories/note_repository.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepository();
});

final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>((ref) {
  final repository = ref.read(noteRepositoryProvider);
  return NotesNotifier(repository)..loadNotes();
});

class NotesNotifier extends StateNotifier<List<Note>> {
  final NoteRepository _repository;
  
  NotesNotifier(this._repository) : super([]);
  
  Future<void> loadNotes() async {
    state = await _repository.getAllNotes();
  }
  
  Future<void> addNote(Note note) async {
    await _repository.addNote(note);
    state = await _repository.getAllNotes();
  }
  
  Future<void> updateNote(Note note) async {
    await _repository.updateNote(note);
    state = await _repository.getAllNotes();
  }
  
  Future<void> deleteNote(String id) async {
    await _repository.deleteNote(id);
    state = await _repository.getAllNotes();
  }
}