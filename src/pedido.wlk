import wollok.game.*
import randomizer.*
import Ingrediente.*

class Pedido{
	var property nombreImg
	var property position = positionPedido.emptyPosition()
	const property ingredientes = []
	var property activo = true
	
	method image() {
   		return nombreImg + ".jpg "
	}

}

object pedidoManager{

	const pedidos = []
	const generados = []
	const aux = []
	const limite = 3
	
	method inicializarPedidos(){
		const pedido1 = new Pedido(nombreImg="tomate-cortado_lechuga", ingredientes= [factoryTomate.nuevo(), factoryLechuga.nuevo()])
		const pedido2 = new Pedido(nombreImg="tomate-cortado_lechuga_carne-cocinado", ingredientes= [factoryTomate.nuevo(), factoryLechuga.nuevo(), factoryCarne.nuevo()])
		const pedido3= new Pedido(nombreImg="tomate-cortado_", ingredientes= [factoryTomate.nuevo()])
		pedidos.addAll([pedido1,pedido2,pedido3])
	}
	
	method generar(){
		self.inicializarPedidos()
			if (generados.size()<= limite && !pedidos.isEmpty()){
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
