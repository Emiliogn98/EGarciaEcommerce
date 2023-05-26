//
//  LoginController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 19/05/23.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    var color = UIColor.red.cgColor
    var color2 = UIColor.white.cgColor
    //outlets
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var lblCorreo: UILabel!
    @IBOutlet weak var txtContrasenia: UITextField!
    @IBOutlet weak var lblContrasenia: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //ACTIONS
    
    @IBAction func btnRegistrar(_ sender: Any) {
        self.performSegue(withIdentifier: "Registrar", sender: self)
    }
    
    
    
    @IBAction func btnEntrar(_ sender: UIButton) {
     
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
               lblContrasenia.text = ""
               txtContrasenia.layer.borderColor = color2
               txtContrasenia.layer.borderWidth = 1.0
         

        
        Auth.auth().signIn(withEmail: txtCorreo.text!, password: txtContrasenia.text!) { [weak self] authResult, error in
           
            //let validarError = error
            //let validarResult = authResult
            if let ex = error {
                //aletar
                let alert = UIAlertController(title: "Mensaje", message: "Ocurrio un error al ingresar, verifica tus datos", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                
                    self?.present(alert, animated: true)
              
                
            }
            else{
                let alert = UIAlertController(title: "Mensaje", message: "Acceso Correcto", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default){_ in
                    self?.performSegue(withIdentifier: "LoginSegue", sender: self)
                }
                alert.addAction(action)
              
                self?.present(alert, animated: true)
             
            }
        }//auth
    }
}

