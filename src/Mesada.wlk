import wollok.game.*
import Ingrediente.*
import soundProducer.*
import pedido.*

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
		if (self.estaOcupada() && not objetoApoyado.esPlato()) {
			self.error("La mesada se encuentra ocupada")
		}
	}

	method accion() {}

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

class TablaDeCortar inherits Mesada {

	override method image() = if (self.estaOcupada()) "tabla-de-cortar.png" else "tabla-de-cortar-vacia.png"

	override method accion() {
		objetoApoyado.cortar()
		reproductor.reproducir("cortar")
	}

}

class Plancha inherits Mesada {

	override method image() = "plancha-vacia.png"

	override method apoyar(objeto) {
		self.validarObjeto(objeto)
		super(objeto)
		objeto.cocinar()
		reproductor.reproducir("parrilla")
	}

	method validarObjeto(objeto) {
		if (not objeto.esCocinable()) {
			self.error("No se puede cocinar")
		}
	}

}

class Tacho inherits Mesada {
	
	override method image() = "tacho.png"
	
	override method apoyar(objeto) {
		game.removeVisual(objeto)
		objetoApoyado = null
		reproductor.reproducir("tacho")
	}
	
}

class MesaDeEntrega inherits Mesada {
	
	const property ingredientes = []
	const pedidosPendientes = pedidoManager.generados()
	
	override method estaOcupada() = false
	
	override method image() {
		if (ingredientes.size() == 0) {
			return "mesa-de-entrega.png"
		} else {
			return "mesa-de-entrega-" + ingredientes.map({ e => e.nombre() }).join('-') + ".png"
		}
	}
	
	override method apoyar(objeto) {
		self.agregarIngrediente(objeto)
	}
	
	override method accion() {
		if (self.hayPedidoCompletado()) {
			self.quitarIngredientes()
			self.actualizarImage()
			reproductor.reproducir("check")
		} else {
			self.error("Ese pedido no existe.")
		}
	}
	
	method mapPorNombre(listaIngredientes) =  listaIngredientes.map({ ingrediente => ingrediente.nombre()}).asSet()
	
	method pedidoCompletado()= pedidosPendientes.find({ pedido => pedido.listaDeIngredientes() == self.listaDeIngredientesIguales() })
	
	method listaDeIngredientesIguales()= self.listaDeIngredientesDePedidos().filter({ e => e == self.mapPorNombre(ingredientes) })
	
	method listaDeIngredientesDePedidos()= pedidosPendientes.map({ pedido => pedido.listaDeIngredientes() })

	method hayPedidoCompletado()  = not self.listaDeIngredientesIguales().isEmpty()
	
	method agregarIngrediente(ingrediente) {
		self.validarPlato(ingrediente)
		ingredientes.add(ingrediente)
		game.removeVisual(ingrediente)
	}
	
	method quitarIngredientes(){
		ingredientes.clear()
	}
	
	method validarPlato(ingrediente) {
		self.validarIngrediente(ingrediente)
		self.validarPrimeroEsPan(ingrediente)
	}
	
	method validarIngrediente(ingrediente) {
		if (ingrediente.esCortable()) {
			self.error("El ingrediente no está cortado.")
		} else if (ingrediente.esCocinable()) {
			self.error("El ingrediente no está cocinado.")
		}
	}
	
	method validarPrimeroEsPan(ingrediente) {
		// El pan siempre tiene que ir primero.
		if (ingredientes.isEmpty() && self.esPan(ingrediente)) {
			self.error("Primero tiene que ir el pan.")
		}
	}
	
	method esPan(ingrediente) = ingrediente.nombre() != "pan"
	
}

