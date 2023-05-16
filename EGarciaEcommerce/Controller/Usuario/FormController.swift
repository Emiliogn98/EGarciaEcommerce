//
//  ViewController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 27/04/23.
//

import UIKit
import SwipeCellKit
import iOSDropDown
import IQKeyboardManagerSwift


class FormController: UIViewController {
    var IdUsuario: Int = 0
    var IdRol: Int = 0
    
    @IBOutlet weak var lblId: UILabel!
    //outlet
    @IBOutlet weak var ddlIdRol: DropDown!
    

    
    
    @IBOutlet weak var lblIdRol: UILabel!
    
    @IBOutlet weak var lblRegistrar: UILabel!
    @IBOutlet weak var lblActualizar: UILabel!
    
    @IBOutlet weak var lblPassword: UILabel!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblApellidoPaterno: UILabel!
    
    @IBOutlet weak var lblFechaNacimiento: UILabel!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var btnAction: UIButton!
    
    
    @IBOutlet weak var txtIdOutlet: UILabel!
    
    @IBOutlet weak var txtApellidoMaternoOutlet: UITextField!
    @IBOutlet weak var txtUserNameOutlet: UITextField!
    @IBOutlet weak var txtPasswordOutlet: UITextField!
    @IBOutlet weak var pickerFechaNacimientoOutlet: UIDatePicker!
   
    @IBOutlet weak var txtFechaNacimientoOutlet: UITextField!
    @IBOutlet weak var txtApellidoPaternoOutlet: UITextField!
    @IBOutlet weak var txtNombreOutlet: UITextField!
    
    let dbManager = DBManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        
        ddlIdRol.didSelect { selectedText, index, id in
            self.IdRol = id}
        ddlIdRol.isSearchEnable = false
        ddlIdRol.textColor = .black
        ddlIdRol.selectedRowColor = .white
        ddlIdRol.rowHeight =   18
        ddlIdRol.arrowSize = 15
        
        ddlIdRol.optionArray = []
                ddlIdRol.optionIds = []
                let resultRol = RolViewModel.GetAll()
                if resultRol.Correct!{
                    
                    for objrol in resultRol.Objects!{
                        
                        let rol = objrol as! Rol
                        ddlIdRol.optionArray.append(rol.Nombre!)
                       ddlIdRol.optionIds?.append(rol.IdRol!)
                        
                    }
                }
//        print("El valor de ID es:")
//               print(IdUsuario)

               if IdUsuario == 0{
                   //Add
                   Limpiar()
//
                   txtIdOutlet.isHidden = true
                   lblId.isHidden = true
                   lblRegistrar.isHidden = false
                   lblActualizar.isHidden = true
                   
                   btnAction.tintColor = .blue
                             btnAction.setTitle("Agregar", for: .normal)
                   
                   //Mostrar formulario Vacio
                  

               }else{
                   //up
                   Precargar()
                   txtIdOutlet.isHidden = false
                   lblId.isHidden = false
                   lblRegistrar.isHidden = true
                   lblActualizar.isHidden = false
                   
                   btnAction.tintColor = .orange
                             btnAction.setTitle("Actualizar", for: .normal)
                   
               }
                
        
       
    }
    override func viewWillDisappear(_ animated: Bool) {
      print("apunto de desaparecer: WillDisapear Form")
        
    }
    override func viewWillAppear(_ animated: Bool) {
       print("apunto de aparecer:  WillApear Form")
       //IdUsuario = 0
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("desaparece la vista DidDisapear Form")
      
    }
    override func viewDidAppear(_ animated: Bool) {
        print("aparecio la vista : DidAppear Form")
        
    }
    
 
    
   
//action

    @IBAction func ActionButtons(_ sender: UIButton) {
        let usuario = Usuario()
        let date = pickerFechaNacimientoOutlet.date
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "YYYY-MM-dd"
        usuario.IdUsuario = Int(txtIdOutlet.text!)
        usuario.Nombre = txtNombreOutlet.text!
        usuario.ApellidoPaterno = txtApellidoPaternoOutlet.text!
        usuario.ApellidoMaterno = txtApellidoMaternoOutlet.text!
        usuario.FechaNacimiento = dateFormat.string(from: date)
        usuario.UserName = txtUserNameOutlet.text!
        usuario.Password = txtPasswordOutlet.text!
        usuario.Rol = Rol()
        
        
        usuario.Rol?.IdRol = IdRol
        //usuario.Rol?.IdRol = Int(lblIdRol.text!)
        
        //guards
        guard txtNombreOutlet.text != "" else {
            lblNombre.text = "Campo Requerido"
            lblNombre.textColor  = .red
            //txtNombreOutlet.backgroundColor = .red
            lblNombre.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)
                    return
                }
        txtNombreOutlet.backgroundColor = .clear
           lblNombre.text = ""
        lblNombre.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)
        guard txtApellidoPaternoOutlet.text != "" else {
            lblApellidoPaterno.text = "Campo Requerido"
            lblApellidoPaterno.textColor  = .red
            //txtApellidoPaternoOutlet.backgroundColor = .red
            lblApellidoPaterno.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)

                    return
                }
            txtApellidoPaternoOutlet.backgroundColor = .clear
            lblApellidoPaterno.text = ""
        lblApellidoPaterno.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)
        
