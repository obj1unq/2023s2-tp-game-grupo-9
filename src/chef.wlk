import wollok.game.*
import direcciones.*
import extras.*

object chef {
	var alimentoEnMano  //Aqui cambia segun el alimento
	var property position  = game.at(2, 5)
	
	
	method abastecerse(alimento){
		self.agarrarAlimento(alimento)
	}
	
	method agarrarAlimento(alimento) {
		self.validarPosition(alimento)
		alimento.serLlevado(self)
	}
	
	method dejarAlimento(alimento){
		alimento.dejarLlevada()
	}
	
	method validarPosition(algo) {
		if(position != algo.position()) {
			self.error("No estoy donde puedo hacerlo")
		}
	}
	
	method terminar() {

	}
	
	method image() {
		return "assets/chef.png"
	}
	
	
	method textColor() {
		return "FF0000FF"
	}
	

	method position() {
		return position
	}

	method position(_position) {
		position = _position
	}

	
	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}
	
	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima) 
	}
	
	method validarMover(direccion) {
		if(not self.sePuedeMover(direccion)) {
			self.error("No puedo ir ahí")
		} 
	}
	
	method mover(direccion) {
		self.validarMover(direccion)
		const proxima = direccion.siguiente(self.position())		
		self.position(proxima)		
	}
}


