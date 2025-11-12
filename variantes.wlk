import nave.*

class Hospital inherits Pasajeros{
  var quirofanoPreparado=false

  method prepararQuirofano() {
    quirofanoPreparado=true
  }
  method quirofanoPreparado() = quirofanoPreparado
  override method estaTranquila()= super() and !quirofanoPreparado
  override method recibirAmenaza(){
    super()
    self.prepararQuirofano()
  }
}

class Sigilosa inherits Combate {
  override method estaTranquila ()=super() and self.estaVisible() 
  override method escapar(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}