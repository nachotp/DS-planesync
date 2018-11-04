import grpc
from concurrent import futures

from torreServer_pb2 import *
from torreServer_pb2_grpc import *

class Airplane(planeHostServicer):
        def notifyLanding(self, request, context):
                print("Notificado")
                return Empty

def aterrizar(torre, avion, numero):
    with grpc.insecure_channel(torre + ':50051') as channel:
        stub = towerHostStub(channel)
        input(avion + "Presione enter para aterrizar")
        print(avion +"Ciudad Torre, "+ numero +", establecidos en radial de pista hacia Ciudad")
        respuesta =stub.requestLanding(ArrivingPlane(code=numero, srcAirport=torre_inicial))
        if(respuesta.runway==-1):
            print("Pista ocupada, mantener 5000 pies a la espera de autorización.")
        print("Autorizados para aterrizar en pista " + str(respuesta.runway))
        return respuesta.runway

def despegar(torre, avion, numero, rwy):
    with grpc.insecure_channel(torre + ':50051') as channel:
        stub = towerHostStub(channel)
        input(avion + "Presione enter para despegar")
        dest = input("Ingrese destino:\n")
        print("Pasando por el Gate...\nTodos los pasajeros a bordo y combustible cargado.\nPidiendo instrucciones para despegar...")
        auth = stub.requestTakeoff(DepartingPlane(code=numero, runway = rwy))

avion = input("[Avion] Nombre de la Aerolínea y número de Avión:\n").split()
aerolinea = avion[0]
numero = avion[1]
avion = "[Avión - " + numero + "]"
peso = input("Peso Máximo de carga [kg]:\n")
combustible = input("Capacidad del tanque de combustible [lt]:\n")
torre_inicial = input("Torre de Control inicial:\n")
server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
add_planeHostServicer_to_server(Airplane(),server)
server.add_insecure_port('0.0.0.0:50051')
server.start()
rwy = aterrizar(torre_inicial, avion, numero)
despegar(torre_inicial,avion,numero,rwy)