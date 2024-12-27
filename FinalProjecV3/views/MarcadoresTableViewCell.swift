//
//  MarcadoresTableViewCell.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//

import UIKit

class MarcadoresTableViewCell: UITableViewCell {
    
    @IBOutlet weak var MarcadorNombre: UILabel!
    
    @IBOutlet weak var MarcadorCosto: UILabel!
    
    
    @IBOutlet weak var MarcadorMesa: UILabel!
    
    @IBOutlet weak var MarcadorImportancia: UILabel!
    
    @IBOutlet weak var MarcadorTipo: UILabel!
    
    @IBOutlet weak var MarcadorArtista: UILabel!
    
    
    @IBOutlet weak var MarcadorTag: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
