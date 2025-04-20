import 'package:hive/hive.dart';
import '../models/note.dart';

class NoteRepository {
  static const _boxName = 'notes';

  Future<Box<Note>> get _box async => await Hive.openBox<Note>(_boxName);

  Future<List<Note>> getAllNotes() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<void> addNote(Note note) async {
    final box = await _box;
    await box.put(note.id, note);
  }

  Future<void> updateNote(Note note) async {
    final box = await _box;
    await box.put(note.id, note);
  }

  Future<void> deleteNote(String id) async {
    final box = await _box;
    await box.delete(id);
  }
}