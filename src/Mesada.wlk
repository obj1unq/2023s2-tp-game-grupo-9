import wollok.game.*
import Ingrediente.*
import extras.*
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

//class DespensaDePlato inherits Despensa {
//
//	override method image() = "despensa-plato.png"
//
//	override method objetoApoyado() = if (self.estaOcupada()) super() else new Plato()
//
//}

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
		const parrilla = soundProducer.sound("sounds/parrilla.mp3")
		parrilla.volume(0.5)
		parrilla.play()
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
		if (objeto.esPlato()){
			objeto.limpiarPlato()
		} else {
			game.removeVisual(objeto)
			objetoApoyado = null
		}
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
			pedidoManager.quitar(self.pedidoCompletado())
		}
	}
	
	method mapPorNombre(listaIngredientes) = listaIngredientes.map({ ingrediente => ingrediente.nombre()}).asSet()
	
	method listaDeIngredientesDe(pedido) = self.mapPorNombre(pedido.ingredientes())
	
	method pedidoCompletado() = pedidosPendientes.find({ pedido => self.listaDeIngredientesDe(pedido) == self.listaDeIngredientesIguales() })
	
	method listaDeIngredientesIguales() = self.listaDeIngredientesDePedidos().filter({ e => e == self.mapPorNombre(ingredientes) })
	
	method listaDeIngredientesDePedidos() = pedidosPendientes.map({ pedido => self.listaDeIngredientesDe(pedido) })
	
	method hayPedidoCompletado() = not self.listaDeIngredientesIguales().isEmpty()
	
	method agregarIngrediente(ingrediente) {
		self.validarPlato(ingrediente)
		ingredientes.add(ingrediente)
		game.removeVisual(ingrediente)
	}
	
	method quitarIngredientes(){
		ingredientes.clear()
	}
	
	method validarPlato(ingrediente) {
//		if (ingrediente.esCortable()) {
//			self.error("El ingrediente no está cortado.")
//		} else if (ingrediente.esCocinable()) {
//			self.error("El ingrediente no está cocinado.")
//		}
		
		if (ingredientes.isEmpty() && ingrediente.nombre() != "pan") {
			self.error("Primero tiene que ir el pan.")
		}
	}
	
}

