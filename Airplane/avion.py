from concurrent import futures
from math import ceil
from random import randint
from torreServer_pb2 import *
from torreServer_pb2_grpc import *


class Avion():
        def __init__(self,aerolinea,numero,pasajeros,combustible,peso,altura,torre,rwy,ip,puerto):# Inicializacion del avion
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
                self.actualFuel = int(randint(int((1/5)*combustible),combustible)) # Inicializa combustible entre 1/5 de la capacidad del tanque y su capacidad maxima.
                self.pesoActual = self.actualFuel + self.pasajeros*75 #Peso depende de combustible y pasajeros

        def planeprint(self, mensaje): # Imprime el tag [Avion - callsign] y agrega un mensaje
                print("[Avión - " + self.numero + "] " + mensaje)

        def planeinput(self, mensaje): # Igual que la anterior , pero usada para un input.
                return input("[Avión - " + self.numero + "] " + mensaje)

        def getPlanedata(self): #retorna PlaneData ya instanciado
                return PlaneData(code=self.numero, currFuel = self.actualFuel, maxFuel = self.maxFuel, currWeight= self.pesoActual, maxWeight=self.pesoMax)

        def getDepartingPlane(self, destino): #retorna un DepartingPlane instanciado
                return DepartingPlane(code=self.numero, runway = self.rwy, airportName = destino, height = self.altura)

        def getArrivingPlane(self): #retorna un ArrivingPlane instanciado
                return ArrivingPlane(code=self.numero, srcAirport=self.torre,ip= self.ip, port = self.puerto)
 
        def revisarPeso(self): #revisa si se debe quitar combustible y/o pasajeros
                self.planeprint("¡¡¡¡ Peso excedido !!!!")              
                if(self.actualFuel == int((4/5)*self.maxFuel)): #si no se puede quitar combustible, solo pasajeros
                        minimo =  int(ceil((self.pesoActual - self.pesoMax)/75)) #minima cantidad de pasajeros que deben ser bajados
                        self.planeprint("Deben bajarse al menos " + str(minimo) + " pasajeros.")
                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos (entre " + str(minimo) +" y " + str(self.pasajeros) + " ): "))
                        while(1): #loop para que se ingrese un valor dentro de los limites
                                if(pas<minimo):
                                        self.planeprint("Error: Deben bajarse al menos " + str(minimo) + " pasajeros.")
                                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos (entre " + str(minimo) +" y " + str(self.pasajeros) + " ): "))
                                elif(pas>int(self.pasajeros)):
                                        self.planeprint("Error: No pueden bajarse más pasajeros de los que hay actualmente.")
                                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos (entre " + str(minimo) +" y " + str(self.pasajeros) + " ): "))
                                else:
                                        self.pasajeros = int(self.pasajeros) - pas #actualizar el valor de pasajeros
                                        break

                elif(self.pesoActual-(self.actualFuel-(4/5)*self.maxFuel)<=self.pesoMax): #si es suficiente reduciendo el combustible hasta a lo mas 4/5 de su capacidad.
                        minimo = int(self.pesoActual - self.pesoMax) #minimo combustible que debe ser reducido
                        self.planeprint("El combustible debe disminuise al menos " + str(minimo) + " litros.")
                        fuel = int(self.planeinput("Ingrese la cantidad de combustible a disminuir ( entre " + str(minimo) + " y " + str(int(self.actualFuel-(4/5)*self.maxFuel))+ "):"))
                        while(1): #loop para que se ingrese un valor dentro de los limites
                                if(fuel<minimo):
                                        self.planeprint("Error: El combustible debe disminuise al menos " + (minimo) + " litros.")
                                        fuel = int(self.planeinput("Ingrese la cantidad de combustible a disminuir ( entre " + str(minimo) + " y " + str(int(self.actualFuel-(4/5)*self.maxFuel))+ ")"))
                                elif(fuel > self.actualFuel-(4/5)*self.maxFuel):
                                        self.planeprint("Error: El combustible no puede disminuirse más de " + str(self.actualFuel-(4/5)*self.maxFuel) + " litros.")
                                        fuel = int(self.planeinput("Ingrese la cantidad de combustible a disminuir ( entre " + str(minimo) + " y " + str(int(self.actualFuel-(4/5)*self.maxFuel))+ ")"))
                                else:
                                        self.actualFuel = self.actualFuel - fuel #actualizar el valor de combustible

                elif(self.pesoActual-(self.actualFuel-(4/5)*self.maxFuel)>self.pesoMax): #reducir el combustible a 4/5 de su capacidad y ademas bajar pasajeros
                        minimo = int(ceil(((self.pesoActual-(self.actualFuel-(4/5)*self.maxFuel))-self.pesoMax)/75)) #minima cantidad de pasajeros que deben bajarse
                        self.planeprint("Se debe reducir el combustible en " + str(int(self.actualFuel-(4/5)*self.maxFuel)) +" litros, deben bajarse al menos " + str(minimo)+ " pasajeros!")
                        self.actualFuel = int((4/5)*self.maxFuel) #actualizar el valor del combustible a 4/5 de su capacidad maxima
                        self.planeprint("Se ha reducido el combustible!!")
                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos (entre " + str(minimo) +" y " + str(self.pasajeros) + " ): "))
                        while(1): #loop para que se ingrese un valor dentro de los limites
                                if(pas<minimo):
                                        self.planeprint("Error: Deben bajarse al menos " + str(minimo) + " pasajeros.")
                                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos (entre " + str(minimo) +" y " + str(self.pasajeros) + " ): "))
                                elif(pas>int(self.pasajeros)):
                                        self.planeprint("Error: No pueden bajarse más pasajeros de los que hay actualmente.")
                                        pas = int(self.planeinput("Ingrese cantidad de pasajeros que serán descendidos (entre " + str(minimo) +" y " + str(self.pasajeros) + " ): "))
                                else:
                                        self.pasajeros = int(self.pasajeros) - pas #actualizar los pasajeros
                                        break
                self.actualizarPeso() #actualizar el peso del avion

        def actualizarPeso(self): # funcion para actualizar el peso del avion segun su combustible y la cantidad de pasajeros
                self.pesoActual = int(self.actualFuel) + int(self.pasajeros)*75

        def repostar(self): # funcion para repostar combustible y verificar que no se exceda la capacidad maxima del tanque de combustible
                fuel = int(self.planeinput("Ingrese cantidad de combustible: se pueden cargar a lo más "+ str(self.maxFuel-self.actualFuel) + " litros: "))
                while(fuel>self.maxFuel-self.actualFuel): #Verificar limites
                        fuel = int(self.planeinput("Capacidad máxima excedida, ingresar un valor entre 0 y "+ str(self.maxFuel-self.actualFuel) + " litros: "))
                self.actualFuel = int(self.actualFuel + fuel) #actualizar el combustible        
                self.actualizarPeso()#actualizar el peso del avion

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
        
        def updateInfo(self, resp):
                self.altura = resp.height
                self.rwy = resp.runway

