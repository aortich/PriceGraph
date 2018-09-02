//
//  ObtenerDatosGraficoDataSourceFactory.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 9/1/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import UIKit

//The factory which decides what the source for the data is going to be
class ObtenerDatosGraficoDataSourceFactory: NSObject {
    
    /**
     Instantiates the appropriate data source (currently limited to web service and mock source)
     
     - Parameter mock: whether the context is a test or not
     
     - Returns: A data source for the ObtenerDatosGrafico method
     */
    func getObtenerDatosGraficoDataSource(mock:Bool = false) -> ObtenerDatosGraficoProtocol {
        if(mock) {
            return ObtenerDatosGraficoDataSourceMock()
        }
        
        return ObtenerDatosGraficoDataSourceWebService()
    }
}
