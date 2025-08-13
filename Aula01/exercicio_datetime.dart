void main() {
  int inf = 5;
  int at = DateTime.now().month;

  if (at > inf) {
    print('$at é maior que $inf');
  } else if (inf > at) {
    print('$inf é maior que $at');
  } else {
    print('$at é igual $inf');
  }
}
