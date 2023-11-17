import wollok.game.*
class Ingrediente {

	var property position= game.at(0,0)
	var property estado = fresco
	var property nombre
	var property esCortable = true
	var property esCocinable = false
	var property esSuperficie = false
	const property esPlato = false

	method image() = nombre + estado.nombre() + ".png"

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
		if (!esCortable) {
			self.error("No se puede cortar")
		}
	}

	method validarCocinar() {
		if (!esCocinable) {
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

	method initialize() {
		nombre = "pan"
		esCortable = false
		estado = cortado
	}

}

// Tanto el tomate como la lechuga son cortables pero no cocinables.
class Tomate inherits Ingrediente {

	method initialize() {
		nombre = "tomate"
		esCortable = true
		estado = fresco
	}

}

class Lechuga inherits Ingrediente {

	method initialize() {
		nombre = "lechuga"
		esCortable = true
		estado = fresco
	}

}

// La carne es el único ingrediente que se puede cortar y cocinar. Se tiene que cortar para poder cocinarse.
class Carne inherits Ingrediente {

	method initialize() {
		nombre = "carne"
		esCortable = true
		esCocinable = true
		estado = fresco
	}

}

// Estados
object fresco {

	method nombre() = ""

}

object cortado {

	method nombre() = "-cortado"

}

object cocinado {

	method nombre() = "-cocinado"

}


//factories 
object factoryTomate{
	
	method nuevo() {
		return new Ingrediente(nombre="tomate",estado=cortado)
	}
}

object factoryLechuga{
	
	method nuevo() {
		return new Ingrediente(nombre="lechuga")
	}
}

object factoryPan{
		method nuevo() {
		return new Ingrediente(nombre="pan-cortado")
	}
}

object factoryCarne{
		method nuevo() {
		return new Ingrediente(nombre="carne", estado=cocinado)
	}
}

