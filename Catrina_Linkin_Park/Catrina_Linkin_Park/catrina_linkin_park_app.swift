//
//  Catrina_Linkin_ParkApp.swift
//  Catrina_Linkin_Park
//
//  Created by alumno on 10/12/26.
//

import SwiftUI

@main
struct Catrina_Linkin_ParkApp: App {
    @State var controlador = Controlador()
    var body: some Scene {
        WindowGroup {
            PantallaAR()
                .environment(controlador)
        }
    }
}
