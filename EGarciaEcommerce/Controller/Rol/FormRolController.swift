//
//  FormRolControllerController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 09/05/23.
//

import UIKit

class FormRolController: UIViewController {
    
    let dbManager = DBManager()
    var IdRol = 0
    //outletes
    @IBOutlet weak var txtId: UITextField!
    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var lblActualizarRol: UILabel!
    @IBOutlet weak var lblRegistrarRol: UILabel!
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblId: UILabel!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNombre.delegate = self
        txtId.delegate = self
//        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
//         view.addGestureRecognizer(tapGesture)
//
        print("El valor de ID es:")
        print(IdRol)
        
        if IdRol == 0{
            //Add
            //   Limpiar()
            
            txtId.isHidden = false
            lblId.isHidden = false
            
            lblRegistrarRol.isHidden = false
            lblActualizarRol.isHidden = true
            
            btnAction.tintColor = .blue
            btnAction.setTitle("Agregar", for: .normal)
            
            //Mostrar formulario Vacio
            
            
        }else{
            //up
            Precargar()
            // txtIdOutlet.isHidden = false
            lblId.isHidden = false
            lblRegistrarRol.isHidden = true
            lblActualizarRol.isHidden = false
            
            btnAction.tintColor = .orange
            btnAction.setTitle("Actualizar", for: .normal)
            
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("apunto de desaparecer: WillDisapear Form")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("apunto de aparecer:  WillApear Form")
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("desaparece la vista DidDisapear Form")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("aparecio la vista : DidAppear Form")
        
    }
// pruebas
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

  //Pruebas
    
//Actions
 
    @IBAction func ActionButtons(_ sender: UIButton) {
        
        var rol = Rol()
        
        rol.IdRol = Int(lblId.text!)
        rol.Nombre = txtNombre.text!
        
        guard txtNombre.text != "" else {
            lblNombre.text = "Campo Requerido"
            lblNombre.textColor  = .red
            txtNombre.backgroundColor = .red

                    return
                }
        txtNombre.backgroundColor = .clear
           lblNombre.text = ""
    
         let btnSeleccionado = sender.titleLabel?.text
          
         
                 if(btnSeleccionado == "Agregar"){
                     let result = RolViewModel.Add(rol: rol)
                     
                     if result.Correct == true{
                         
                         let alert = UIAlertController(title: "Mensaje", message: "Rol Agregado correctamente", preferredStyle: .alert)
                         let action = UIAlertAction(title: "Aceptar", style: .default)
                         alert.addAction(action)
                         self.navigationController?.popViewController(animated: false)
                         present(alert, animated: true)
                         //alert.dismiss(animated: true)
                         //dismiss(animated:true,completion: {self.navigationController?.popViewController(animated: false)})
                         
                         Limpiar()
                     }
                    
                     
                 }
                 if(btnSeleccionado == "Actualizar"){
                   let result =  RolViewModel.Update(rol:rol)
                     if result.Correct == true{
                         let alert = UIAlertController(title: "Mensaje", message: "Rol modificado correctamente", preferredStyle: .alert)
                         let action = UIAlertAction(title: "Aceptar", style: .default)
                         alert.addAction(action)
                         self.navigationController?.popViewController(animated: false)
                         present(alert, animated: true)
                         //dismiss(animated: true)
                         IdRol = 0
                        // Limpiar()
                     
                         
                         
                     }
                     
                 }
        
    }
    func Precargar(){
        var result = RolViewModel.GetById(IdRol: IdRol)
         let rol = result.Object as! Rol
        lblId.text = String (rol.IdRol!)
        txtNombre.text = rol.Nombre
  
        
    }
    func Limpiar(){
        
        txtNombre.text = ""
        lblId.text = ""
    }
   
    
  
}

// MARK: UITEXTFIELDDELEGATE

extension FormRolController : UITextFieldDelegate{
    
    //esconde teclado precionando el boton intro
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
       

        return true
    }
 
  
    
//    func textFieldShouldClear(textField: UITextField) -> Bool {
//        if textField == txtNombre {
//            print("field 1")
//        } else {
//            print("field 2")
//        }
//        return true
//    }
//    func textFieldShouldEndEditing(textField: UITextField) -> Bool{
//       // textField.resignFirstResponder()
//        return true
//    }
        
   
}




