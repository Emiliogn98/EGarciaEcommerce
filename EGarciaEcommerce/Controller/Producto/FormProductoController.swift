//
//  FormProductoController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 16/05/23.
//

import UIKit
import iOSDropDown
import IQKeyboardManagerSwift

class FormProductoController: UIViewController {
    var productos : [Producto] = []
    let dbManager = DBManager()
    let imagePickerController = UIImagePickerController()
  
    var IdProducto : Int = 0, IdDepartamento : Int = 0, IdProveedor : Int = 0
    var base64 : String = ""
//outlets
    
    @IBOutlet weak var ImgView: UIImageView!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtPrecioUnitario: UITextField!
    
    @IBOutlet weak var txtStock: UITextField!
    
    @IBOutlet weak var ddlIdProveedor: DropDown!
    
    @IBOutlet weak var ddlIdDepartamento: DropDown!
    
    @IBOutlet weak var txtIdProducto: UITextField!
    @IBOutlet weak var txtDescripcion: UITextField!
    //outlets
    @IBOutlet weak var btnAction: UIButton!
    
    //actions
    @IBOutlet weak var OpenCamera: UIButton!
    
    @IBAction func openPickerImage(_ sender: UIButton) {
        self.present(imagePickerController, animated: true)
    }
    
    
    @IBAction func btnActionButtons(_ sender: Any) {
        let producto = Producto()
        producto.IdProducto = Int(txtIdProducto.text!)
       // producto.Imagen =
        producto.Nombre = txtNombre.text!
        producto.PrecioUnitario = Double(txtPrecioUnitario.text!)
        producto.Stock = Int(txtStock.text!)
        producto.Descripcion = txtDescripcion.text!
        producto.Proveedor = Proveedor()
        producto.Proveedor?.IdProveedor = Int(ddlIdProveedor.text!)
        producto.Departamento = Departamento()
        producto.Departamento?.IdDepartamento = Int(ddlIdDepartamento.text!)
        
        var btnSeleccionado: String? = (sender as AnyObject).titleLabel?.text
         
        
                if(btnSeleccionado == "Agregar"){
                    let result = ProductoViewModel.Add(producto: producto)
                    
                    if result.Correct == true{
                        
                        let alert = UIAlertController(title: "Mensaje", message: "Usuario Agregado correctamente", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                  
                        self.navigationController?.popViewController(animated: false)
                        present(alert, animated: true)
                        IdProducto = 0
                        //Limpiar()
                    }
                   

                }
        if(btnSeleccionado == "Actualizar"){
          let result =  ProductoViewModel.Update(producto: producto)
            if result.Correct == true{
                let alert = UIAlertController(title: "Mensaje", message: "Usuario moficiado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.navigationController?.popViewController(animated: false)
                present(alert, animated: true)
                IdProducto = 0
               // Limpiar()
            
                
                
            }
            
        }
        
        //button
    }
    func Precargar(){
        var result = ProductoViewModel.GetById(IdProducto: IdProducto)
         let producto = result.Object as! Producto
        txtIdProducto.text = String (producto.IdProducto!)
        txtNombre.text = producto.Nombre
        txtPrecioUnitario.text = String(producto.PrecioUnitario!)
        txtStock.text = String(producto.Stock!)
        IdProveedor = Int(producto.Proveedor!.IdProveedor!)
        ddlIdProveedor.text = String(producto.Proveedor!.IdProveedor!)
        IdDepartamento = Int(producto.Departamento!.IdDepartamento!)
        ddlIdDepartamento.text = String(producto.Departamento!.IdDepartamento!)
  
     
    }
    func Limpiar(){
        
        txtNombre.text = ""
        txtPrecioUnitario.text = ""
        txtStock.text = ""
        txtIdProducto.text = ""
        txtDescripcion.text = ""
        ddlIdProveedor.text = ""
        ddlIdDepartamento.text = ""
        ImgView.image = .remove
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if IdProducto == 0{
            //Add
            Limpiar()

//            txtIdOutlet.isHidden = true
//            lblId.isHidden = true
//            lblRegistrar.isHidden = false
//            lblActualizar.isHidden = true
            
            btnAction.tintColor = .blue
                      btnAction.setTitle("Agregar", for: .normal)
            
    
           

        }else{
            //up
            Precargar()
//            txtIdOutlet.isHidden = false
//            lblId.isHidden = false
//            lblRegistrar.isHidden = true
//            lblActualizar.isHidden = false
            
            btnAction.tintColor = .orange
                      btnAction.setTitle("Actualizar", for: .normal)
            
        }
        //Image delegate
               imagePickerController.delegate = self
               imagePickerController.sourceType = .photoLibrary
               imagePickerController.isEditing = false
               //
        //proveedor
        ddlIdProveedor.didSelect { selectedText, index, id in
            self.IdProveedor = id}
        ddlIdProveedor.isSearchEnable = false
        ddlIdProveedor.textColor = .black
        ddlIdProveedor.selectedRowColor = .white
        ddlIdProveedor.rowHeight =   18
        ddlIdProveedor.arrowSize = 15
        
        ddlIdProveedor.optionArray = []
        ddlIdProveedor.optionIds = []
                var resultProveedor = ProductoViewModel.GetAll()
                if resultProveedor.Correct!{
                    
                    for objProveedor in resultProveedor.Objects!{
                        
                        let producto = objProveedor as! Producto
                        ddlIdProveedor.optionArray.append(producto.Proveedor!.Nombre!)
                        ddlIdProveedor.optionIds?.append(producto.Proveedor!.IdProveedor!)
                        
                    }
                }
        //departamento
        ddlIdDepartamento.didSelect { selectedText, index, id in
            self.IdDepartamento = id}
        ddlIdDepartamento.isSearchEnable = false
        ddlIdDepartamento.textColor = .black
        ddlIdDepartamento.selectedRowColor = .white
        ddlIdDepartamento.rowHeight =   18
        ddlIdDepartamento.arrowSize = 15
        
        ddlIdDepartamento.optionArray = []
        ddlIdDepartamento.optionIds = []
                let resultDepartamento = ProductoViewModel.GetAll()
                if resultDepartamento.Correct!{
                    
                    for objDepartamento in resultDepartamento.Objects!{
                        
                        var producto = objDepartamento as! Producto
                        ddlIdProveedor.optionArray.append(producto.Departamento!.Nombre!)
                        ddlIdProveedor.optionIds?.append(producto.Departamento!.IdDepartamento!)
                        
                    }
                }
        
    }
    


}
// MARK: UIImagePickerControllerDelegate
extension FormProductoController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
       
//        let image = info[.originalImage]
//
//        self.ImgView.image = info[.originalImage] as? UIImage
//
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ImgView.image = image
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                let base64String = imageData.base64EncodedString()
                //print(base64String)
                var base64 = base64String
               
            }
            
        }
        
        
            dismiss(animated: true)
      
        }
     
       
  

    
    }

