//
//  CarritoController.swift
//  EGarciaEcommerceVenta
//
//  Created by MacBookMBA4 on 26/05/23.
//

import UIKit

class CarritoController: UITableViewController {
 
    let dbManager = DBManager()
    var result = Result()
    var productos : [Venta] = []
    var nombreProducto : String = ""
    var IdProducto : Int = 0
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
        

       // cell.imageViewProducto.text = "Nombre: \(productos[indexPath.row]!)"
        cell!.lblCantidad.text = "Cantidad: \(productos[indexPath.row].Cantidad!)"
        cell!.lblNombre.text = "Nombre: \(productos[indexPath.row].producto?.Nombre!)"
        //cell!.imageViewProducto.image = productos[indexPath.row].producto?.Imagen!
        return cell!
    }

   

}
