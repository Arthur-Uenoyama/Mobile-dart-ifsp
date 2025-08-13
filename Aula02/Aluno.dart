class Aluno {
  String n;
  String m;
  List<double> notas;

  Aluno({required this.n, required this.m, required this.notas});

  double calcularMedia() {
    if (notas.isEmpty) return 0.0;
    double soma = notas.reduce((a, b) => a + b);
    return soma / notas.length;
  }

  void exibirInfo() {
    print('Nome: $n');
    print('Matrícula: $m');
    print('Notas: $notas');
  }
}
