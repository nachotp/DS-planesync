import grpc
from concurrent import futures
import time
from torreServer_pb2 import *
from torreServer_pb2_grpc import *
_ONE_DAY_IN_SECONDS = 60 * 60 * 24

class Avion():
        def __init__(self,aerolinea,numero,peso,altura,torre,rwy,ip,puerto):
                self.aerolinea= aerolinea
                self.numero = numero
                self.peso = peso
                self.torre = torre
                self.puerto = puerto
                self.rwy = rwy
                self.ip = ip
                self.altura = altura
        def planeprint(self, mensaje):
                print("[Avión - " + self.numero + "] " + mensaje)

def aterrizar(avion):
    with grpc.insecure_channel(avion.torre + ':50051') as channel:
        stub = towerHostStub(channel)
        input("[Avión - " + avion.numero + "] Presione enter para aterrizar")
        avion.planeprint("Ciudad Torre, "+ avion.numero +", establecidos en radial de pista hacia Ciudad")
        respuesta =stub.requestLanding(ArrivingPlane(code=avion.numero, srcAirport=avion.torre,ip= avion.ip, port = avion.puerto))
        avion.rwy = respuesta.runway
        if(avion.rwy==-1):
                if(respuesta.preCode==""):
                        avion.planeprint("Pista ocupada, mantener " + str(avion.altura) + " pies a la espera de autorización.")
                else:
                        avion.planeprint("En cola de despegue, antecedido por "+ respuesta.preCode + ", mantener posición hasta nuevo aviso.")
                while(avion.rwy==-1):
                        pass
        avion.planeprint("Autorizados para aterrizar en pista " + str(avion.rwy))

def despegar(avion):
    with grpc.insecure_channel(avion.torre + ':50051') as channel:
        avion.planeprint("Pista: " + str(avion.rwy))
        stub = towerHostStub(channel)
        input("[Avión - " + avion.numero + "] Presione enter para solicitar pista de despegue")
        dest = input("Ingrese destino:\n")
        avion.planeprint("Pasando por el Gate...\n[Avión - " + avion.numero + "] Todos los pasajeros a bordo y combustible cargado.\n[Avión - " + avion.numero + "] Pidiendo instrucciones para despegar...")
        auth = stub.requestTakeoff(DepartingPlane(code=avion.numero, runway = avion.rwy))
        avion.rwy = auth.runway
        if(avion.rwy==-1):
                if(auth.preCode==""):
                        avion.planeprint("Pista ocupada, mantener posición hasta nuevo aviso.")
                else:
                        avion.planeprint("En cola de despegue, antecedido por "+ auth.preCode + ", mantener posición hasta nuevo aviso.")
                while(avion.rwy==-1):
                        pass
        avion.planeprint("Autorizados para despegar en pista " + str(avion.rwy))
        input("Presione enter para despegar")
        stub.takeoff(DepartingPlane(code=avion.numero, runway = avion.rwy))
        


class Airplane(planeHostServicer):
        def __init__(self,plane):
                self.avion = plane
        def notifyLanding(self, request, context):
                self.avion.rwy = request.runway
                self.avion.planeprint("Me fui a piso")
                return Empty()
        def notifyDeparture(self, request, context):
                self.avion.rwy = request.runway
                self.avion.planeprint("Me fui a la verga")
                return Empty()

avion = input("[Avion] Nombre de la Aerolínea y número de Avión:\n").split()
aerolinea = avion[0]
numero = avion[1]
peso = input("Peso Máximo de carga [kg]:\n")
combustible = input("Capacidad del tanque de combustible [lt]:\n")
torre_inicial = input("Torre de Control inicial:\n")
ip = "10.11.6.36"
port = int(input("Puerto servidor: "))
altura = 10000
plane = Avion(aerolinea, numero,peso,altura,torre_inicial,0,ip,port)
server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
add_planeHostServicer_to_server(Airplane(plane),server)
server.add_insecure_port('0.0.0.0:'+str(port))
server.start()
continuar = "s"
while(continuar=="s"):
        aterrizar(plane)
        despegar(plane)
        continuar = input("¿Desea continuar volando? (s/n)")
print("El avión ha sido derribado!!")