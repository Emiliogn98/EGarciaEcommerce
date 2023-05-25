//
//  ProductoCollectionViewCell.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 24/05/23.
//

import UIKit

class ProductoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblDescripcion: UILabel!
    
    
    @IBOutlet weak var lblPrecio: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
