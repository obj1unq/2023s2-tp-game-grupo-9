class Ingrediente {

	var property position
	var property estado = fresco
	var property nombre
	var property esCortable = true
	var property esCocinable = false

	method image() = nombre + estado.nombre() + ".png"

	method cortar() {
		self.validarCortar()
		estado = cortado
	}

	method cocinar() {
		self.validarCocinar()
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

