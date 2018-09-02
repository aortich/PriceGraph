//
//  ObtenerDatosGraficoProtocol.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 9/1/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import RxSwift

//Protocol for data sources
protocol ObtenerDatosGraficoProtocol {
    /**
     Creates an observable stream of graph data
     - Parameter empresa: The company which we will retrieve data from
     - Returns: An observable stream of Graph Data
     */
    func obtenerDatosGrafico(empresa: String) -> Observable<GraphData>?
}
