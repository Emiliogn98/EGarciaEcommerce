//
//  ProductoCollectionController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 23/05/23.
//

import UIKit



class ProductoCollectionController: UICollectionViewController {
    
    var IdDepartamento : Int = 0
    let dbManager = DBManager()
    var result = Result()
    var productos : [Producto] = []
    var nombreProducto : String = ""
    var ProductoCollectionViewCell : ProductoCollectionViewCell?
    var IdProducto : Int = 0
    let carritoViewModel = CarritoViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName :"ProductoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ProductoCollectionViewCell")
        if IdDepartamento == 0 {
               var result = ProductoViewModel.GetByName(nombreProducto: nombreProducto)
            productos.removeAll()
            if result.Correct!{
                for objProducto in result.Objects!{
                    let producto = objProducto as! Producto //Unboxing
                    productos.append(producto)
                }
                collectionView.reloadData()
            }
        }
        if IdDepartamento != 0 {
            updateUI()
        }
        
        print(nombreProducto)
    }
//    func assigButtonAction(_ sender: UIButton){
//
//       // IdProducto  = productos[indexPath.row].IdProducto
//     // productos[indexPath.row].IdProducto = IdProducto
//        sender.addTarget(ProductoCollectionViewCell, action: #selector(ProductoCollectionViewCell?.btnCarrito(_:)), for: .touchUpInside)
//
//    }
    @objc func AddCarrito(sender : UIButton){
            let IdProducto = productos[sender.tag].IdProducto!
            
            let result = carritoViewModel.Add(IdProducto)
            if result.Correct! {
                //Alert
                let alert = UIAlertController(title: "Mensaje", message: "Se añadio correctamente al carrito de compras", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                
                    present(alert, animated: true)
            }else{
                //Alert
                //Alert
                let alert = UIAlertController(title: "Mensaje", message: "Ocurrio un error al añadir", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                
                    present(alert, animated: true)
            }
           // carritoViewModel.GetAll()
        }
    
    func updateUI(){
        var result = ProductoViewModel.GetByDepartamento(IdDepartamento: IdDepartamento )
        productos.removeAll()
        if result.Correct!{
            for objProducto in result.Objects!{
                let producto = objProducto as! Producto //Unboxing
                productos.append(producto)
            }
            collectionView.reloadData()
        }
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCollectionViewCell", for: indexPath)  as! ProductoCollectionViewCell

        cell.imageView.image = UIImage(named: productos[indexPath.row].Nombre!)
        cell.lblNombre.text = "Nombre: \(productos[indexPath.row].Nombre!)"
        cell.lblDescripcion.text = "Descripcion: \(productos[indexPath.row].Descripcion!)"
        cell.lblPrecio.text = "Precio: \(productos[indexPath.row].PrecioUnitario!)"
        if productos[indexPath.row].Imagen == "" || productos[indexPath.row].Imagen == nil{
            cell.imageView.image = UIImage(named: "AppIcon")
        }else{
            let base64String = productos[indexPath.row].Imagen!
            let dataDecoded : Data = Data(base64Encoded: base64String)!//Proceso inverso de base64 a Data
            cell.imageView.image = UIImage(data: dataDecoded)
            cell.btnAdd.tag = indexPath.row
                   cell.btnAdd.addTarget(self, action: #selector(AddCarrito), for: .touchUpInside)
            
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

