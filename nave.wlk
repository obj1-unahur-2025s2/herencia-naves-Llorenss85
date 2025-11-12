class Nave{
  var velocidad
  var direccionRespectoAlSol
  var combustible=0
  method controlDeVelocidad(cuanto) = cuanto.min(100000)
  method acelerar(cuanto) {
    velocidad+=self.controlDeVelocidad(cuanto)
  }
  method controlDeBajaVelocidad(cuanto) =cuanto.min(0)
  method desacelerar(cuanto) {
    velocidad-=self.controlDeBajaVelocidad(cuanto)
  }
  method irHaciaElSol() {
    direccionRespectoAlSol=10
  } 
  method escaparDelSol() {
    direccionRespectoAlSol=-10
  }
  method ponerseParaleloAlSol() {
    direccionRespectoAlSol=0    
  }
  method acercarseUnPocoAlSol() {
    if(direccionRespectoAlSol<10){
      direccionRespectoAlSol+=1
    }
  }
  method alejarseUnPocoDelSol() {
    if(direccionRespectoAlSol >-10){
      direccionRespectoAlSol-=1
    }    
  }
  method prepararViaje(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  method cargarCombustible(unaCant) {
   combustible+=unaCant
  }
  method descargarCombustible(unaCant) {
   combustible-=unaCant
  }
  method estaTranquila() =(combustible <= 4000) and (velocidad < 12000)  
  method escapar()
  method avisar() 
  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }
  method tienePocaActividad()  
  method estaRelajao() = self.estaTranquila() and self.tienePocaActividad() 
}

class Beliza inherits Nave{
  var colorActual="verde"
  var colorOriginal=true

  method cambiarColorBaliza(unColor) {
    colorActual=unColor
    colorOriginal=false
  }
  override method prepararViaje(){
    super()
    colorActual="verde"
    colorOriginal=false
    self.ponerseParaleloAlSol()
  }
  override method escapar(){
    self.irHaciaElSol()
  }
  override method avisar(){
    colorActual="rojo"
    colorOriginal=false
  }
  override method estaTranquila()=super() and colorActual!="rojo"
  override method tienePocaActividad()= colorOriginal

}

class Pasajeros inherits Nave{
  const cantidadPasajeros
  var cantRacionesComida
  var racionesSerividas
  var bebidasSerividas
  var cantBebidas
  method cargarRaciones(unaCant) {
    cantRacionesComida+=unaCant  
  }
  method servirRacion(unaCant) {
    racionesSerividas+=unaCant
    self.descargarRaciones(unaCant)
  }
  method servirBebida(unaCant) {
    bebidasSerividas+=unaCant
    self.descargarBebidas(unaCant)
  }
  method cargarBebidas(unaCant) {
    cantBebidas+=unaCant
  }
  method descargarRaciones(unaCant) {
    cantRacionesComida-=unaCant  
  }
  method descargarBebidas(unaCant) {
    if(cantBebidas-unaCant>=0){
      cantBebidas-=unaCant
    }
  }

  override method prepararViaje(){
    super()
    self.cargarRaciones(4*cantidadPasajeros)
    self.cargarBebidas(6*cantidadPasajeros)
    self.acercarseUnPocoAlSol()
  }
  override method escapar(){
    self.acelerar(velocidad*2)
  
    self.servirRacion(cantidadPasajeros)
    self.servirBebida(cantidadPasajeros*2)
  }
  override method tienePocaActividad() = racionesSerividas <50 
}
class Combate inherits Nave {
  var estaVisible=false
  var misilesDesplegados=false
  const mensajes=[]
  method ponerseVisible() {
    estaVisible=true
  }
  method ponerseInvisible(){
    estaVisible=false
  }  
  method estaVisible() =estaVisible
  
  method desplegarMisiles() {
    misilesDesplegados=true
  }
  method replegarMisiles() {
    misilesDesplegados=true
  }
  method misilesDesplegados()=misilesDesplegados

  //mensajes
  method emitirMensajes(unMensaje) {
    mensajes.add(unMensaje)
  }
  method mensajesEmitidos() =mensajes
  method primerMensaje() =mensajes.first()
  method ultimoMensaje() =mensajes.last() 
  method esEscueta() =!mensajes.any({m=> m.size() >30}) 
  override method prepararViaje(){
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000 )
    self.emitirMensajes("saliendo en mision")
  }
  override method estaTranquila()= super() and !self.misilesDesplegados() 
  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }
  override method avisar() {self.emitirMensajes("amenaza recibida") }
}
