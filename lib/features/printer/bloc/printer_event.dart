part of 'printer_bloc.dart';

abstract class PrinterEvent {}

class LoadPrinterEvent extends PrinterEvent {}

class PostPrinterEvent extends PrinterEvent {
  ImpresoraModel model;
  PostPrinterEvent(this.model);
}

class PutPrinterEvent extends PrinterEvent {
  ImpresoraModel model;
  PutPrinterEvent(this.model);
}

class DeletePrinterEvent extends PrinterEvent {
  String serie;
  DeletePrinterEvent(this.serie);
}
