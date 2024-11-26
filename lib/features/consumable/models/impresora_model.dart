// To parse this JSON data, do
//
//     final impresoraModel = impresoraModelFromJson(jsonString);

import 'dart:convert';

ImpresoraModel impresoraModelFromJson(String str) =>
    ImpresoraModel.fromJson(json.decode(str));

String impresoraModelToJson(ImpresoraModel data) => json.encode(data.toJson());

List<ImpresoraModel> impresoramOdelFromJson(String str) =>
    List<ImpresoraModel>.from(
      json.decode(str).map(
            (item) => ImpresoraModel.fromJson(item),
          ),
    );

class ImpresoraModel {
  String serie;
  String modelo;
  String tipo;
  String modeloTinta;
  String stock;
  String disponible;
  Tintas tintas;

  ImpresoraModel({
    required this.serie,
    required this.modelo,
    required this.tipo,
    required this.modeloTinta,
    required this.stock,
    required this.disponible,
    required this.tintas,
  });

  factory ImpresoraModel.fromJson(Map<String, dynamic> json) => ImpresoraModel(
        serie: json["serie"],
        modelo: json["modelo"],
        tipo: json["tipo"],
        modeloTinta: json["modeloTinta"],
        stock: json["stock"],
        disponible: json["disponible"],
        tintas: Tintas.fromJson(json["tintas"]),
      );

  Map<String, dynamic> toJson() => {
        "serie": serie,
        "modelo": modelo,
        "tipo": tipo,
        "modeloTinta": modeloTinta,
        "stock": stock,
        "disponible": disponible,
        "tintas": tintas.toJson(),
      };
}

class Tintas {
  String negro;
  String cyan;
  String magenta;
  String amarillo;
  String cinta;
  String otros;

  Tintas({
    required this.negro,
    required this.cyan,
    required this.magenta,
    required this.amarillo,
    required this.cinta,
    required this.otros,
  });

  factory Tintas.fromJson(Map<String, dynamic> json) => Tintas(
        negro: json["Negro"],
        cyan: json["Cyan"],
        magenta: json["Magenta"],
        amarillo: json["Amarillo"],
        cinta: json["Cinta"],
        otros: json["Otros"],
      );

  Map<String, dynamic> toJson() => {
        "Negro": negro,
        "Cyan": cyan,
        "Magenta": magenta,
        "Amarillo": amarillo,
        "Cinta": cinta,
        "Otros": otros,
      };
}
