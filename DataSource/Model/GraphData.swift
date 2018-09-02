//
//  GraphData.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 8/28/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import Foundation

//A codable model which adapts to the ObtenerDatosGraficos method response
struct GraphData: Codable {
    let result: Bool
    let resultObj: [ResultObj]
    let msg: String
}

struct ResultObj: Codable {
    let fecha: String
    let precio, porcentaje: Double
    let volumen: Int
    
    enum CodingKeys: String, CodingKey {
        case fecha = "Fecha"
        case precio = "Precio"
        case porcentaje = "Porcentaje"
        case volumen = "Volumen"
    }
}
