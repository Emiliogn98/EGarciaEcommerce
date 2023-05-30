//
//  CarritoController.swift
//  EGarciaEcommerceVenta
//
//  Created by MacBookMBA4 on 26/05/23.
//

import UIKit
import SwipeCellKit

class CarritoController: UITableViewController {
 
    let dbManager = DBManager()
    var result = Result()
    var productos : [Venta] = []
    var nombreProducto : String = ""
    var IdProducto : Int = 0
    var subTotal : Double = 0
    var carritoViewModel = CarritoViewModel()
    
    
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableView.register(UINib(nibName :"CarritoCell", bundle: .main), forCellReuseIdentifier: "CarritoCell")
       updateUI()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        //print("apunto de aparecer:  WillApear GetAll")
       
        tableView.reloadData()
        self.updateUI()
      //  let result = carritoViewModel.Delete(14)
    }
    func updateUI(){
        var result = carritoViewModel.GetAll()
        productos.removeAll()
       if result.Correct!{
            for objCarrito in result.Objects!{
                let producto = objCarrito as! Venta //Unboxing
                 productos.append(producto)
            }
            tableView.reloadData()
        }

    }
    @objc func UpdateCantidad(sender : UIStepper){
        let IdProducto = productos[sender.tag].producto?.IdProducto!
        
        //sender.value >= 0
       // let result = carritoViewModel.UpdateCantidad(self.productos[indexPath.row].producto!.IdProducto!, self.productos[indexPath.row].Cantidad!)
        let result = self.carritoViewModel.UpdateCantidad(productos[sender.tag].producto!.IdProducto!, self.productos[sender.tag].Cantidad!)
        
        
        
            if result.Correct! {
                //Alert
            }else{
                //Alert
            }
           // carritoViewModel.GetAll()
        }

    
    

    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoCell?
        
        cell!.delegate = self
        
        cell!.lblCantidad.text = "Cantidad: \(productos[indexPath.row].Cantidad!)"
        cell!.lblNombre.text = "Nombre: \(productos[indexPath.row].producto!.Nombre!)"
        if productos[indexPath.row].producto?.Imagen == "" || productos[indexPath.row].producto?.Imagen == nil{
            cell?.imageViewProducto.image = UIImage(named: "AppIcon")
        }else{
            let base64String = productos[indexPath.row].producto?.Imagen!
            let dataDecoded : Data = Data(base64Encoded: base64String!)!//Proceso inverso de base64 a Data
            cell?.imageViewProducto.image = UIImage(data: dataDecoded)
        }
        cell?.steppRow.tag = indexPath.row
        cell?.steppRow.addTarget(self, action: #selector(UpdateCantidad), for: .touchUpInside)
//         cell?.steppRow.value = 1
//         cell?.steppRow.value >= 1
        
        
        cell?.lblSubTotal.text = "Subtotal: \(String(subTotal))"
        
        subTotal = Double((productos[indexPath.row].producto?.PrecioUnitario!)!) * Double(productos[indexPath.row].Cantidad!)
        print(subTotal)
        return cell!
    }

   

}

// MARK: swipe cell delegat

extension CarritoController : SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                //print(indexPath.row)
                
                //CODIGO A EJECUTAR
                
                let result = self.carritoViewModel.Delete(self.productos[indexPath.row].producto!.IdProducto!)
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
      
        return nil
    }

}
