//
//  CarritoController.swift
//  EGarciaEcommerceVenta
//
//  Created by MacBookMBA4 on 26/05/23.
//

import UIKit
import SwipeCellKit

class CarritoController: UIViewController {
 
    let dbManager = DBManager()
    var result = Result()
    var productos : [Venta] = []
    var nombreProducto : String = ""
    var IdProducto : Int = 0
    var subTotal : Double = 0
    var Total : Double = 0
    var cantidadProductos : Int = 0
    var carritoViewModel = CarritoViewModel()
    
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableView.register(UINib(nibName :"CarritoCell", bundle: .main), forCellReuseIdentifier: "CarritoCell")
        tableView.dataSource = self
        tableView.delegate = self
       updateUI()
       
    }
    
    @IBAction func btnConfirmar(_ sender: Any) {
        self.performSegue(withIdentifier: "CarritoResumenSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print("apunto de aparecer:  WillApear GetAll")
       
        tableView.reloadData()
        self.updateUI()
      //  let result = carritoViewModel.Delete(14)
    }
    func updateUI(){
        self.Total = 0
        self.cantidadProductos=0
        var result = carritoViewModel.GetAll()
        productos.removeAll()
       if result.Correct!{
            for objCarrito in result.Objects!{
                let producto = objCarrito as! Venta //Unboxing
             //   let total = Int(producto.Cantidad) * Double(producto.producto!.PrecioUnitario!)
                 productos.append(producto)
            }
            tableView.reloadData()
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //controlar que hacer antes de ir a la siguiente vista
            if segue.identifier == "CarritoResumenSegue" {
                let formControl = segue.destination as! ResumenController
                formControl.Total = self.Total
                formControl.cantidadProductos = self.cantidadProductos
                print(self.cantidadProductos)
                
            }
   
        }
    @objc func UpdateCantidad(sender : UIStepper){
        let IdProducto = productos[sender.tag].producto?.IdProducto!
        print(sender.tag)
        print(sender.value)
        
        if sender.value >= 1{

            let result = self.carritoViewModel.UpdateCantidad(productos[sender.tag].producto!.IdProducto!, Int(sender.value))
          //  let result = self.carritoViewModel.UpdateCantidad(productos[sender.tag].producto!.IdProducto!, productos[Int(sender.value)].Cantidad!)
            if result.Correct! {
                //Alert
                updateUI()
                print("Se actualizo la cantidad")
            }else{
                //Alert
                print("ocurrio un error al actualizar")
            }
          
        }
        if sender.value == 0 {
            print(sender.tag)
            print(sender.value)
            let result = self.carritoViewModel.Delete(productos[sender.tag].producto!.IdProducto!)
            
            if result.Correct!{
                updateUI()
                print("se elimino del carrito")
            } else {
                print("ocurrio un error")
            }
            
        }
       
        
        }


}


// MARK: UITableViewDataSource,UITableViewDelegate

extension CarritoController : UITableViewDataSource,UITableViewDelegate {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        cell?.steppRow.value = Double(productos[indexPath.row].Cantidad!)
        cell?.steppRow.tag = indexPath.row
        cell?.steppRow.addTarget(self, action: #selector(UpdateCantidad), for: .touchUpInside)

                
       // cell?.lblSubTotal.text = "Subtotal: \(String(Double((productos[indexPath.row].producto?.PrecioUnitario!)!) * Double(productos[indexPath.row].Cantidad!)))"
        cell?.lblSubTotal.text = "Subtotal: \(Double(productos[indexPath.row].producto!.PrecioUnitario!) * Double(productos[indexPath.row].Cantidad!))"
        
         self.subTotal = Double(productos[indexPath.row].producto!.PrecioUnitario!) * Double(productos[indexPath.row].Cantidad!)
         self.Total = self.Total + subTotal
         lblTotal.text = "Total:\(String(Total))"
        //print(subTotal)
         self.cantidadProductos = cantidadProductos + productos[indexPath.row].Cantidad!
         
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
