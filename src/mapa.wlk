import wollok.game.*
import timer.*
import Mesada.*
import Chef.*
import Ingrediente.*

object _ {
	method generar(position) {}	
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

object mde {
	method generar(position) {
		game.addVisual(new MesaDeEntrega(position=position))
	}
}



object mapa {
	
	const celdas = [
		[m,m,m,m,m,m,m,m,m,pl,pl,pl,m,_,_],
		[dt,_,_,_,_,_,_,_,_,_,_,_,m,_,_],
		[dc,_,_,_,_,_,_,_,_,_,_,_,m,_,_],
		[dl,_,_,_,_,_,_,_,_,_,_,_,mde,_,_],
		[dp,_,_,_,_,_,_,_,_,_,_,_,mde,_,_],		
		[m,_,_,_,_,_,_,_,_,_,_,_,mde,_,_],		
		[tch,_,_,_,_,_,_,_,_,_,_,_,m,_,_],
		[m,m,tc,m,tc,m,m,m,m,m,m,m,m,_,_]	
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