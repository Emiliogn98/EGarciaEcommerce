//
//  RegistroController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 22/05/23.
//

import UIKit
import FirebaseAuth

class RegistroController: UIViewController {

    var color = UIColor.red.cgColor
    var color2 = UIColor.white.cgColor

    @IBOutlet weak var lblCorreo: UILabel!
    
    @IBOutlet weak var lblValidarContrasenia: UILabel!
    
    @IBOutlet weak var lblContrasenia: UILabel!
    
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtContrasenia: UITextField!
    
    @IBOutlet weak var txtValidarContrasenia: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
            @IBAction func btnRegistrar(_ sender: UIButton) {
                guard txtCorreo.text != "" else{
                           lblCorreo.text = "Campo Requerido"
                           lblCorreo.textColor  = .red
                    txtCorreo.layer.borderColor = color
                    txtCorreo.layer.borderWidth = 1.0
                           return
                       }
                       lblCorreo.text = ""
                txtCorreo.layer.borderColor = color2
                txtCorreo.layer.borderWidth = 1.0
                      
                guard txtContrasenia.text != "" else{
                           lblContrasenia.text = "Campo Requerido"
                           lblContrasenia.textColor  = .red
                    txtContrasenia.layer.borderColor = color
                    txtContrasenia.layer.borderWidth = 1.0
                           return
                       }
                txtContrasenia.layer.borderColor = color2
                txtContrasenia.layer.borderWidth = 1.0
                       lblContrasenia.text = ""
                guard txtValidarContrasenia.text != "" else{
                           lblValidarContrasenia.text = "Campo Requerido"
                           lblValidarContrasenia.textColor  = .red
                    txtValidarContrasenia.layer.borderColor = color
                    txtValidarContrasenia.layer.borderWidth = 1.0
                    
                           return
                       }
                       lblValidarContrasenia.text = ""
                txtValidarContrasenia.layer.borderColor = color2
                txtValidarContrasenia.layer.borderWidth = 1.0
                       
                Auth.auth().createUser(withEmail: txtCorreo.text!, password: txtContrasenia.text!) { authResult, error in
                    // ...
                    let validarError = error
                    let validarResult = authResult
                    if let ex = error {
                        //aletar
                        let alert = UIAlertController(title: "Mensaje", message: "Ocurrio un error al ingresar", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                        self.navigationController?.popViewController(animated: false)
                        self.present(alert, animated: true)
                        
                        return
                    }
                    else{
                        let alert = UIAlertController(title: "Mensaje", message: "Registro Exitoso", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default){_ in
                            self.performSegue(withIdentifier: "LoginRegistroSegues", sender: self)
                        }
                        alert.addAction(action)
                      
                        self.present(alert, animated: true)
                     
                    }
                    
                } //auth
        }
       
    }
    



