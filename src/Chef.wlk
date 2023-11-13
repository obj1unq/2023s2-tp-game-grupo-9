import wollok.game.*
import extras.*
import Mesada.*
import Ingrediente.*


class Movement{
  var property position = game.at(2, 5)
  var property orientacion = down
  var property image = 'player-' + orientacion.text() + '.png'
  
  method actualizarImagen() {
		image = 'player-' + orientacion.text() + '.png'
  }
	
  method arriba() {
    orientacion = up
    self.actualizarImagen()
    self.movement()
  }

  method abajo() {
    orientacion = down
    self.actualizarImagen()
    self.movement()
  }

  method izquierda() {
    orientacion = left
    self.actualizarImagen()
    self.movement()
  }

  method derecha() {
    orientacion = right
    self.actualizarImagen()
    self.movement()
  }

  method obtenerSuperficieDelante() 
    // Implementar en chef esta lógica para obtener la superficie delante
    // del movimiento.
  

  method actualizarPosicion(objetoEnMano) {
    // Implementar en chef esta lógica para actualizar la posición
    // del movimiento.
  }
  
  method movement(){
  	// Implementar en chef
  }

}


class Chef inherits Movement {	
	var superficieDelante = null
	var objetoEnMano = null

	method haySuperficieDelante() {
		return game.getObjectsIn(orientacion.mover(position)).any({ e => e.esSuperficie()})
	}

	override method obtenerSuperficieDelante() {
		return game.getObjectsIn(orientacion.mover(position)).find({ e => e.esSuperficie()})
	}

	method actualizarSuperficieDelante() {
		if (self.haySuperficieDelante()) {
			superficieDelante = self.obtenerSuperficieDelante()
		} else {
			superficieDelante = null
		}
	}

	override method movement(){
		if (self.haySuperficieDelante()) {
			superficieDelante = self.obtenerSuperficieDelante()
		} else {
			superficieDelante = null
			position = orientacion.mover(position)
			self.actualizarSuperficieDelante()
		}
		self.actualizarPosicion(objetoEnMano)
	}

	method objetoEnMano() = objetoEnMano

	override method actualizarPosicion(unObjeto) {
		if (unObjeto != null) {unObjeto.position(orientacion.mover(position))}
	}


	method dejarObjeto() {
		superficieDelante.apoyar(objetoEnMano)
		objetoEnMano = null
	}

	method accion() {
		superficieDelante.accion()
	}

	method agarrarObjeto() {
		objetoEnMano = superficieDelante.objetoApoyado()
		self.actualizarPosicion(objetoEnMano)
		if (superficieDelante.esDespensa() and !superficieDelante.estaOcupada()) {
			game.addVisual(objetoEnMano)
		}
		superficieDelante.sacar()
	}

	method agarrarOSoltarObjeto() {
		if (objetoEnMano == null) {
			self.agarrarObjeto()
		} else {
			self.dejarObjeto()		
		}
	}
	
	method activar(pocion){
		pocion.aplicarBeneficio()
		game.removeVisual(pocion)
	}
	
	method posicionDelante() {
		return 
			orientacion.mover(position)

	}
}

//Directions
class Direction {method text() method mover(position)}

object up inherits Direction   { 
	override method text() = "up"    override method mover(position){return position.up(1)}
}
object right inherits Direction{	override method text() = "right" override method mover(position){ return position.right(1)}}
object down inherits Direction {    override method text() = "down"  override method mover(position){ return position.down(1)}}
object left inherits Direction {	override method text() = "left"  override method mover(position){ return position.left(1)}}



