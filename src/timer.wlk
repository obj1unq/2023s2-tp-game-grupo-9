import wollok.game.*

object timer {
	var property image= "assets/timer.jpg"
	var property tiempo = 120
	var property temporalizadorActivo = true
	
		method descontarTiempo(){
		if (tiempo > 0 && temporalizadorActivo){
				self.tiempoRestante()
		}else if (temporalizadorActivo){
			game.removeTickEvent("descontar tiempo")
		}
	}
	
	method tiempoRestante(){
			tiempo -=1
	}

	method minutos(t){
		return t.div(60)
	}
	
	method segundos(t){
		return t % 60
	}

	method text (){
		return self.minutos(tiempo).toString() + ":" + self.segundos(tiempo).toString()
	}
	
	method textColor() ="#4c2882"
	
	method pausarTemporalizador(){
		temporalizadorActivo = false
		game.schedule(15000,{=> self.reanudarTemporalizador()})
	}
	
	method reanudarTemporalizador(){
		temporalizadorActivo= true
		self.descontarTiempo()
	}
	
}
