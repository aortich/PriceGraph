//
//  IPCIndexTests.swift
//  IPCIndexTests
//
//  Created by Alberto Ortiz on 8/28/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

@testable import IPCIndex


class IPCIndexTests: XCTestCase {
    let repository = ObtenerDatosGraficoRepository(mock: true)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetGraphData() {
        let observerToTest = repository.getDatosGrafico(empresa: "IPC")
        do {
            let result = try observerToTest?.toBlocking().first()
            let firstGraphData = result?.resultObj.first
            XCTAssertEqual(firstGraphData?.precio, 49540.09)
        } catch {
            XCTFail(error.localizedDescription)
        }

    }
}
