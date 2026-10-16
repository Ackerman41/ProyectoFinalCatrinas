import SwiftUI
import RealityKit
 
struct PantallaAR: View {
    @Environment(Controlador.self) var control
    var body: some View {
        switch(control.estado){
        case .cargando:
            Text("Cargando...")
        case .en_inicio:
            RealityView{
                teatro in
                teatro.camera = .spatialTracking
                teatro.add(control.escena)
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded{evento_tap in
                control.tocaron_a(evento_tap.entity)
            })
        }
    }
}
