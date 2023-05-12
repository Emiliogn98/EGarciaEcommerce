//
//  RolCell.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 09/05/23.
//

import UIKit
import SwipeCellKit

class RolCell: SwipeTableViewCell {
//UITableViewCell
    //outlet
    @IBOutlet weak var txtNombre: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var txtIdRol: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
