import grpc
from concurrent import futures
import time
from torreServer_pb2 import *
from torreServer_pb2_grpc import *
_ONE_DAY_IN_SECONDS = 60 * 60 * 24

class Avion():
        def __init__(self,aerolinea,numero,peso,torre,rwy,ip):
                self.aerolinea= aerolinea
                self.numero = numero
                self.peso = peso
                self.torre = torre
                self.rwy = rwy
                self.ip = ip

def aterrizar(avion):
    with grpc.insecure_channel(avion.torre + ':50051') as channel:
        stub = towerHostStub(channel)
        input("[Avión - " + avion.numero + "] Presione enter para aterrizar")
        print("[Avión - " + avion.numero + "Ciudad Torre, "+ avion.numero +", establecidos en radial de pista hacia Ciudad")
        respuesta =stub.requestLanding(ArrivingPlane(code=avion.numero, srcAirport=avion.torre))
        if(respuesta.runway==-1):
            print("Pista ocupada, mantener 5000 pies a la espera de autorización.")
            while(avion.rwy!=-1):
                    print("En espera")
        print("Autorizados para aterrizar en pista " + str(respuesta.runway))
        return respuesta.runway

def despegar(avion):
    with grpc.insecure_channel(avion.torre + ':50051') as channel:
        stub = towerHostStub(channel)
        input("[Avión - " + avion.numero + "] Presione enter para despegar")
        dest = input("Ingrese destino:\n")
        print("Pasando por el Gate...\nTodos los pasajeros a bordo y combustible cargado.\nPidiendo instrucciones para despegar...")
        auth = stub.requestTakeoff(DepartingPlane(code=avion.numero, runway = avion.rwy, id= avion.ip))
        print("Llegue aqui")


class Airplane(planeHostServicer):
        def __init__(self,plane):
                self.avion = plane
        def notifyLanding(self, request, context):
                self.avion.rwy = request.Runway
                print("Notificado")
                return Empty

avion = input("[Avion] Nombre de la Aerolínea y número de Avión:\n").split()
aerolinea = avion[0]
numero = avion[1]
peso = input("Peso Máximo de carga [kg]:\n")
combustible = input("Capacidad del tanque de combustible [lt]:\n")
torre_inicial = input("Torre de Control inicial:\n")
ip = "192.168.10.2"
plane = Avion(aerolinea, numero,peso,torre_inicial,0,ip)
server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
add_planeHostServicer_to_server(Airplane(plane),server)
server.add_insecure_port('0.0.0.0:50051')
server.start()
plane.rwy = aterrizar(plane)
despegar(plane)