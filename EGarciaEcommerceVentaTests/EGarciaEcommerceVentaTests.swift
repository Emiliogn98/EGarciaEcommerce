//
//  EGarciaEcommerceVentaTests.swift
//  EGarciaEcommerceVentaTests
//
//  Created by MacBookMBA4 on 29/05/23.
//

import XCTest
@testable import EGarciaEcommerceVenta

final class EGarciaEcommerceVentaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
     
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        var carritoViewModel = CarritoViewModel()
        var result = Result()
        result = carritoViewModel.Add(100)
        
        XCTAssertTrue(result.Correct!)
        
    }
    func update() throws {
        
        //Getall
//        var carritoViewModel = CarritoViewModel()
//        var result = Result()
//        result = carritoViewModel.GetAll()
//
//        XCTAssertFalse(result.Correct!)
        //delete
//        var carritoViewModel = CarritoViewModel()
//        var result = Result()
//        result = carritoViewModel.Delete(50)
//
//        XCTAssertFalse(result.Correct!)
//        //add
//        var carritoViewModel = CarritoViewModel()
//        var result = Result()
//        result = carritoViewModel.Add(54)
//
//        XCTAssertFalse(result.Correct!)
//    //up
//        var carritoViewModel = CarritoViewModel()
//        var result = Result()
//        result = carritoViewModel.UpdateCantidad(14, 7)
//
//        XCTAssertFalse(result.Correct!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
