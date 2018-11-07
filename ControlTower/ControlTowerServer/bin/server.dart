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
  int height;
  Plane(String code, String airport, String ip, int port) {
    this.code = code;
    this.airport = airport;
    this.ip = ip;
    channel = new ClientChannel(ip,
        port: port,
        options: const ChannelOptions(
            credentials: const ChannelCredentials.insecure()));
    stub = new planeHostClient(channel);
  }

  Plane.blank() {
    this.code = this.airport = "";
  }

  @override
  String toString() {
    return this.code;
  }
}

class HeightQueue {
  List<int> queue;
  int currHeight;

  HeightQueue(int min) {
    this.currHeight = min;
    this.queue = new List<int>();
  }

  int getHeight() {
    int height;
    if (queue.isEmpty) {
      height = currHeight;
      currHeight += 2;
      return height;
    } else {
      return queue.removeLast();
    }
  }

  void enqueue(int height) {
    queue.insert(0, height);
  }
}

class Screen {
  ClientChannel channel;
  screenHostClient stub;
  
  Screen(String ip, int port){
    channel = new ClientChannel(ip,
        port: port,
        options: const ChannelOptions(
            credentials: const ChannelCredentials.insecure()));
    stub = new screenHostClient(channel);
  }

  void refreshScreen(List<Flight> flights) async { 
    stub.listFlights(Stream.fromIterable(flights));
  }

}

class Airport extends towerHostServiceBase {
  String name;
  int landingAmount;
  int takeoffAmount;
  List<Plane> landings;
  List<Plane> departures;
  List<Plane> landingQueue;
  HeightQueue landingHeights;
  List<Plane> departureQueue;
  HeightQueue departureHeights;
  List<Screen> connectedScreens;
  Map<String, AirportInfo> airports;

  Airport(String name, int landingAmount, int takeoffAmount,
      Map<String, AirportInfo> airports) {
    this.name = name;
    this.landingAmount = landingAmount;
    this.takeoffAmount = takeoffAmount;
    landings = new List<Plane>.filled(landingAmount, new Plane.blank());
    departures = new List<Plane>.filled(takeoffAmount, new Plane.blank());
    landingQueue = new List<Plane>();
    departureQueue = new List<Plane>();
    connectedScreens = new List<Screen>();
    landingHeights = HeightQueue(1);
    departureHeights = HeightQueue(2);
    this.airports = airports;
  }

  void airprint(String input) {
    print('[Torre de control - ${this.name}] ${input}');
  }

  @override
  Future<Runway> requestLanding(ServiceCall call, ArrivingPlane request) async {
    airprint("${request.code} solicitando pista para aterrizar...");
    var idx_pista = -1;
    final Plane arrPlane =
        new Plane(request.code, request.srcAirport, request.ip, request.port);
    int height = 0;
    String preCode = "";

    for (var i = 0; i < this.landingAmount; i++) {
      if (this.landings[i].code == "") {
        idx_pista = i + 1;
        landings[i] = arrPlane;
        airprint(
            "La pista de aterrizaje asignada para ${request.code} - ${request.ip}:${request.port} es la $idx_pista");
        break;
      }
    }

    if (idx_pista == -1) {
      landingQueue.insert(0, arrPlane);
      height = landingHeights.getHeight();
      if (landingQueue.length > 1) {
        preCode = landingQueue[1].code;
      }
      airprint(
          "Avión ${request.code} - ${request.ip}:${request.port} en espera de aterrizaje a ${height * 200 + 3000} pies de altura");
    }

    refreshScreens();
    return new Runway()
      ..runway = idx_pista
      ..airportName = this.name
      ..preCode = preCode
      ..height = height;
  }

  @override
  Future<Runway> requestTakeoff(
      ServiceCall call, DepartingPlane request) async {
    airprint(
        "${request.code} en ${request.runway} solicitando pista para despegar...");
    var idx_pista = -1;
    String preCode = "";
    int height = 0;
    for (var i = 0; i < this.takeoffAmount; i++) {
      if (this.departures[i].code == "") {
        height = departureHeights.getHeight();
        idx_pista = i + 1;
        departures[i] = landings[request.runway - 1];
        landings[request.runway - 1] = new Plane.blank();
        airprint(
            "La pista de despegue asignada para ${request.code} es la $idx_pista  con despegue a altura ${height * 200 + 3000} pies");

        if (landingQueue.isNotEmpty) {
          final Plane landingPlane = landingQueue.removeLast();
          airprint("Permitiendo aterrizaje a ${landingPlane.code}");
          final int arrHeight =
              (await landingPlane.stub.notifyLanding(new Runway()
                    ..runway = request.runway
                    ..airportName = this.name
                    ..preCode = ""))
                  .height;
          landingHeights.enqueue(arrHeight);
          landings[request.runway - 1] = landingPlane;
          airprint(
              "La pista de aterrizaje asignada para ${landingPlane.code} es la ${request.runway}");
        }
        break;
      }
    }

    if (idx_pista == -1) {
      departureQueue.insert(0, landings[request.runway - 1]);
      if (departureQueue.length > 1) {
        preCode = departureQueue[1].code;
      }
      airprint("Avión ${request.code} en espera de despegue");
    }
    refreshScreens();
    return new Runway()
      ..runway = idx_pista
      ..airportName = this.name
      ..preCode = preCode
      ..height = height;
  }

