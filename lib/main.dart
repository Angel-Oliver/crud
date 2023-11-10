import 'package:aula_flutter6/editar_tarefa.dart';
import 'package:aula_flutter6/tarefa_model.dart';
import 'package:aula_flutter6/tarefa_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TarefaAdapter());
  await Hive.openBox<Tarefa>('tarefa');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 183, 58, 127)),
        //useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController descricaoController = TextEditingController();
  TarefaBox tarefaBox = TarefaBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Tarefas")),
      body: Column(children: [
        TextField(
            controller: descricaoController,
            decoration: InputDecoration(label: Text('Descrição'))),
        ElevatedButton(
            onPressed: () {
              var novaTarefa = Tarefa(descricaoController.text);
              tarefaBox.addTarefa(novaTarefa);
              descricaoController.clear();
              setState(() {});
            },
            child: Text('Criar Tarefa')),
        Expanded(
            child: ListView.builder(
          itemCount: tarefaBox.mostrarTarefas().length,
          itemBuilder: (context, index) {
            var tarefa = tarefaBox.mostrarTarefas()[index];
            return ListTile(
              title: Text(tarefa.descricao ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        tarefaBox.deletarTarefa(index);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete)),
                  IconButton(
                      onPressed: () async {
                        var resultado = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => EditarTarefa(
                                    tarefa: tarefa, index: index)));
                        if (resultado != null) {
                          setState(() {});
                        }
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
            );
          },
        ))
      ]),
    );
  }
}
