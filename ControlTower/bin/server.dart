import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';

import 'package:controltower/src/generated/torreServer.pb.dart';
import 'package:controltower/src/generated/torreServer.pbgrpc.dart';

class Plane {
  String code;
  String airport;
  String ip;

  Plane(String code, String airport, String ip) {
    this.code = code;
    this.airport = airport;
    this.ip = ip;
  }

  Plane.blank() {
    this.code = this.airport = this.ip = "";
  }
}

class Airport extends towerHostServiceBase {
  String name;
  int landingAmount;
  int arrivalAmount;
  List<Plane> landings;
  List<Plane> departures;
  List<Plane> landingQueue;
  List<Plane> departureQueue;

  Airport(String name, int landingAmount, int arrivalAmount) {
    this.name = name;
    this.landingAmount = landingAmount;
    this.arrivalAmount = arrivalAmount;
    landings = new List<Plane>.filled(landingAmount, new Plane.blank());
    departures = new List<Plane>.filled(arrivalAmount, new Plane.blank());
    landingQueue = new List<Plane>();
    departureQueue = new List<Plane>();
  }

  void airprint(String input) {
    print('[Torre de control - ${this.name}] ${input}');
  }

  @override
  Future<Runway> requestLanding(ServiceCall call, ArrivingPlane request) async {
    airprint("${request.code} solicitando pista para aterrizar...");
    var idx_pista = -1;
    final ip = call.clientMetadata[':authority'].split(":")[0];
    print("[DEBUG] conexión con ${ip}");
    final Plane arrPlane = new Plane(request.code, request.srcAirport, ip);

    for (var i = 0; i < this.landingAmount; i++) {
      if (this.landings[i].code == "") {
        idx_pista = i + 1;
        landings[i] = arrPlane;
        airprint("La pista de aterrizaje asignada para ${request.code} es la $idx_pista");
        break;
      }
    }

    String preCode = "";

    if (idx_pista == -1) {
      landingQueue.insert(0, arrPlane);
      airprint("Avión ${request.code} en espera de aterrizaje");
    }
  
    return new Runway()..runway = idx_pista
                       ..airportName = this.name
                       ..preCode = preCode;
  }

  @override
  Future<Runway> requestTakeoff(
      ServiceCall call, DepartingPlane request) async {
    return new Runway();
  }
}

Future<Null> main(List<String> args) async {
  final String address = "0.0.0.0";
  print("TorreOS 0.2 ✈");
  print("[Torre de control] Ingrese nombre del aeropuerto:");
  final name = stdin.readLineSync();
  print("[Torre de control - $name] Cantidad de pistas de aterrizaje:");
  final int landingAmount = int.parse(stdin.readLineSync());
  print("[Torre de control - $name] Cantidad de pistas de despegue:");
  final int cantDespegue = int.parse(stdin.readLineSync());

  final server = new Server([new Airport(name, landingAmount, cantDespegue)]);
  await server.serve(address: address, port: 50051);
  print('Aeropuerto operativo en ${address}:${server.port}!');
}
