import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';

import 'package:controltower/src/generated/torreServer.pb.dart';
import 'package:controltower/src/generated/torreServer.pbgrpc.dart';

class Plane {
  String code;
  String airport;
  ClientChannel channel;
  planeHostClient stub; 
  String ip;
  Plane(String code, String airport, String ip) {
    this.code = code;
    this.airport = airport;
    this.ip = ip;
    channel = new ClientChannel(ip,
      port: 50051,
      options: const ChannelOptions(
          credentials: const ChannelCredentials.insecure()));
    stub = new planeHostClient(channel);

  }

  Plane.blank() {
    this.code = this.airport = "";
  }

  @override
  String toString(){
    return this.code;
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
    final Plane arrPlane = new Plane(request.code, request.srcAirport, request.ip);

    String preCode = "";

    for (var i = 0; i < this.landingAmount; i++) {
      if (this.landings[i].code == "") {
        idx_pista = i + 1;
        landings[i] = arrPlane;
        airprint("La pista de aterrizaje asignada para ${request.code} - ${request.ip} es la $idx_pista");
        break;
      }
    }

    if (idx_pista == -1) {
      landingQueue.insert(0, arrPlane);
      
      if (landingQueue.length > 1){
        preCode = landingQueue[1].code;
      }
      airprint("Avión ${request.code} - ${request.ip} en espera de aterrizaje");

    }

    return new Runway()..runway = idx_pista
                       ..airportName = this.name
                       ..preCode = preCode;
  }

  @override
  Stream<ArrivingPlane> listLanded(ServiceCall call, ArrivingPlane request) async *{
    for (Plane plane in landings){
      yield new ArrivingPlane()..code = plane.code
                               ..srcAirport = this.name;
  
    }
  }

  @override
  Future<Runway> requestTakeoff (ServiceCall call, DepartingPlane request) async {
  airprint("${request.code} en ${request.runway} solicitando pista para despegar...");
    var idx_pista = -1;

    String preCode = "";

    for (var i = 0; i < this.landingAmount; i++) {
      if (this.departures[i].code == "") {
        idx_pista = i + 1;
        departures[i] = landings[request.runway-1];
        landings[request.runway-1] = new Plane.blank();
        airprint("La pista de despegue asignada para ${request.code} es la $idx_pista");
        if (landingQueue.isNotEmpty){
          final Plane landingPlane = landingQueue.removeLast();
          airprint("Permitiendo aterrizaje a ${landingPlane.code}");
          await landingPlane.stub.notifyLanding(new Runway()..runway = request.runway..airportName = this.name..preCode = "");
          landings[request.runway-1] = landingPlane;
          airprint("La pista de aterrizaje asignada para ${landingPlane.code} es la ${request.runway}");
        }
        break;
      }
    }

    if (idx_pista == -1) {
      departureQueue.insert(0, landings[request.runway-1]);
      if (departureQueue.length > 1){
        preCode = departureQueue[1].code;
      }
      airprint("Avión ${request.code} en espera de despegue");

    }

    return new Runway()..runway = idx_pista
                       ..airportName = this.name
                       ..preCode = preCode;
  }


}

Future<Null> main(List<String> args) async {
  final String address = "0.0.0.0";
  print("✈  TorreOS 0.4.5 ✈");
  print("Ingrese puerto del servidor:");
  final int port = int.parse(stdin.readLineSync());
  print("[Torre de control] Ingrese nombre del aeropuerto:");
  final name = stdin.readLineSync();
  print("[Torre de control - $name] Cantidad de pistas de aterrizaje:");
  final int landingAmount = int.parse(stdin.readLineSync());
  print("[Torre de control - $name] Cantidad de pistas de despegue:");
  final int cantDespegue = int.parse(stdin.readLineSync());

  final server = new Server([new Airport(name, landingAmount, cantDespegue)]);
  await server.serve(address: address, port: port);
  print('Aeropuerto operativo en ${address}:${server.port}!');
}
