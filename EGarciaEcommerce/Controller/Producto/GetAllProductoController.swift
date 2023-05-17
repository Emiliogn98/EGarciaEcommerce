//
//  GetAllProductoController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 16/05/23.
//

import UIKit
import SwipeCellKit

class GetAllProductoController: UITableViewController {

    var productos : [Producto] = []
    let dbManager = DBManager()
    var result = Result()
    var IdProducto : Int = 0, IdDepartamento : Int = 0, IdProveedor : Int = 0
    
    @IBOutlet weak var btnFormProducto: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName :"ProductoCell", bundle: .main), forCellReuseIdentifier: "ProductoCell")
        updateUI()
        
    }
// appears
    override func viewWillDisappear(_ animated: Bool) {
      print("apunto de desaparecer: WillDisapear GetAll")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("apunto de aparecer:  WillApear GetAll")
        IdProducto = 0
        tableView.reloadData()
        self.updateUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("desaparece la vista DidDisapear GetAll")
    }
    override func viewDidAppear(_ animated: Bool) {
      print("aparecio la vista : DidAppear GetAll")
    }
    // MARK: - Table view data source
   
    func updateUI(){
        var result = ProductoViewModel.GetAll()
        productos.removeAll()
        if result.Correct!{
            for objProducto in result.Objects!{
                let producto = objProducto as! Producto //Unboxing
                productos.append(producto)
            }
            tableView.reloadData()
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //controlar que hacer antes de ir a la siguiente vista
            if segue.identifier == "FormProductoController"{
                let formControl = segue.destination as! FormProductoController
                formControl.IdProducto = self.IdProducto
                
            }
   
        }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoCell
        
          cell.delegate = self
          
        cell.txtNombre.text = "Nombre: \(productos[indexPath.row].Nombre!)"
        cell.txtDepartamento.text = "Departamento: \(productos[indexPath.row].Departamento!.Nombre!)"
        cell.txtPrecioUnitario.text = "Precio: \(productos[indexPath.row].PrecioUnitario!)"
        cell.txtDescripcion.text = "FechaNacimiento: \(productos[indexPath.row].Descripcion!)"
        //cell.imageView.text = "Username: \(productos[indexPath.row].Imagen!)"
        //Image
        if productos[indexPath.row].Imagen == "" || productos[indexPath.row].Imagen == nil {
            cell.imgView.image = UIImage(named: "DefaultProducto")
        }else{
            let base64String = ""
            let imagenData : Data = Data(base64Encoded: base64String)!//Proceso inverso de base64 a Data
            cell.imgView.image = UIImage(data: imagenData)
        }
  

        return cell
    }
    //class
}
// MARK: SwipeCell
extension GetAllProductoController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                //print(indexPath.row)
                
                //CODIGO A EJECUTAR
                
            let result = UsuarioViewModel.Delete(IdUsuario: self.productos[indexPath.row].IdProducto!)
                if result.Correct!{
                    print("Producto Eliminado")
                    self.updateUI()
                }else{
                    print("Ocurrio un error")
                }
                
            }
            
            deleteAction.image = UIImage(named: "trash")
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                //print("Se ejecuto la funcion de update")
                //CODIGO A EJECUTAR
  
                 
                var result = ProductoViewModel.GetById(IdProducto: self.productos[indexPath.row].IdProducto!)
                self.IdProducto = self.productos[indexPath.row].IdProducto!
                self.performSegue(withIdentifier: "FormController", sender: self)
            }
            return [updateAction]
        }
        return nil
    }
  
  
}

