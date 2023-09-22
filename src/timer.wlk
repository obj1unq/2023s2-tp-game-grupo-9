import wollok.game.*

object timer {
	var property image= "assets/timer.png"
	var property tiempoSeg = 60
	var property tiempoMin = 1
	
	method text(){
		return tiempoMin.toString() + ":" + tiempoSeg.toString()
	}
	
	method descontar(){
		if (not self.esCero(tiempoSeg)){
			tiempoSeg -= 1}
			else if (self.esCero(tiempoSeg) &&  not self.esCero(tiempoMin)){
				tiempoMin -=1
				tiempoSeg = 59
			}else {
				game.removeTickEvent("descontar")
			}
	}
	
	method esCero(t) {
		return t == 0
	}
}
