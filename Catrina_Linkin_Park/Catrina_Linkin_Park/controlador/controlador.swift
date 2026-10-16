//
//  controlador.swift
//  Catrina_Linkin_Park
//
//  Created by alumno on 10/16/26.
//

import RealityKit
import SwiftUI
import linkin_ar_modelos
 
@Observable
class Controlador{
    private(set) var estado: EstadosControlador = .cargando
    private(set) var escena: Entity = Entity()
    
    init(){
        escena.name = "raiz"
        Task.detached(priority: .high) {
            await self.carga_asincrona()
        }
    }
    
    func carga_asincrona() async {
        defer{
            estado = .en_inicio
        }
        let imagen = AnchorEntity(.image(group: "ar", name: "hybrid_theory"))
        
        guard let caja = try? await Entity(named: "ModelosLinkin", in: linkin_ar_modelosBundle) else {
            fatalError("Modelo no encontrado")
        }
        imagen.addChild(caja)
        escena.addChild(imagen)
        
       
    }
    func tocaron_a(_ entidad: Entity){
            entidad.enviar_notificacion("barrell") //nombre de la animacion
            //se le tiene que agregar colision al modelo
        }
}
 
 
enum EstadosControlador{
    case cargando
    case en_inicio
}
