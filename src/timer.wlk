import wollok.game.*

object timer {
	var property image= "assets/temporalizador.jpg"
	var property tiempo = 120
	//var property temporalizadorActivo
	
		method descontarTiempo(){
		if (tiempo > 0){
				self.tiempoRestante()
		}else  {
			game.removeTickEvent("descontar tiempo")
		}
	}
	
	// if(temporalizadorActivo)
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
	
	//method pausarTemporalizador(){
	//	temporalizadorActivo = false
	//}
	
	//method reanudarTemporalizador(){
	//	temporalizadorActivo= true
	//	self.descontarTiempo()
	//}
	
}
