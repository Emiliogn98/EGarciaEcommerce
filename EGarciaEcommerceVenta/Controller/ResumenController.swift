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
    var cantidadProductos: Int? = nil
    var IdMetodoPago: Int = 0
    
    
    
    @IBOutlet weak var lblNumeroArticulos: UILabel!
    
    
    @IBOutlet weak var ddlMetodoPago: DropDown!
    @IBOutlet weak var lblTotal: UILabel!
    
    //outlet
    override func viewDidLoad() {
        super.viewDidLoad()
        print("productos en resumen:\(self.cantidadProductos!)")
        lblNumeroArticulos.text = String(self.cantidadProductos!)
        lblTotal.text = String(Total)
     

        //dropdown
            ddlMetodoPago.didSelect { selectedText, index, id in
            id}
        ddlMetodoPago.isSearchEnable = false
        ddlMetodoPago.textColor = .black
        ddlMetodoPago.selectedRowColor = .white
        ddlMetodoPago.rowHeight =   18
        ddlMetodoPago.arrowSize = 15

        ddlMetodoPago.optionArray = []
        ddlMetodoPago.optionIds = []
                let resultMetodoPago = MetodoPagoViewModel.GetAll()
                if resultMetodoPago.Correct!{

                    for objMetodoPago in resultMetodoPago.Objects!{

                        let metodoPago = objMetodoPago as! MetodoPago
                        ddlMetodoPago.optionArray.append(metodoPago.Nombre!)
                        ddlMetodoPago.optionIds?.append(metodoPago.IdMetodoPago!)

                    }
                }
      
    }
    
    

    @IBAction func btnConfirmar(_ sender: Any) {
    }
    //action

    
    
    
    
    

}
