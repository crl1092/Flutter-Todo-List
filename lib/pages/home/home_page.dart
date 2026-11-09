import 'package:flutter/material.dart';
import 'package:task_manager/database/database.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/pages/addTask/add_task_page.dart';
import 'package:task_manager/pages/updateTask/update_task_page.dart';

class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Gerenciador de Tarefas"),
            centerTitle: true,
          ),
          body: StreamBuilder<List<Tarefa?>>(
            stream: db.getAllTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Ocorreu um erro: ${snapshot.error}"),
                );
              }

              final tasks = snapshot.data ?? [];
              if (tasks.isEmpty) {
                return const Center(child: Text("Nenhuma tarefa encontrada"));
              }
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    child: ListTile(
                      title: Text(task!.titulo),
                      subtitle: Text(task.descricao),
                      trailing: InkWell(
                        child: Icon(Icons.delete, color: Colors.red),
                        onTap: () async {
                          await db.deletarTarefa(task.id);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (cx) =>
                                UpdateTaskPage(tarefa: task, id: task.id),
                          ),
                        );
                      },
                      style: ListTileStyle.list,
                    ),
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (b) => const AddTaskPage()),
              );
            },
            label: Row(
              spacing: 3,
              children: [Icon(Icons.add), Text("Adicionar Tarefas")],
            ),
          ),
        ),
      ),
    );
  }
}
