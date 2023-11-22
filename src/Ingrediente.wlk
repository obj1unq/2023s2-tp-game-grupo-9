import wollok.game.*
class Ingrediente {

	var property position= game.at(0,0)
	var property estado = fresco
	var property esCortable = true
	var property esCocinable = false
	var property esSuperficie = false
	const property esPlato = false
	
	method nombre()

	method image() = self.nombre() + estado.nombre() + ".png"

	method cortar() {
		self.validarCortar()
		esCortable = false
		estado = cortado
	}

	method cocinar() {
		self.validarCocinar()
		self.validarEstado()
		esCocinable = false
		estado = cocinado
	}

	method validarCortar() {
		if (not esCortable) {
			self.error("No se puede cortar")
		}
	}

	method validarCocinar() {
		if (not esCocinable) {
			self.error("No se puede cocinar")
		}
	}

	method validarEstado() {
		if (estado != cortado) {
			self.error("No se puede cocinar")
		}
	}

}

// El pan sale cortado de la dispensa.
class Pan inherits Ingrediente {
	
	override method nombre() = "pan"
	
	override method esCortable() = false
	
	override method estado() = fresco

}

// Tanto el tomate como la lechuga son cortables pero no cocinables.
class Tomate inherits Ingrediente {
	
	override method nombre() = "tomate"
	
	override method estado() = fresco

}

class Lechuga inherits Ingrediente {
	
	override method nombre() = "lechuga"
	
	override method estado() = fresco

}

// La carne es el único ingrediente que se puede cortar y cocinar. Se tiene que cortar para poder cocinarse.
class Carne inherits Ingrediente {
	
	override method nombre() = "carne"
	
	override method esCocinable() = true
	
	override method estado() = fresco

}

// Estados
object fresco {

	method nombre() = ""
	
	method esCortable() = true
	
	method esCocinable() = false

}

object cortado {

	method nombre() = "-cortado"
	
	method esCortable() = false
	
	method esCocinable() = true

}

object cocinado {

	method nombre() = "-cocinado"
	
	method esCortable() = false
	
	method esCocinable() = false

}


//factories 
//object factoryTomate{
//	
//	method nuevo() {
//		return new Ingrediente(nombre="tomate",estado=cortado)
//	}
//}
//
//object factoryLechuga{
//	
//	method nuevo() {
//		return new Ingrediente(nombre="lechuga")
//	}
//}
//
//object factoryPan{
//		method nuevo() {
//		return new Ingrediente(nombre="pan-cortado")
//	}
//}
//
//object factoryCarne{
//		method nuevo() {
//		return new Ingrediente(nombre="carne", estado=cocinado)
//	}
//}

