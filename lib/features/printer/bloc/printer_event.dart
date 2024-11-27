part of 'printer_bloc.dart';

abstract class PrinterEvent {}

class LoadPrinterEvent extends PrinterEvent {}

class PostPrinterEvent extends PrinterEvent {
  ImpresoraModel model;
  PostPrinterEvent(this.model);
}
