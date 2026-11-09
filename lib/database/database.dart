import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Tarefas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get titulo => text().withLength(min: 6, max: 30)();
  TextColumn get descricao => text()();
}

@DriftDatabase(tables: [Tarefas])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: "todos_db",
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Stream<List<Tarefa>> getAllTasks() => select(tarefas).watch();

  Future<Tarefa> getById(int id) {
    return (select(tarefas)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int> inserirTarefas(String titulo, String descricao) {
    return into(tarefas)
        .insert(TarefasCompanion.insert(titulo: titulo, descricao: descricao));
  }

  Future<int> atualizarTarefas(
    int id,
    String? newTitle,
    String? newDescription,
  ) {
  
    return (update(tarefas)..where((t) => t.id.equals(id))).write(TarefasCompanion(
      titulo: newTitle != null ? Value(newTitle.toString()) : const Value.absent(),
      descricao: newDescription != null ? Value(newDescription.toString()) : const Value.absent(),
    ));
  }

  Future<int> deletarTarefa(int id) {
    return (delete(tarefas)..where((t) => t.id.equals(id))).go();
  }
}
