import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';

class AddTaskPage extends StatefulWidget {
  const new({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  Future<void> salvarTarefa() async {
    String tituloTarefa = _tituloController.text;
    String descricaoTarefa = _descricaoController.text;

    if (tituloTarefa.length >= 6) {
      await db.inserirTarefas(tituloTarefa, descricaoTarefa);
    } else {
      AlertDialog(
        title: Text("Atenção!"),
        content: Text("O titulo não pode ter menos de 6 letras!"),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Adicionar Tarefas"), centerTitle: true),
          body: Column(
            spacing: 10,
            children: [
              TextField(
                controller: _tituloController,
                decoration: InputDecoration(
                  label: Text("Titulo"),
                  border: OutlineInputBorder(),
                  prefix: Icon(Icons.title),
                ),
              ),
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  label: Text("Descrição"),
                  border: OutlineInputBorder(),
                  prefix: Icon(Icons.description),
                ),
              ),
              ElevatedButton(
                onPressed: salvarTarefa,
                child: Text("Salvar tarefa"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
