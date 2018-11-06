import grpc
from random import *
from math import *
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
                self.pasajeros = int(pasajeros)
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

        def revisarPeso(self):
                self.planeprint("¡¡¡¡ Peso excedido !!!!")              
                if(self.actualFuel == (4/5)*self.maxFuel):
                        minimo =  int(ceil((self.pesoActual - self.pesoMax)/75))
                        self.planeprint("Deben bajarse al menos " + str(minimo) + " pasajeros.")
                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos: (entre " + str(minimo) +" y " + str(self.pasajeros) + " )"))
                        while(1):
                                if(pas<minimo):
                                        self.planeprint("Error: Deben bajarse al menos " + str(minimo) + " pasajeros.")
                                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos: (entre " + str(minimo) +" y " + str(self.pasajeros) + " )"))
                                elif(pas>int(self.pasajeros)):
                                        self.planeprint("Error: No pueden bajarse más pasajeros de los que hay actualmente.")
                                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos: (entre " + str(minimo) +" y " + str(self.pasajeros) + " )"))
                                else:
                                        self.pasajeros = int(self.pasajeros) - pas
                                        break
                elif(self.pesoActual-(self.actualFuel-(4/5)*self.maxFuel)<=self.pesoMax):
                        minimo = self.pesoActual - self.pesoMax
                        self.planeprint("El combustible debe disminuise al menos " + str(minimo) + " litros.")
                        fuel = int(self.planeinput("Ingrese la cantidad de combustible a disminuir ( entre " + str(minimo) + " y " + str(self.actualFuel-(4/5)*self.maxFuel)+ ")"))
                        while(1):
                                if(fuel<minimo):
                                        self.planeprint("Error: El combustible debe disminuise al menos " + (minimo) + " litros.")
                                        fuel = int(self.planeinput("Ingrese la cantidad de combustible a disminuir ( entre " + str(minimo) + " y " + str(self.actualFuel-(4/5)*self.maxFuel)+ ")"))
                                elif(fuel > self.actualFuel-(4/5)*self.maxFuel):
                                        self.planeprint("Error: El combustible no puede disminuirse más de " + str(self.actualFuel-(4/5)*self.maxFuel) + " litros.")
                                        fuel = int(self.planeinput("Ingrese la cantidad de combustible a disminuir ( entre " + str(minimo) + " y " + str(self.actualFuel-(4/5)*self.maxFuel)+ ")"))
                                else:
                                        self.actualFuel = self.actualFuel - fuel
                elif(self.pesoActual-(self.actualFuel-(4/5)*self.maxFuel)>self.pesoMax):
                        self.planeprint("Se debe reducir el combustible en " + str(self.actualFuel-(4/5)*self.maxFuel) +" litros, deben bajarse al menos " + str(int(ceil(((self.pesoActual-(self.actualFuel-(4/5)*self.maxFuel))-self.pesoMax)/75)))+ " pasajeros!")
                        self.actualFuel = (4/5)*self.maxFuel
                        self.planeprint("Se ha reducido el combustible!!")
                        minimo = int(ceil(((self.pesoActual-(self.actualFuel-(4/5)*self.maxFuel))-self.pesoMax)/75))
                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos: (entre " + str(minimo) +" y " + str(self.pasajeros) + " )"))
                        while(1):
                                if(pas<minimo):
                                        self.planeprint("Error: Deben bajarse al menos " + str(minimo) + " pasajeros.")
                                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos: (entre " + str(minimo) +" y " + str(self.pasajeros) + " )"))
                                elif(pas>int(self.pasajeros)):
                                        self.planeprint("Error: No pueden bajarse más pasajeros de los que hay actualmente.")
                                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos: (entre " + str(minimo) +" y " + str(self.pasajeros) + " )"))
                                else:
                                        self.pasajeros = int(self.pasajeros) - pas
                                        break
                self.actualizarPeso()

        def actualizarPeso(self):
                self.pesoActual = int(self.actualFuel) + int(self.pasajeros)*75

        def repostar(self):
                fuel = int(self.planeinput("Ingrese cantidad de combustible: se pueden cargar a lo más "+ str(self.maxFuel-self.actualFuel) + " litros: "))
                while(fuel>self.maxFuel-self.actualFuel):
                        fuel = int(self.planeinput("Capacidad máxima excedida, ingresar un valor entre 0 y "+ str(self.maxFuel-self.actualFuel) + " litros: "))
                self.actualFuel = int(self.actualFuel + fuel)
                self.actualizarPeso()

        def subirPasajeros(self):
                self.pasajeros = self.planeinput("Ingrese la cantidad de pasajeros en el vuelo (se recomienda no agregar más de "+ str(int((self.pesoMax-self.pesoActual)/75)) +" pasajeros):")
                self.actualizarPeso()

        def verAltura(self):
                return str(self.altura*200 + 3000)

        def takeoffMsg(self):
                self.planeprint("Todos los pasajeros a bordo y combustible cargado.")
                self.planeprint("Puertas en automático, cross check y reportar")
                self.planeprint("Cabina asegurada")
                self.planeprint("Autorizados para despegar en pista " + str(self.rwy) + " y mantener " +  self.verAltura() +" pies.")
                self.planeinput("Presione enter para despegar")
                self.planeprint("¡¡ Despegados !!")

        def landingMsg(self,aeropuerto):
                self.planeprint("Autorizados para aterrizar en pista " + str(self.rwy))
                self.planeprint("¡¡¡¡Bienvenidos a " + aeropuerto + "!!!!")

        def landingSetup(self):
                self.pasajeros = 0
                self.planeprint("Pasando por el Gate...")
                self.planeprint("Pasajeros han descendido del avión.")
                self.actualFuel = self.actualFuel - randint(int(self.actualFuel*1/5), self.actualFuel)
                self.actualizarPeso()
                
