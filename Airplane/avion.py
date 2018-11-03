
import grpc

from torreServer_pb2 import *
from torreServer_pb2_grpc import *


avion = input("[Avion] Nombre de la Aerolínea y número de Avión:\n").split()
aerolinea = avion[0]
numero = avion[1]
avion = "[Avión - " + numero + "]"
peso = input("Peso Máximo de carga [kg]:\n")
combustible = input("Capacidad del tanque de combustible [lt]:\n")
torre_inicial = input("Torre de Control inicial:\n")

with grpc.insecure_channel(torre_inicial + ':50051') as channel:
    input(avion + "Presione enter para aterrizar")
    print(avion +"Ciudad Torre, "+ numero +", establecidos en radial de pista hacia Ciudad")
    stub = towerHostStub(channel)
    response = stub.requestLanding(ArrivingPlane(code=numero, srcAirport=torre_inicial))
    print(response)