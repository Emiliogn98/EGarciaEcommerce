//
//  ProductoCollectionViewCell.swift
//  EGarciaEcommerceVenta
//
//  Created by MacBookMBA4 on 25/05/23.
//

import UIKit

class ProductoCollectionViewCell: UICollectionViewCell {
    var result :Result = Result()
    var idProducto : Int? = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var lblNombre: UILabel!
    
    
    @IBOutlet weak var lblDescripcion: UILabel!
    
    @IBOutlet weak var lblPrecio: UILabel!
    
    @IBOutlet weak var btnAdd: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //controlar que hacer antes de ir a la siguiente vista
            if segue.identifier == "ProductoCarritoSegue" {
               // let formControl = segue.destination as! CarritoController
                //formControl.IdProducto = self.IdProducto
                
            }
          
          
   
        }
    
}
