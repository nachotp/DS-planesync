import grpc
from random import *
from concurrent import futures
from torreServer_pb2 import *
from torreServer_pb2_grpc import *

class Avion():
        def __init__(self,aerolinea,numero,pasajeros,combustible,peso,altura,torre,rwy,ip,puerto):
                self.aerolinea= aerolinea
                self.numero = numero
                self.pesoMax = peso
                self.torre = torre
                self.puerto = puerto
                self.rwy = rwy
                self.ip = ip
                self.altura = altura
                self.pasajeros = pasajeros
                self.maxFuel = int(combustible)
                self.actualFuel = int(randint(0,combustible))        
                self.pesoActual = self.actualFuel + self.pasajeros*75

        def planeprint(self, mensaje):
                print("[Avión - " + self.numero + "] " + mensaje)

        def planeinput(self, mensaje):
                return input("[Avión - " + self.numero + "] " + mensaje)

        def getPlanedata(self):
                return PlaneData(code=self.numero, currFuel = self.actualFuel, maxFuel = self.maxFuel, currWeight= self.pesoActual, maxWeight=self.pesoMax)

        def getDepartingPlane(self, destino):
                return DepartingPlane(code=self.numero, runway = self.rwy, airportName = destino)

        def getArrivingPlane(self):
                return ArrivingPlane(code=self.numero, srcAirport=self.torre,ip= self.ip, port = self.puerto)
                
def aterrizar(avion):
    with grpc.insecure_channel(avion.torre) as channel:
        stub = towerHostStub(channel)
        avion.planeinput("Presione enter para aterrizar")
        avion.planeprint(avion.numero +", establecidos en radial de pista.")
        respuesta =stub.requestLanding(avion.getArrivingPlane())
        avion.rwy = respuesta.runway
        if(avion.rwy==-1):
                if(respuesta.preCode==""):
                        avion.planeprint("Pista ocupada, mantener " + str(avion.altura) + " pies a la espera de autorización.")
                else:
                        avion.planeprint("En cola de despegue, antecedido por "+ respuesta.preCode + ", mantener posición hasta nuevo aviso.")
                while(avion.rwy==-1):
                        pass
        avion.planeprint("Autorizados para aterrizar en pista " + str(avion.rwy))
        avion.pasajeros = 0
        avion.actualFuel = avion.maxFuel - randint(1, avion.maxFuel)

def despegar(avion):
    with grpc.insecure_channel(avion.torre) as channel:
        avion.planeprint("Pista: " + str(avion.rwy))
        stub = towerHostStub(channel)
        avion.planeprint("Pasando por el Gate...")
        avion.planeprint("Combustible: " + str(avion.actualFuel) + "/" + str(avion.maxFuel) + " Peso: " + str(avion.pesoActual) + "/" + str(avion.pesoMax))
        carga = avion.planeinput("¿Desea cargar combustible? (se debe despegar con 4/5 del combustible máximo)(s/n)")
        if(carga=="s"):
                fuel = int(avion.planeinput("Ingrese cantidad de combustible: se pueden cargar a lo más "+ str(avion.maxFuel-avion.actualFuel) + " litros: "))
                while(fuel>avion.maxFuel-avion.actualFuel):
                        fuel = int(avion.planeinput("Capacidad máxima excedida, ingresar un valor entre 0 y "+ str(avion.maxFuel-avion.actualFuel) + " litros: "))
                avion.actualFuel = avion.actualFuel + fuel
        avion.pasajeros = avion.planeinput("Ingrese la cantidad de pasajeros en el vuelo (se recomienda no agregar más de "+ str(int((avion.pesoMax-avion.pesoActual)/75)) +" pasajeros):")
        avion.planeinput("Presione enter para solicitar pista de despegue")
        dest = avion.planeinput("Ingrese destino:\n")
        check = stub.checkTakeoff(avion.getPlanedata()) 
        avion.planeprint("Verificando combustible y peso del avión. ErrorCode = " + str(check.errorCode))
        while(check.errorCode != 0):
                if(check.errorCode == 1):
                        avion.planeprint("Combustible insuficiente! El tanque debe estar lleno, se deben cargar" + str(avion.maxFuel-avion.actualFuel) + " litros.")
                        fuel = int(avion.planeinput("Ingrese cantidad de combustible: "))
                        avion.actualFuel = avion.actualFuel + fuel
                else:
                        avion.planeprint("Peso excedido. Disminuir la cantidad de pasajeros.")
                        avion.pasajeros = avion.planeinput("Ingrese la cantidad de pasajeros en el vuelo (se recomienda no agregar más de "+ str(int((avion.pesoMax-avion.pesoActual)/75)) +" pasajeros):")
                check = stub.checkTakeoff(avion.getPlanedata())
        auth = stub.requestTakeoff(avion.getDepartingPlane(dest))
        avion.rwy = auth.runway
        avion.planeprint("Pidiendo instrucciones para despegar...")
        if(avion.rwy==-1):
                if(auth.preCode==""):
                        avion.planeprint("Pista ocupada, mantener posición hasta nuevo aviso.")
                else:
                        avion.planeprint("En cola de despegue, antecedido por "+ auth.preCode + ", mantener posición hasta nuevo aviso.")
                while(avion.rwy==-1):
                        pass
        avion.planeprint("Todos los pasajeros a bordo y combustible cargado.")
        avion.planeprint("Puertas en automático, cross check y reportar")
        avion.planeprint("Cabina asegurada")
        avion.planeprint("Autorizados para despegar en pista " + str(avion.rwy))
        avion.planeinput("Presione enter para despegar")
        aeropuerto = stub.takeoff(avion.getDepartingPlane(dest))
        avion.torre = str(aeropuerto.ip) + ":" +  str(aeropuerto.port)
        


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

avion = input("Bienvenido al vuelo!\nNombre de la Aerolínea y número de Avión:\n").split()
aerolinea = avion[0]
numero = avion[1]
peso = int(input("Peso Máximo de carga [kg]:\n"))
combustible = int(input("Capacidad del tanque de combustible [lt]:\n"))
torre_inicial = input("Torre de Control inicial:\n")
torre_inicial = torre_inicial + ":50051"
ip = "192.168.10.2"
port = int(input("Puerto servidor: "))
altura = 10000
plane = Avion(aerolinea, numero,0,combustible,peso,altura,torre_inicial,0,ip,port)
server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
add_planeHostServicer_to_server(Airplane(plane),server)
server.add_insecure_port('0.0.0.0:'+str(port))
server.start()
continuar = "s"
while(continuar=="s"):
        aterrizar(plane)
        despegar(plane)
        continuar = input("¿Desea continuar volando? (s/n)")
print("El avión " + plane.numero + " ha sido derribado!!")