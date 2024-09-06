object afa {
  var dinero = 0
  method arcas() = dinero
  method realizarPartido(unPartido) {
    dinero = dinero + unPartido.ganancia()
  }
  method iniciar() {
  	game.height(11)
	  game.width(11)
    game.boardGround("fondo.png")
    //game.addVisual(bombonera)
    //game.addVisual(monumental)
    game.addVisual(partido)
    game.addVisual(marcador)
    
    game.addVisualCharacter(messi)
   
    game.schedule(3000,{game.addVisual(ronaldo)})
    game.schedule(10000,{game.removeVisual(ronaldo)})
    keyboard.m().onPressDo({partido.estadio(monumental)})
    keyboard.b().onPressDo({partido.estadio(bombonera)})
    game.onCollideDo(messi, {algo=>algo.teEncontroMessi()})
  }

}

object partido {
  const precioEntrada = 0.01

  var jugador = messi
  var estadio = monumental

  method ganancia() = self.ingresos() - self.gastos()

  method gastos() = estadio.costoFijo() + jugador.viaticos()
  
  method ingresos() = self.cantidadEntradas() * precioEntrada 

  method cantidadEntradas() = jugador.popularidad()/100*estadio.capacidad()
  method jugador(nuevo){
    jugador = nuevo
  }
  method estadio(nuevo){
    estadio = nuevo
  }

  method position() = game.center()
  method image() = estadio.image()
  method teEncontroMessi() {
    game.say(messi,"empieza el partido")
  }
}

object bombonera {
  method capacidad() = 50000
  method costoFijo() = 10

  method position() = game.at(1,5)
  method image() = "bombo.jpg"
}

object monumental {
  var obras = 80
  method capacidad() = 86000*obras/100
  method costoFijo() = 20
  method trabajar(){
    obras = obras + 1
  }
  method position() = game.at(4,5)
  method image() = "monu.jpg"
}

object ronaldo {

  method viaticos() = 10
  method popularidad() = messi.popularidad() / 2 
  
//  method position() = messi.position().down(3).right(1)
  method position() = partido.position().down(3).right(1)
  method image() = if(messi.position().y() > 5) "ronaldo2.png" else "ronaldo.png"

  method teEncontroMessi(){
        game.say(messi,"que mira bobo!")
        partido.jugador(ronaldo)
  }
}

object mbape {

  method viaticos() = 0// lo que sea
  method popularidad() = 0 // lo que sea
}

object messi {
  var property viaticos = 5
  var popularidad = 98
  var lugar = game.origin()
 
 //
  method variacionPopularidad(diferencia){
    popularidad = popularidad + diferencia
  }
  method popularidad() = popularidad

  method position() = lugar
  method position(nueva) {
    lugar = nueva
  }
  method image() = "Messi.png"

}

object marcador{

  method position() = game.at(6,10)
  method text() = "recaudacion: " //+ partido.ganancia()
  method image() = "transparente.png"
}

// afa.arcas()
// partido.ganancia()
// afa.realizarPartido(partido)