enum Type {
  toner('Toner'),
  inyection('Inyección'),
  cartucho('Cartucho'),
  termico('Térmico'),
  otros('Otros');

  final String name;
  const Type(this.name);
}
