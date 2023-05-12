//
//  UsuarioCell.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 03/05/23.
//

import UIKit
import SwipeCellKit

class UsuarioCell: SwipeTableViewCell {
//UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var txtID: UILabel!
    @IBOutlet weak var txtApellidoPaterno: UILabel!
    @IBOutlet weak var txtUserNameOutlet: UILabel!
    //outlets
    @IBOutlet weak var txtFechaNacimientoOutlet: UILabel!
    @IBOutlet weak var txtNombreOutlet: UILabel!
    
    @IBOutlet weak var txtIdRol: UILabel!
    


    //actions
    
 
    
    
    
}
