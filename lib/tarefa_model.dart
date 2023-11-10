import 'package:hive/hive.dart';
part 'tarefa_model.g.dart';

@HiveType(typeId: 0)
class Tarefa {
  @HiveField(1)
  String? descricao;

  Tarefa(this.descricao);
}
