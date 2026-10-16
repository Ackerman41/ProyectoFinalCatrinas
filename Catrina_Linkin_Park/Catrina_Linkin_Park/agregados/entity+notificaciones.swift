//
//  entity+notificaciones.swift
//  Catrina_Linkin_Park
//
//  Created by alumno on 10/16/26.
//
import RealityKit
import Foundation
 
extension Entity{
    func enviar_notificacion(_ notificacion: String) -> Bool{
        if let escene = self.scene {
            NotificationCenter.default.post(
                name: Notification.Name("RealityKit.NotificationTrigger"),
                object: nil,
                userInfo: [
                    "RealityKit.NotificationTrigger.scene": escene,
                    "RealityKit.NotificationTrigger.scene": notificacion
                ]
            )
            return true
        }
        return false
    }
}
