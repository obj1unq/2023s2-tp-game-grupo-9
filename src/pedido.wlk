import wollok.game.*
import randomizer.*
import Ingrediente.*

class Pedido{
	var property nombreImg
	var property position = positionPedido.emptyPosition()
	const property ingredientes = []
	var property activo = true
	const id
	
	method image() {
   		return nombreImg + ".jpg "
	}
	
	method listaDeIngredientes() = ingredientes.map({ ingrediente => ingrediente.nombre() }).asSet()

}

object pedidoManager{

	const property pedidos = []
	const property generados = []
	const aux = []
	const limite = 3
	
	method inicializarPedidos(){
		const pedido1 = new Pedido(id=3,nombreImg="hamburguesa_lechuga", ingredientes= [new Pan(), new Carne(), new Lechuga()])
		const pedido2 = new Pedido(id=2,nombreImg="hamburguesa_tomate_lechuga", ingredientes= [new Tomate(), new Tomate(), new Tomate()])
		const pedido3= new Pedido(id=1,nombreImg="hamburguesa", ingredientes= [new Pan(), new Carne()])
		pedidos.addAll([pedido1,pedido2,pedido3])
	}
	
	method generar(){
		self.inicializarPedidos()
			if (generados.size()< limite && !pedidos.isEmpty()){
				const pedido= pedidos.anyOne()
				pedido.activo(false)
				self.crearSi(pedido)
			}
	}

	method crearSi(pedido){
		if (generados.contains(pedido) && !pedido.activo()){
			aux.add(pedido)
			pedidos.remove(pedido)
		}else {
				game.addVisual(pedido)
				generados.add(pedido)
		}
	}	
	
	method quitar(pedido){
		generados.remove(pedido)
		game.removeVisual(pedido)
	}
}
