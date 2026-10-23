import SwiftUI
import RealityKit
 
struct PantallaAR: View {
    @Environment(Controlador.self) var control
    
    var body: some View {
        switch control.estado {
        case .cargando:
            Text("Cargando...")
        case .en_inicio:
            ZStack(alignment: .bottom) { // ZStack para poner el botón flotando encima de la AR
                RealityView { teatro in
                    teatro.camera = .spatialTracking
                    teatro.add(control.escena)
                }
                .gesture(TapGesture().targetedToAnyEntity().onEnded { evento_tap in
                    control.tocaron_a(evento_tap.entity)
                })
                
                // --- BOTÓN DE PAUSA FLOTANTE ---
                Button(action: {
                    control.pausar_musica()
                }) {
                    Label("Pausar Música", systemImage: "pause.fill")
                        .font(.headline)
                        .padding()
                        .background(.ultraThinMaterial) // Estilo translúcido elegante
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                }
                .padding(.bottom, 40) // Separación desde la parte inferior de la pantalla del iPad
            }
        }
    }
}
