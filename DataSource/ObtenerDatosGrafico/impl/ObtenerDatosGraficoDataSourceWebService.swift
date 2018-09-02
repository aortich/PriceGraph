//
//  ObtenerDatosGraficoDataSourceWebService.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 9/1/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import UIKit
import RxSwift

//Data Source that obtains data from the web service
class ObtenerDatosGraficoDataSourceWebService: NSObject, ObtenerDatosGraficoProtocol {
    private let route = "https://www.gbm.com.mx/Mercados/ObtenerDatosGrafico"
    
    /**
     Creates an observable stream of graph data from a web service
     - Parameter empresa: The company which we will retrieve data from
     - Returns: An observable stream of Graph Data
     */
    func obtenerDatosGrafico(empresa: String) -> Observable<GraphData>? {
        guard let request = createObtenerDatosGraficoRequest(empresa: empresa) else {
            return nil
        }
        
        return APIRequest.get(request: request)
    }
    
    /**
     Creates a GET url request given an URL
     - Parameter url: the URL hosting the service
     - Returns: A URLRequest
     */
    private func createRequest(url: String?) -> URLRequest? {
        guard let url = URL(string: url ?? "") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    /**
     Creates a URLRequest specifically for the obtenerDatosGraficos method
     - Parameter empresa: The company which we will retrieve data from
     - Returns: A URLRequest
     */
    private func createObtenerDatosGraficoRequest(empresa: String) -> URLRequest? {
        let stringRequest = String(format: "%@?empresa=%@", route, empresa)
        return self.createRequest(url: stringRequest)
    }
    
}
