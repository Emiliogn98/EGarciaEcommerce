//
//  ResumenController.swift
//  EGarciaEcommerceVenta
//
//  Created by MacBookMBA4 on 02/06/23.
//

import UIKit
import iOSDropDown


class ResumenController: UIViewController {

    
    var Total : Double = 0
    var productos : [Venta] = []
    var cantidadProductos: Int = 0
    
    
    
    @IBOutlet weak var lblNumeroArticulos: UILabel!
    
    
    @IBOutlet weak var ddlMetodoPago: DropDown!
    @IBOutlet weak var lblTotal: UILabel!
    
    //outlet
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTotal.text = String(Total)
        lblNumeroArticulos.text = String(productos.count)
//
//        didSelect { selectedText, index, id in
//            self.IdProveedor = id}
//        ddlMetodoPago.isSearchEnable = false
//        ddlMetodoPago.textColor = .black
//        ddlMetodoPago.selectedRowColor = .white
//        ddlMetodoPago.rowHeight =   18
//        ddlMetodoPago.arrowSize = 15
//
//        ddlMetodoPago.optionArray = []
//        ddlMetodoPago.optionIds = []
//                let resultProveedor = ProveedorViewModel.GetAll()
//                if resultProveedor.Correct!{
//
//                    for objProveedor in resultProveedor.Objects!{
//
//                        let proveedor = objProveedor as! Proveedor
//                        ddlIdProveedor.optionArray.append(proveedor.Nombre!)
//                        ddlIdProveedor.optionIds?.append(proveedor.IdProveedor!)
//
//                    }
//                }
      
    }
    
    

    @IBAction func btnConfirmar(_ sender: Any) {
    }
    //action

    
    
    
    
    

}