def aterrizar(avion):
    with grpc.insecure_channel(avion.torre) as channel:
        stub = towerHostStub(channel)
        avion.planeinput("Presione enter para aterrizar")
        avion.planeprint(avion.numero +", establecidos en radial de pista.")
        respuesta =stub.requestLanding(avion.getArrivingPlane())
        avion.altura = respuesta.height
        avion.rwy = respuesta.runway
        if(avion.rwy==-1):
                if(respuesta.preCode==""):
                        avion.planeprint("Pista ocupada, mantener " + avion.verAltura() + " pies a la espera de autorización.")
                else:
                        avion.planeprint("En cola de aterrizaje, antecedido por "+ respuesta.preCode + ", mantener " + avion.verAltura() + " pies")
                while(avion.rwy==-1):
                        pass
        avion.landingMsg(respuesta.airportName)
        avion.landingSetup()

def despegar(avion):
    with grpc.insecure_channel(avion.torre) as channel:
        stub = towerHostStub(channel)
        avion.planeprint("Combustible: " + str(avion.actualFuel) + "/" + str(avion.maxFuel) + " Peso: " + str(avion.pesoActual) + "/" + str(avion.pesoMax))
        carga = avion.planeinput("¿Desea cargar combustible? (se debe despegar con 4/5 del combustible máximo)(s/n)")
        if(carga=="s"):
                avion.repostar()
        avion.subirPasajeros()
        avion.planeinput("Presione enter para solicitar pista de despegue.")
        dest = avion.planeinput("Ingrese destino: ")
        check = stub.checkTakeoff(avion.getPlanedata()) 
        avion.planeprint("Verificando combustible y peso del avión!!.")
        while(check.errorCode != 0):
                if(check.errorCode == 1):
                        avion.planeprint("Combustible insuficiente! El tanque debe estar al menos a 4/5 de capacidad máxima, se deben cargar por lo menos " + str((avion.maxFuel*4/5)-avion.actualFuel) + " litros.")
                        avion.repostar()      
                else:
                        avion.revisarPeso()
                check = stub.checkTakeoff(avion.getPlanedata())
        auth = stub.requestTakeoff(avion.getDepartingPlane(dest))
        avion.altura = auth.height
        avion.rwy = auth.runway
        avion.planeprint("Pidiendo instrucciones para despegar...")
        if(avion.rwy==-1):
                if(auth.preCode==""):
                        avion.planeprint("Pista ocupada, mantener posición hasta nuevo aviso.")
                else:
                        avion.planeprint("En cola de despegue, antecedido por "+ auth.preCode + ", mantener posición hasta nuevo aviso.")
                while(avion.rwy==-1):
                        pass
        avion.takeoffMsg()
        aeropuerto = stub.takeoff(avion.getDepartingPlane(dest))
        avion.torre = str(aeropuerto.ip) + ":" +  str(aeropuerto.port)
        


class Airplane(planeHostServicer):
        def __init__(self,plane):
                self.avion = plane
        def notifyLanding(self, request, context):
                self.avion.rwy = request.runway
                return planeHeight(height=self.avion.altura)
        def notifyDeparture(self, request, context):
                self.avion.rwy = request.runway
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