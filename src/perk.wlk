import wollok.game.*
import randomizer.*
import timer.*


object perk {
	const property position=randomizer.emptyPosition()
	
	method image(){
		return "perk_congelar.png"
	}
	
	method aparicion(){
		game.addVisual(self)
	}
	
	method aplicarBeneficio(){
		timer.pausarTemporalizador()
	}
	
	method esActivada(personaje){
		personaje.activar(self)
	}
}


