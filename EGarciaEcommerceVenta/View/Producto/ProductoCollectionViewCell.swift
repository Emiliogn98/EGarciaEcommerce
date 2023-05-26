//
//  ProductoCollectionViewCell.swift
//  EGarciaEcommerceVenta
//
//  Created by MacBookMBA4 on 25/05/23.
//

import UIKit

class ProductoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var lblNombre: UILabel!
    
    
    @IBOutlet weak var lblDescripcion: UILabel!
    
    @IBOutlet weak var lblPrecio: UILabel!
    
    @IBOutlet weak var btnCarrito: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func btnCarrito(_ sender: UIButton) {
        
        
    }
    
}