  @override
  Future<TakeoffStatus> checkTakeoff(
      ServiceCall call, PlaneData request) async {
    int errorCode = 0;
    if (request.currFuel < 4 / 5 * request.maxFuel) {
      errorCode = 1;
    } else if (request.currWeight > request.maxWeight) {
      errorCode = 2;
    }
    return new TakeoffStatus()..errorCode = errorCode;
  }

  @override
  Future<AirportInfo> takeoff(ServiceCall call, DepartingPlane request) async {
    airprint(
        "Avión ${request.code} ha despegado desde pista ${request.runway} en dirección a ${request.airportName}.");
    departureHeights.enqueue(request.height);
    departures[request.runway - 1] = new Plane.blank();

    if (departureQueue.isNotEmpty) {
      final Plane departingPlane = departureQueue.removeLast();
      final int height = departureHeights.getHeight();
      departingPlane.stub.notifyDeparture(new Runway()
        ..runway = request.runway
        ..airportName = this.name
        ..preCode = ""
        ..height = height);
      airprint(
          "La pista de despegue asignada para ${departingPlane.code} es la ${request.runway} con despegue a altura ${height * 200 + 3000} pies");
      departures[request.runway - 1] = departingPlane;
      int j;
      for (var i = 0; i < this.landingAmount; i++) {
        if (landings[i].code == departingPlane.code) {
          j = i;
          break;
        }
      }
      landings[j] = new Plane.blank();
      if (landingQueue.isNotEmpty) {
        final Plane landingPlane = landingQueue.removeLast();
        airprint("Permitiendo aterrizaje a ${landingPlane.code}");
        await landingPlane.stub.notifyLanding(new Runway()
          ..runway = j + 1
          ..airportName = this.name
          ..preCode = "");
        landings[j] = landingPlane;
        airprint(
            "La pista de aterrizaje asignada para ${landingPlane.code} es la ${j + 1}");
      }
    }
    refreshScreens();
    return airports[request.airportName];
  }

  @override
  Future<Empty> screenConnect(ServiceCall call, ScreenInfo request) async{
    print("Pantalla conectada!");
    connectedScreens.add(Screen(request.ip, request.port));
    return new Empty();
  }

  void refreshScreens() async{
    final List<Flight> currflights = new List<Flight>();
    for (Plane pl in landings){
      if (pl.code != ""){
        currflights.add(new Flight()..code = pl.code
                                    ..airport = pl.airport
                                    ..time = "12:00"
                                    ..type = 0);
      }
    }

    for (Plane pl in landingQueue){
      currflights.add(new Flight()..code = pl.code
                                  ..airport = pl.airport
                                  ..time = "12:00"
                                  ..type = 1);
    }

    for (Plane pl in departures){
      if (pl.code != ""){
        currflights.add(new Flight()..code = pl.code
                                    ..airport = pl.airport
                                    ..time = "12:00"
                                    ..type = 2);
      }
    }

    for (Plane pl in departureQueue){
      currflights.add(new Flight()..code = pl.code
                                  ..airport = pl.airport
                                  ..time = "12:00"
                                  ..type = 3);
    }

    for (Screen sc in connectedScreens){
      sc.refreshScreen(currflights);
    }
  }
}

Future<Null> main(List<String> args) async {
  final String address = "0.0.0.0";
  print("✈  TorreOS 0.7.5 ✈");
  print("Ingrese puerto del servidor:");
  final int port = int.parse(stdin.readLineSync());
  print("[Torre de control] Ingrese nombre del aeropuerto:");
  final name = stdin.readLineSync();
  print("[Torre de control - $name] Cantidad de pistas de aterrizaje:");
  final int landingAmount = int.parse(stdin.readLineSync());
  print("[Torre de control - $name] Cantidad de pistas de despegue:");
  final int cantDespegue = int.parse(stdin.readLineSync());
  final Map<String, AirportInfo> airports = new Map();
  print("Ingrese nombre de aeropuerto disponible o x para terminar:");
  String nombre = stdin.readLineSync();
  String ip;
  int apPort;
  while (nombre != "x") {
    print("Ingrese IP del servidor:");
    ip = stdin.readLineSync();
    print("Ingrese puerto del servidor:");
    apPort = int.parse(stdin.readLineSync());
    airports[nombre] = new AirportInfo()
      ..ip = ip
      ..port = apPort;
    print("Ingrese nombre de aeropuerto disponible o x para terminar:");
    nombre = stdin.readLineSync();
  }
  final server =
      new Server([new Airport(name, landingAmount, cantDespegue, airports)]);
  await server.serve(address: address, port: port);
  print('Aeropuerto operativo en ${address}:${server.port}!');
}
