//
//  ProductoCell.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 16/05/23.
//

import UIKit
import SwipeCellKit

class ProductoCell: SwipeTableViewCell {
//outlets
    
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtDepartamento: UITextField!
    
    @IBOutlet weak var txtPrecioUnitario: UITextField!
    
    @IBOutlet weak var txtDescripcion: UITextField!
    
   
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
