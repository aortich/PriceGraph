//
//  ObtenerDatosGraficoRepository.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 9/1/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import UIKit
import RxSwift

//This class serves as the entry point for the ObtenerDatosGraficos service
class ObtenerDatosGraficoRepository: NSObject {
    private let factory: ObtenerDatosGraficoDataSourceFactory = ObtenerDatosGraficoDataSourceFactory()
    private let mock: Bool
    
    /**
     The initialization method for the repository
     
     - Parameter mock: Whether the context is a test or not
     */
    init(mock: Bool = false) {
        self.mock = mock
    }
    
    /**
     Creates an observable stream of graph data from a data source chosen by the factory
     - Parameter empresa: The company which we will retrieve data from
     - Returns: An observable stream of Graph Data
     */
    func getDatosGrafico(empresa: String) -> Observable<GraphData>? {
        let dataSource = factory.getObtenerDatosGraficoDataSource(mock: self.mock)
        return dataSource.obtenerDatosGrafico(empresa: empresa)
    }

}