def aterrizar(avion):
    with grpc.insecure_channel(avion.torre) as channel:
        stub = towerHostStub(channel)
        avion.planeinput("Presione enter para aterrizar")
        avion.planeprint(avion.numero +", establecidos en radial de pista.")
        respuesta =stub.requestLanding(avion.getArrivingPlane())
        avion.updateInfo(respuesta)

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
        avion.updateInfo(auth)
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
                self.avion.altura = request.height
                return Empty()

avion = input("Bienvenido al vuelo!\nNombre de la Aerolínea y número de Avión:\n").split()
aerolinea = avion[0]
numero = avion[1]
peso = int(input("Peso Máximo de carga [kg]:\n"))
combustible = int(input("Capacidad del tanque de combustible [lt] (debe ser a lo sumo " + str(peso) + " [lt]):\n"))
while(1):
        if(combustible>peso):
                print("Caracteristica no compatible con peso del avion. Capacidad debe ser a lo sumo " + str(peso) + " [lt] ")
                combustible = int(input("Capacidad del tanque de combustible [lt]:\n"))
        else:
                break


#MAIN
ip = input("IP del avión:\n")
port = int(input("Puerto servidor del avión:\n"))
torre_inicial = input("Torre de Control inicial:\n")
port1 = input("Puerto de la Torre de Control:\n")
torre_inicial = torre_inicial + ":" + str(port1)
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
        continuar = plane.planeinput("¿Desea continuar volando? (s/n)")

plane.planeprint("El avión " + plane.numero + " ha terminado su vuelo!!")