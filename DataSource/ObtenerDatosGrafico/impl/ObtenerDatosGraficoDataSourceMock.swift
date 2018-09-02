//
//  ObtenerDatosGraficoDataSourceMock.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 9/1/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import UIKit
import RxSwift

//A DataSource for the ObtenerDatosGrafico method which returns mock data
class ObtenerDatosGraficoDataSourceMock: NSObject, ObtenerDatosGraficoProtocol {

    /**
     Creates an observable stream of preloaded GraphData for testing purposes
     - Parameter empresa: The company which we will retrieve data from
     - Returns: An observable stream of Graph Data
     */
    func obtenerDatosGrafico(empresa: String) -> Observable<GraphData>? {
        return Observable<GraphData>.create { observer in
            let model =
            GraphData(result: true,
            resultObj: [ResultObj(fecha: "2018-08-31T08:30:01.21-05:00", precio: 49540.09, porcentaje: -0.23, volumen: 34096),
                        ResultObj(fecha: "2018-08-31T08:30:32.79-05:00", precio: 49544.03, porcentaje: -0.22, volumen: 54227),
                        ResultObj(fecha: "2018-08-31T08:31:03.173-05:00", precio: 49564.44, porcentaje: -0.18, volumen: 109022),
                        ResultObj(fecha: "2018-08-31T08:32:05.057-05:00", precio: 49579.47, porcentaje: -0.15, volumen: 229634),
                        ResultObj(fecha: "2018-08-31T08:32:36.063-05:00", precio: 49577.2, porcentaje: -0.15, volumen: 247915),
                        ],
                          msg: "Ok")
            observer.onNext(model)
            return Disposables.create {
                
            }
        }
    }
}