//        guard pickerFechaNacimientoOutlet.date == "" else {
//            lblNombre.text = "Campo Requerido"
//            lblNombre.textColor  = .red
//                    return
//                }
        pickerFechaNacimientoOutlet.date = Date.now
            guard txtUserNameOutlet.text != "" else {
            lblUserName.text = "Campo Requerido"
            lblUserName.textColor  = .red
            //txtUserNameOutlet.backgroundColor = .red
            lblUserName.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)

                    return
                }
        lblUserName.text = ""
        txtUserNameOutlet.backgroundColor = .clear
        lblUserName.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)
        guard txtPasswordOutlet.text != "" else {
            lblPassword.text = "Campo Requerido"
            lblPassword.textColor  = .red
            //txtPasswordOutlet.backgroundColor = .red
            lblPassword.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)
                    return
                }
        lblPassword.text = ""
        txtPasswordOutlet.backgroundColor = .clear
        lblPassword.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)
        guard ddlIdRol.text != "" else {
            lblIdRol.text = "Campo Requerido"
            lblIdRol.textColor  = .red
            //txtIdRol.backgroundColor = .red
            lblIdRol.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)

                    return
                }
        lblIdRol.text = ""
        ddlIdRol.backgroundColor = .clear
        lblIdRol.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)
        
        
        let btnSeleccionado = sender.titleLabel?.text
         
        
                if(btnSeleccionado == "Agregar"){
                    let result = UsuarioViewModel.Add(usuario: usuario)
                    
                    if result.Correct == true{
                        
                        let alert = UIAlertController(title: "Mensaje", message: "Usuario Agregado correctamente", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                       // alert.show(_ vc: FormController, sender: self)
                        
                        //alert.showDetailViewController(<#T##vc: UIViewController##UIViewController#>, sender: <#T##Any?#>)
                        self.navigationController?.popViewController(animated: false)
                        present(alert, animated: true)
                        IdUsuario = 0
                        Limpiar()
                    }
                   

                }
                if(btnSeleccionado == "Actualizar"){
                  let result =  UsuarioViewModel.Update(usuario: usuario)
                    if result.Correct == true{
                        let alert = UIAlertController(title: "Mensaje", message: "Usuario moficiado correctamente", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                        self.navigationController?.popViewController(animated: false)
                        present(alert, animated: true)
                        IdUsuario = 0
                        Limpiar()
                    
                        
                        
                    }
                    
                }

        
    }
    func Precargar(){
        var result = UsuarioViewModel.GetById(IdUsuario: IdUsuario)
         let usuario = result.Object as! Usuario
        txtIdOutlet.text = String (usuario.IdUsuario!)
        txtNombreOutlet.text = usuario.Nombre
        txtApellidoPaternoOutlet.text = usuario.ApellidoPaterno
        txtApellidoMaternoOutlet.text = usuario.ApellidoMaterno
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: usuario.FechaNacimiento!) {
            pickerFechaNacimientoOutlet.date = date
        }
        txtUserNameOutlet.text = usuario.UserName
        txtPasswordOutlet.text = usuario.Password
       // usuario.Rol = Rol()
      //  ddlIdRol.text = String(usuario.Rol!.IdRol!)
      
         IdRol = Int(usuario.Rol!.IdRol!)
        ddlIdRol.text = String(usuario.Rol!.IdRol!)
//if let rol =
      //  ddlIdRol.text = usuario.Rol!.Nombre
        
    }
    func Limpiar(){
      
        
        txtIdOutlet.text = ""
        txtNombreOutlet.text = ""
        txtApellidoPaternoOutlet.text = ""
        txtApellidoMaternoOutlet.text = ""
      //  txtFechaNacimientoOutlet.text = Date(usuario.FechaNacimiento)
        txtUserNameOutlet.text = ""
        txtPasswordOutlet.text = ""
        //lbl
        lblNombre.text = ""
        lblApellidoPaterno.text = ""
        lblUserName.text = ""
        lblPassword.text = ""
        lblFechaNacimiento.text = ""
        lblIdRol.text = ""
    }
    
  //class
}
    
    




extension CALayer {
func addWaghaBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
let border = CALayer()
switch edge {
case UIRectEdge.top:
border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1)
break
case UIRectEdge.bottom:
border.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
break
case UIRectEdge.left:
border.frame = CGRect(x: 0, y: 0, width: 1, height: self.frame.height)
break
case UIRectEdge.right:
border.frame = CGRect(x: self.frame.width - 1, y: 0, width: 1, height: self.frame.height)
break
default:
break
}
border.backgroundColor = color.cgColor;
self.addSublayer(border)
}
}
