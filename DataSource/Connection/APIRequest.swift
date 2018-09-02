//
//  APIRequest.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 8/28/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import UIKit
import RxSwift

//This class performs the URLRequest and returns an observable stream of a generic type
//so the nitty gritty web request stuff, in addition to the json parsing

class APIRequest: NSObject {
    /**
     Performs a request to a web service and returns an observable stream of a geneic typ[
     - Parameter request: The URLRequest to be performed
     - Returns: An observable stream of a generic type
     */
    static func get<T: Codable>(request: URLRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {                    
                    let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }

}
