//
//  Producto.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 17/05/23.
//

import Foundation
class Producto {
    
    var IdProducto : Int? = nil
    var Nombre : String? = nil
    var PrecioUnitario : Double? = nil
    var Stock : Int? = nil
    var Descripcion : String? = nil

    var Imagen : String? = nil
    var Departamento : Departamento? = nil
    var Proveedor : Proveedor? = nil
}
