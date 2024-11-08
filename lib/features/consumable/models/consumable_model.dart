import 'dart:convert';

List<ConsumableModel> consumableFromJson(String str) =>
    List<ConsumableModel>.from(
      json.decode(str).map(
            (item) => ConsumableModel.fromJson(item),
          ),
    );

class ConsumableModel {
  String id;
  String nombre;
  String tipo;
  String fecha;
  String items;

  ConsumableModel({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.fecha,
    required this.items,
  });

  factory ConsumableModel.fromJson(Map<String, dynamic> json) =>
      ConsumableModel(
        id: json["id"],
        nombre: json["nombre"],
        tipo: json["categoria"],
        fecha: json["fecha_adquisicion"],
        items: json["cantidad"],
      );

  Map<String, dynamic> toRegister() => {
        "nombre": nombre,
        "categoria": tipo,
        "fecha_adquisicion": fecha,
        "cantidad": items,
      };

  Map<String, dynamic> toUpdate() => {
        "id": id,
        "nombre": nombre,
        "categoria": tipo,
        "fecha_adquisicion": fecha,
        "cantidad": items,
      };
}
