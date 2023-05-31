//
//  EGarciaEcommerceVentaUITests.swift
//  EGarciaEcommerceVentaUITests
//
//  Created by MacBookMBA4 on 30/05/23.
//

import XCTest

final class EGarciaEcommerceVentaUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
      
        
        let txtCorreo = app.textFields["emilio@gmail.com"]
        XCTAssertTrue(txtCorreo.exists) // verifica si existe
        XCTAssertTrue(txtCorreo.isHittable && txtCorreo.isEnabled) // verifica si se puede editar
        txtCorreo.tap()
        //txtCorreo.typeText("prueba correo") //ingresa texto
        XCTAssertEqual(txtCorreo.value as? String, "emilio@gmail.com") //verificamos el texto ingresado
        
//        let txtContrasenia = app.textFields["txtContrasenia"]
//        XCTAssertTrue(txtContrasenia.exists) // verifica si existe
//        XCTAssertTrue(txtContrasenia.isHittable && txtCorreo.isEnabled) // verifica si se puede editar
//        txtContrasenia.tap()
//        //txtCorreo.typeText("prueba contra") //ingresa texto
//        XCTAssertEqual(txtContrasenia.value as? String, "pass@word1") //verificamos el texto ingresado


       app.staticTexts["lblCorreo"].exists
       
        
        app.staticTexts["lblContrasenia"].exists
        
        let button = app.buttons["Ingresar"]
        button.tap()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
