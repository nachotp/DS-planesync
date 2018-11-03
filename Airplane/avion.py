from __future__ import print_function

import grpc

import torreServer_pb2
import torreServer_pb2_grpc


def run():
    avion = input("[Avion] Nombre de la Aerolínea y número de Avión:\n").split()
    aerolinea = avion[0]
    numero = avion[1]
    avion = "[Avión - " + numero + "]"
    peso = input("Peso Máximo de carga [kg]:\n")
    combustible = input("Capacidad del tanque de combustible [lt]:\n")
    torre_inicial = input("Torre de Control inicial:\n")
    with grpc.insecure_channel(torre_inicial + ':50051') as channel:
        input(avion + "Presione enter para aterrizar")
        print(avion +"Ciudad Torre, "+ numero +", establecidos en radial de pista hacia Ciudad ")
        stub = torreServer_pb2_grpc.towerHostStub(channel)
        response = stub.revisar(torreServer_pb2.ArrivingPlane(code=numero,srcAirport=torre_inicial))
        if(response.pista==-1):
                print(avion + "Todas las pistas están ocupadas, el avión predecesor es LA1234")
        else:
                print(avion + "Autorizados para aterrizar en pista "+str(response.pista))


if __name__ == '__main__':
    run()
