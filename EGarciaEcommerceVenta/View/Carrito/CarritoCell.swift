//
//  CarritoCell.swift
//  EGarciaEcommerceVenta
//
//  Created by MacBookMBA4 on 26/05/23.
//

import UIKit

class CarritoCell: UITableViewCell {

    @IBOutlet weak var lblId: UILabel!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var imageViewProducto: UIImageView!
    
    @IBOutlet weak var lblCantidad: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}