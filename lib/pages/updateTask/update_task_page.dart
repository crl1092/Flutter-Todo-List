import 'package:flutter/material.dart';
import 'package:task_manager/database/database.dart';
import 'package:task_manager/main.dart';

class UpdateTaskPage extends StatefulWidget {
  final Tarefa tarefa;
  final int id;
  const new({super.key, required this.tarefa, required this.id});

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;

  @override
  void initState() {
    super.initState();

    _tituloController = TextEditingController(text: widget.tarefa.titulo);
    _descricaoController = TextEditingController(text: widget.tarefa.descricao);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void salvarModificacao() async {
    String? novoTitulo = _tituloController.text;
    String? novaDescricao = _descricaoController.text;

    await db.atualizarTarefas(widget.id, novoTitulo, novaDescricao);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Atualizar Tarefas"), centerTitle: true),
          body: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Column(
              spacing: 10,
              children: [
                const SizedBox(width: 20),
                TextField(
                  controller: _tituloController,

                  decoration: InputDecoration(
                    label: Text("Titulo"),
                    border: OutlineInputBorder(),
                    prefix: Icon(Icons.title),
                  ),
                ),
                const SizedBox(width: 20),
                TextField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    hintMaxLines: 3,
                    label: Text("Descrição"),
                    border: OutlineInputBorder(),
                    prefix: Icon(Icons.description),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: salvarModificacao,
                  child: Text("Salvar Modificação"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
