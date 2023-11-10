import 'package:aula_flutter6/tarefa_model.dart';
import 'package:hive/hive.dart';

class TarefaBox {
  addTarefa(Tarefa tarefa) async {
    var box = Hive.box<Tarefa>('tarefa');
    box.add(tarefa);
  }

  List<Tarefa> mostrarTarefas() {
    var box = Hive.box<Tarefa>('tarefa');
    return box.values.toList();
  }
  deletarTarefa(int index){
    var box = Hive.box<Tarefa>('tarefa');
    box.deleteAt(index);
  }
  editarTarefa(Tarefa tarefa, int index){
    var box = Hive.box<Tarefa>('tarefa');
    box.putAt(index, tarefa);
  }
  }
