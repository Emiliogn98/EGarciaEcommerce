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
        let lblLogin = app.staticTexts["Login"]
        XCTAssertTrue(lblLogin.exists)
       // lblLogin.click()
        let txtCorreo = app.textFields["emilio@gmail.com"]
        XCTAssertTrue(txtCorreo.exists) // verifica si existe
        XCTAssertTrue(txtCorreo.isHittable && txtCorreo.isEnabled) // verifica si se puede editar
        txtCorreo.tap()
        txtCorreo.typeText("prueba correo") //ingresa texto
        let lblCorreo = app.staticTexts["lblCorreo"]
        XCTAssertFalse(lblCorreo.exists) // no existe hasta que no ingresan un correo
        
        let txtContrasenia = app.textFields["pass@word1"]
        XCTAssertTrue(txtContrasenia.exists) // verifica si existe
        XCTAssertTrue(txtContrasenia.isHittable && txtContrasenia.isEnabled) // verifica si se puede editar
        txtContrasenia.tap()
        //txtContrasenia.typeText("prueba contra") //ingresa texto
        XCTAssertEqual(txtContrasenia.value as? String, "pass@word1") //verificamos el texto ingresado
        
        let lblContrasenia = app.staticTexts["lblContrasenia"]
        XCTAssertFalse(lblContrasenia.exists) // no va existir hasta que no ingresen una contraseña
        
        let button = app.buttons["Ingresar"]
        XCTAssertTrue(button.exists)
       // button.alerts["alert"].tap()
        
        let alertButton = button.alerts["alert"]
            if alertButton.exists {
                alertButton.tap()
                
            }
        button.tap() // un clic al boton ingresar
        let buttonRegistrar = app.buttons["Registrarse"]
        XCTAssertTrue(buttonRegistrar.exists)
        buttonRegistrar.doubleTap() //doble clic al boton regi
   
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
