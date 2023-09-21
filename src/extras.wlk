import wollok.game.*


object tabla{
	method image() {
		return "tabla.png"
	}
	
	method position() {
		return game.at(1,9)
	}
}



//Posibles estados de alimentos
object cortado{}

object lavado{}

object cocido{}

object llevadoEnMano {

	var property chef = null
	
	method position() {
		return chef.position()
	}
	
	method position(_position) {
		self.error("me estan llevando")
	}
		
}

object libre {
	var property position = game.at(7,1)

}

object almacenDeTomate{
	const property position = game.at(7,1)
	const property alimentoAlmacenado = tomate
	
	method abastecer(_chef){
		_chef.agarrarAlimento(alimentoAlmacenado)
	}
}


object tomate{
	var property image = "tomate.png"
	var property estado = libre
	var property position  = game.at(7,1)
	
	method position(){
		return estado.position()
	}
	
	method position(_position){
		estado.position(_position)
	}
	
	method serLlevado(_jugador) {
		llevadoEnMano.chef(_jugador)
		estado = llevadoEnMano	
	}
	
	method dejarLlevada() {
		libre.position(self.position())
		estado = libre
	}
	
}



/** 
object lechuga{
	var property image = "lechuga.png"
	var property estado 
	var property position  = game.at(9,1)
	
	
} 

object cebolla {
	
	var property image = "cebolla.png"
	var property estado
	var property position  = game.at(8,1)
	
	
}
object almacenDeLechuga{
	const property position  = game.at(9,1)
	const property alimentoAlmacenado = lechuga
	method abastecer(_chef){
		_chef.agarrarAlimento(alimentoAlmacenado)
	}
}
object almacenDeCebolla{
	const property position  = game.at(8,1)
	const property alimentoAlmacenado = cebolla
	method abastecer(_chef){
		_chef.agarrarAlimento(alimentoAlmacenado)
	}
}
*/

object horno{
	
	var property image = "horno.png"
	var property position  = game.at(1,1)
	
	
	
}

