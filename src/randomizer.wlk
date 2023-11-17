import wollok.game.*

class Randomizer {
		
	method position(){
		return 	game.at( 
			self.ancho(), self.alto()
		) 
	}
	
	method ancho()
	
	method alto() = (0..  game.height() - 1).anyOne()
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}

}
					

object positionPerk inherits Randomizer{
	
	override method ancho(){
		return (0 .. 12 ).anyOne()
	}
}

object positionPedido inherits Randomizer {
	
	override method ancho(){
		return game.width() - 2
	}
}