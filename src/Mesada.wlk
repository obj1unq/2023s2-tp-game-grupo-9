import wollok.game.*
import Ingrediente.*
import extras.*

class Mesada {

	var property image = "mesada.png"
	var property objetoApoyado = null
	const property esSuperficie = true
	var property position

	method estaOcupada() = objetoApoyado != null

	method actualizarImage() {
		image = self.image()
	}

	method apoyar(objeto) {
		self.validarMesada()
		objetoApoyado = objeto
		self.actualizarImage()
	}

	method sacar() {
		objetoApoyado = null
	}

	method validarMesada() {
		if (self.estaOcupada()) {
			self.error("La mesada se encuentra ocupada")
		}
	}

	method accion() {
	}

	method esDespensa() = false

}

// Las despensas comparten funcionalidad con las mesadas, ya que se pueden dejar objetos sobre ellas, pero tambien entregan el objeto que almacena.
class Despensa inherits Mesada {

	override method image() = self.image()

	override method esDespensa() = true

}

class DespensaDePan inherits Despensa {

	override method image() = "despensa-pan.png"

	override method objetoApoyado() = if (self.estaOcupada()) super() else new Pan()

}

class DespensaDeTomate inherits Despensa {

	override method image() = "despensa-tomate.png"

	override method objetoApoyado() = if (self.estaOcupada()) super() else new Tomate()

}

class DespensaDeLechuga inherits Despensa {

	override method image() = "despensa-lechuga.png"

	override method objetoApoyado() = if (self.estaOcupada()) super() else new Lechuga()

}

class DespensaDeCarne inherits Despensa {

	override method image() = "despensa-carne.png"

	override method objetoApoyado() = if (self.estaOcupada()) super() else new Carne()

}

class DespensaDePlato inherits Despensa {

	override method image() = "despensa-plato.png"

	override method objetoApoyado() = if (self.estaOcupada()) super() else new Plato()

}

class TablaDeCortar inherits Mesada {

	override method image() = if (self.estaOcupada()) "tabla-de-cortar.png" else "tabla-de-cortar-vacia.png"

	override method accion() {
		objetoApoyado.cortar()
	}

}

class Plancha inherits Mesada {

	override method image() = "plancha-vacia.png"

	override method apoyar(objeto) {
		self.validarObjeto(objeto)
		super(objeto)
		objeto.cocinar()
	}

	method validarObjeto(objeto) {
		if (!objeto.esCocinable()) {
			self.error("No se puede cocinar")
		}
	}

}

class Tacho inherits Mesada {
	
	override method image() = "tacho.png"
	
	override method apoyar(objeto) {
		if (objeto.esPlato()){
			objeto.limpiarPlato()
		} else {
			game.removeVisual(objeto)
			objetoApoyado = null
		}
	}
	
}

