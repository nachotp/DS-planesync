import grpc
from concurrent import futures

from torreServer_pb2 import *
from torreServer_pb2_grpc import *



class Avion():
        def __init__(self,aerolinea,numero,peso,torre,rwy):
                self.aerolinea= aerolinea
                self.numero = numero
                self.peso = peso
                self.torre = torre
                self.rwy = rwy

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
        auth = stub.requestTakeoff(DepartingPlane(code=avion.numero, runway = avion.rwy))


class Airplane(planeHostServicer):
        def __init__(self,plane):
                self.rwy = 0
                self.avion = plane
        def notifyLanding(self, request, context):
                self.rwy = request.runway
                print("Notificado")
                return Empty

avion = input("[Avion] Nombre de la Aerolínea y número de Avión:\n").split()
aerolinea = avion[0]
numero = avion[1]
peso = input("Peso Máximo de carga [kg]:\n")
combustible = input("Capacidad del tanque de combustible [lt]:\n")
torre_inicial = input("Torre de Control inicial:\n")
plane = Avion(aerolinea, numero,peso,torre_inicial,0)
plane.rwy = aterrizar(plane)
despegar(plane)
server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
add_planeHostServicer_to_server(Airplane(plane),server)
server.add_insecure_port('0.0.0.0:50051')
server.start()
#avion.rwy = aterrizar(avion.torre, avion.avion, avion.numero)
#despegar(avion.torre, avion.avion, avion.numero, avion.rwy)