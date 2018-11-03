// Copyright (c) 2018, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Dart implementation of the gRPC helloworld.Greeter server.
import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';

import 'package:controltower/src/generated/torreServer.pb.dart';
import 'package:controltower/src/generated/torreServer.pbgrpc.dart';

class Plane {
  String code;
  String airport;
  String ip;
  
  Plane (String code, String airport, String ip){
    this.code = code;
    this.airport = airport;
    this.ip = ip;
  }

  Plane.blank(){
    this.code = this.airport = this.ip = "";
  }
}


class Airport extends towerHostServiceBase{
  String name;
  int landingAmount;
  int arrivalAmount;
  List<Plane> landings;
  List<Plane> departures;
  List<Plane> landingQueue;
  List<Plane> departureQueue;

  Airport(String name, int landingAmount, int arrivalAmount){
    this.name = name;
    this.landingAmount = landingAmount;
    this.arrivalAmount = arrivalAmount;
    landings = new List<Plane>.filled(landingAmount, new Plane.blank());
    departures = new List<Plane>.filled(arrivalAmount, new Plane.blank());
    landingQueue = new List<Plane>();
    departureQueue = new List<Plane>();
  }

  void airprint(String input){
    print('[Torre de control - ${this.name}] ${input}');
  }

  @override
  Future<Runway> requestLanding(ServiceCall call, ArrivingPlane request) async {
    airprint("${request.code} solicitando pista para aterrizar...");
    var idx_pista = -1;
    final ip = call.clientMetadata['authority'].split(":")[0];
    final Plane arrPlane = new Plane(request.code, request.srcAirport, ip);

    for (var i = 0; i < this.landingAmount; i++){
      if (this.landings[i].code == "Null"){
        idx_pista = i+1;
        landings[i] = arrPlane;
        airprint("La pista de aterrizaje asignada para ${request.code} es la $idx_pista");
        break;
      }
    }
    if (idx_pista == -1){
      
      landingQueue.insert(0, arrPlane);
      airprint("Avión ${request.code} en espera de aterrizaje");
    }
    return new Runway()..runway = idx_pista;
  }

  @override
   Future<Runway> requestTakeoff(ServiceCall call, DepartingPlane request) async {

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
