//
//  ArtistaTableViewCell.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//

import UIKit

class ArtistaTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Artistimg: UIImageView!
    
    @IBOutlet weak var ArtistName: UILabel!
    
    @IBOutlet weak var ArtistPiso: UILabel!
    
    @IBOutlet weak var ArtistMesa: UILabel!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
