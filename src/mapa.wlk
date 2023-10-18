import wollok.game.*
import extras.*
import timer.*
import Mesada.*
import Chef.*
import Ingrediente.*

object _ {
	method generar(position) {
	}	
}

object m {
	method generar(position) {
		game.addVisual(new Mesada(position=position))
	}			
}

object d {
		method generar(position) {
		game.addVisual(new Despensa(position=position))
	}	
}

object dp {
		method generar(position) {
		game.addVisual(new DespensaDePan(position=position))
	}	
}

object dt {
		method generar(position) {
		game.addVisual(new DespensaDeTomate(position=position))
	}	
}

object dl {
		method generar(position) {
		game.addVisual(new DespensaDeLechuga(position=position))
	}	
}

object dc {
		method generar(position) {
		game.addVisual(new DespensaDeCarne(position=position))
	}	
}

object tc {
		method generar(position) {
		game.addVisual(new TablaDeCortar(position=position))
	}	
}

object pl {
		method generar(position) {
		game.addVisual(new Plancha(position=position))
	}	
}

object tch {
	method generar(position) {
		game.addVisual(new Tacho(position=position))
	}	
}

object dpl {
	method generar(position) {
		game.addVisual(new DespensaDePlato(position=position))
	}
}

object mapa {
	
	const celdas = [
		[m,m,_,_,m,m,m,m,_,pl,pl,pl,m],
		[dt,_,_,_,_,_,_,_,_,_,_,_,m],
		[dc,_,_,_,_,_,_,_,_,_,_,_,m],
		[dl,_,_,_,_,_,_,_,_,_,_,_,m],
		[dp,_,_,_,_,_,_,_,_,_,_,_,m],		
		[m,_,_,_,_,_,_,_,_,_,_,_,dpl],		
		[tch,_,_,_,_,_,_,_,_,_,_,_,m],
		[m,m,tc,m,tc,m,m,m,m,m,m,m,m]	
	].reverse()
	
	
	
	method generar() {
		game.width(celdas.anyOne().size())
		game.height(celdas.size())
		(0..game.width() -1).forEach({x =>
			(0..game.height() -1).forEach( {y =>
				self.generarCelda(x,y)
			})
		})
		
	}
	
	method generarCelda(x,y) {
		const celda = celdas.get(y).get(x)
		celda.generar(game.at(x,y))
	}
	
}