enum Status {
  avilaible('En Stock'),
  low('Bajo Stock'),
  empty('Agotado');

  final String name;
  const Status(this.name);
}
