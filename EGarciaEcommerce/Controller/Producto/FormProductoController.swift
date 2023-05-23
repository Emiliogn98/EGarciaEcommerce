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
   
    var IdProducto : Int = 0, IdDepartamento : Int = 0, IdProveedor : Int = 0, IdArea : Int = 0
    var base64 : String = ""
//outlets
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblDepartamento: UILabel!
    @IBOutlet weak var lblStock: UILabel!
    @IBOutlet weak var lblPrecioUnitario: UILabel!
    
    @IBOutlet weak var lblProveedor: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    
    @IBOutlet weak var lblRegistrar: UILabel!
    
    @IBOutlet weak var lblActualizar: UILabel!
    
    @IBOutlet weak var lblArea: UILabel!
    
    @IBOutlet weak var lblIdProducto: UILabel!
    
    
  
    
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
    
    
    @IBOutlet weak var ddlIdArea: DropDown!
    
    
    
    @IBOutlet weak var OpenCamera: UIButton!
    
    @IBAction func openPickerImage(_ sender: UIButton) {
        self.present(imagePickerController, animated: true)
    }
    
    
    @IBAction func btnActionButtons(_ sender: Any) {
        let producto = Producto()
        producto.IdProducto = Int(txtIdProducto.text!)
        producto.Imagen = base64
        producto.Nombre = txtNombre.text!
        producto.PrecioUnitario = Double(txtPrecioUnitario.text!)
        producto.Stock = Int(txtStock.text!)
        producto.Descripcion = txtDescripcion.text!
        producto.Proveedor = Proveedor()
        //producto.Proveedor?.IdProveedor = Int(ddlIdProveedor.text!)
        producto.Proveedor?.IdProveedor = IdProveedor
        producto.Departamento = Departamento()
        //producto.Departamento?.IdDepartamento = Int(ddlIdDepartamento.text!)
        producto.Departamento?.IdDepartamento = IdDepartamento
        //guards
        guard txtNombre.text != "" else {
            lblNombre.isHidden = true
            lblNombre.text = "Campo Requerido"
            lblNombre.textColor  = .red
            //txtNombreOutlet.backgroundColor = .red
            lblNombre.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)
                    return
                }
        txtNombre.backgroundColor = .clear
           lblNombre.text = ""
        lblNombre.isHidden = false
        lblNombre.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)
        guard txtPrecioUnitario.text != "" else {
            lblPrecioUnitario.isHidden = true
            lblPrecioUnitario.text = "Campo Requerido"
            lblPrecioUnitario.textColor  = .red
            //txtNombreOutlet.backgroundColor = .red
            lblPrecioUnitario.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)
                    return
                }
        txtPrecioUnitario.backgroundColor = .clear
           lblPrecioUnitario.text = ""
        lblPrecioUnitario.isHidden = false
        lblPrecioUnitario.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)
        guard txtStock.text != "" else {
            lblStock.isHidden = true
            lblStock.text = "Campo Requerido"
            lblStock.textColor  = .red
            //txtNombreOutlet.backgroundColor = .red
            lblStock.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)
                    return
                }
        txtStock.backgroundColor = .clear
           lblStock.text = ""
        lblStock.isHidden = false
        lblStock.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)
        guard ddlIdDepartamento.text != "" else {
            lblDepartamento.isHidden = true
            lblDepartamento.text = "Campo Requerido"
            lblDepartamento.textColor  = .red
            //txtNombreOutlet.backgroundColor = .red
            lblDepartamento.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)
                    return
                }
        ddlIdDepartamento.backgroundColor = .clear
           lblDepartamento.text = ""
        lblDepartamento.isHidden = false
        lblDepartamento.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)
        guard ddlIdProveedor.text != "" else {
            ddlIdProveedor.isHidden = true
            lblProveedor.text = "Campo Requerido"
            lblProveedor.textColor  = .red
            //txtNombreOutlet.backgroundColor = .red
            lblProveedor.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)
                    return
                }
        ddlIdProveedor.backgroundColor = .clear
           lblProveedor.text = ""
        lblProveedor.isHidden = false
        lblProveedor.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)
        guard txtDescripcion.text != "" else {
            lblDescripcion.text = "Campo Requerido"
            lblDescripcion.isHidden = true
            lblDescripcion.textColor  = .red
            //txtNombreOutlet.backgroundColor = .red
            lblDescripcion.layer.addWaghaBorder(edge: .top, color: UIColor.red, thickness: 1)
                    return
                }
        txtDescripcion.backgroundColor = .clear
           lblDescripcion.text = ""
        lblDescripcion.isHidden = false
        lblDescripcion.layer.addWaghaBorder(edge: .top, color: UIColor.white, thickness: 1)

        
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
        txtDescripcion.text = producto.Descripcion!
        IdProveedor = Int(producto.Proveedor!.IdProveedor!)
        ddlIdProveedor.text = String(producto.Proveedor!.Nombre!)
        IdDepartamento = Int(producto.Departamento!.IdDepartamento!)
        ddlIdDepartamento.text = String(producto.Departamento!.Nombre!)
         let base64String = producto.Imagen!
            let dataDecoded : Data = Data(base64Encoded: base64String)!//Proceso inverso de base64 a Data
            ImgView.image = UIImage(data: dataDecoded)
        
        if ImgView.image == nil {
            ImgView.image = UIImage(named: "AppIcon")
        }else {
            let base64String = producto.Imagen!
            let dataDecoded : Data = Data(base64Encoded: base64String)!//Proceso inverso de base64 a Data
            ImgView.image = UIImage(data: dataDecoded)
        }

  
    }
    func Limpiar(){
        
        txtNombre.text = ""
        txtPrecioUnitario.text = ""
        txtStock.text = ""
        txtIdProducto.text = ""
        txtDescripcion.text = ""
        ddlIdProveedor.text = ""
        ddlIdDepartamento.text = ""
        ImgView.image = UIImage(named: "AppIcon")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if IdProducto == 0{
            //Add
            Limpiar()

            txtIdProducto.isHidden = true
            lblIdProducto.isHidden = true
            lblRegistrar.isHidden = false
            lblActualizar.isHidden = true
            
            btnAction.tintColor = .blue
                      btnAction.setTitle("Agregar", for: .normal)
            
    
           

        }else{
            //up
            Precargar()
            txtIdProducto.isHidden = false
             lblIdProducto.isHidden = false
            lblRegistrar.isHidden = true
            lblActualizar.isHidden = false
            
            btnAction.tintColor = .orange
                      btnAction.setTitle("Actualizar", for: .normal)
            
        }
        //Image delegate
               imagePickerController.delegate = self
               imagePickerController.sourceType = .photoLibrary
               imagePickerController.isEditing = false
               //
//        //area
        ddlIdArea.didSelect {selectedText, index, id in
            self.IdArea = id
            
            let resultIdAreaDepartamento = DepartamentoViewModel.GetById(IdArea: id)
            if resultIdAreaDepartamento.Correct!{
                for objAreaDepartamento in resultIdAreaDepartamento.Objects!{
                    let depaArea =  objAreaDepartamento as! Departamento
                    self.ddlIdDepartamento.optionArray.append(depaArea.Nombre!)
                    self.ddlIdDepartamento.optionIds?.append(depaArea.IdDepartamento!)
                   // depaArea.IdDepartamento = self.IdDepartamento
                }
            }
        }
        ddlIdArea.isSearchEnable = false
        ddlIdArea.textColor = .black
        ddlIdArea.selectedRowColor = .white
        ddlIdArea.rowHeight =   18
        ddlIdArea.arrowSize = 15

        ddlIdArea.optionArray = []
        ddlIdArea.optionIds = []
                let resultArea = AreaViewModel.GetAll()
                if resultArea.Correct!{

                    for objArea in resultArea.Objects!{

                        let area = objArea as! Area
                        ddlIdArea.optionArray.append(area.Nombre!)
                        ddlIdArea.optionIds?.append(area.IdArea!)

                    }
                }
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
                let resultProveedor = ProveedorViewModel.GetAll()
                if resultProveedor.Correct!{

                    for objProveedor in resultProveedor.Objects!{

                        let proveedor = objProveedor as! Proveedor
                        ddlIdProveedor.optionArray.append(proveedor.Nombre!)
                        ddlIdProveedor.optionIds?.append(proveedor.IdProveedor!)

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
//                let resultDepartamento = DepartamentoViewModel.GetAll()
//                if resultDepartamento.Correct!{
//
//                    for objDepartamento in resultDepartamento.Objects!{
//
//                        let departamento = objDepartamento as! Departamento
//                        ddlIdDepartamento.optionArray.append(departamento.Nombre!)
//                        ddlIdDepartamento.optionIds?.append(departamento.IdDepartamento!)
//
//                    }
//                }
    }
}
// MARK: UIImagePickerControllerDelegate
extension FormProductoController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        
        let image = info[.originalImage]
        self.ImgView.image = info[.originalImage] as? UIImage
        dismiss(animated: true)
        convertBase64(imagen: image as! UIImage)
    }

    func convertBase64(imagen: UIImage){
        let imageData = imagen.jpegData(compressionQuality: 1.0)
        self.base64 = imageData!.base64EncodedString()
        
        
        
    }
    
}
