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
    
    // 🗺️ Aquí creamos el mapa: "Nombre Fijo del Modelo" : "NombreDeLaCancion.mp3"
        private let cancionesPorModelo: [String: String] = [
            "Papercut": "Papercut.mp3",
            "Minutes": "Bleed_It_Out.mp3"
            // Si agregas más discos, solo los agregas aquí:
            // "OtroModeloFijo": "OtraCancion.mp3"
        ]
    
    private var reproductorAudio: AudioPlaybackController?
    
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
        
        guard let modelo = try? await Entity(named: "EscenarioPrincipal", in: linkin_ar_modelosBundle) else {
            fatalError("Modelo no encontrado")
        }
        
        
        
        imagen.addChild(modelo)
        escena.addChild(imagen)
        
        
    }
    func tocaron_a(_ entidad: Entity) {
            print("Modelo presionado: \(entidad.name)")
            
            // 1. Verificamos si la entidad presionada está en nuestro diccionario de discos
            if let nombreCancion = cancionesPorModelo[entidad.name] {
                
                // 2. Detenemos cualquier audio anterior
                if let reproductor = reproductorAudio {
                    reproductor.stop()
                    reproductorAudio = nil
                }
                
                // 3. Reproducimos la canción correspondiente de forma dinámica
                do {
                    let audioResource = try AudioFileResource.load(named: nombreCancion, in: .main)
                    reproductorAudio = entidad.playAudio(audioResource)
                    print("Reproduciendo canción: \(nombreCancion) desde el modelo: \(entidad.name)")
                } catch {
                    print("Error al cargar el audio \(nombreCancion): \(error.localizedDescription)")
                }
                
            } else {
                print("Este modelo no tiene una canción asignada.")
            }
        }
    // Función para pausar el audio actual
        func pausar_musica() {
            if let reproductor = reproductorAudio {
                reproductor.pause()
                print("Música pausada")
            }
        }
        
        // (Opcional) Si también quieres una función para reanudar la misma canción donde se quedó:
        func reanudar_musica() {
            if let reproductor = reproductorAudio {
                reproductor.play()
                print("Música reanudada")
            }
        }
    }




enum EstadosControlador{
    case cargando
    case en_inicio
}
