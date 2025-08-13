import 'aluno.dart';

void main() {
  Aluno al = Aluno(
    nome: "Fulano de Tal",
    matricula: "123456",
    notas: [6.3, 5.2, 9.4],
  );

  al.exibirInfo();
}
