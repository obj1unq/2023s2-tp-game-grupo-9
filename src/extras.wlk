import wollok.game.*

class Plato {
	
	const property ingredientes = #{}
	const property esPlato = true
	const property esCortable = false
	const property esCocinable = false
	const property esSuperficie = false
	var property position = null
	
	method agregarIngrediente(ingrediente) {
		self.validarPlato(ingrediente)
		ingredientes.add(ingrediente)
	}
	
	method validarPlato(ingrediente) {
		if (ingrediente == self) {
			self.error("No se pueden apilar los platos.")
		} else if (ingrediente.esCortable()) {
			self.error("El ingrediente no está cortado.")
		} else if (ingrediente.esCocinable()) {
			self.error("El ingrediente no está cocinado.")
		}
	}
	
	method image() = if (ingredientes.size() == 0) "plato-vacio.png" else	""
	
}

