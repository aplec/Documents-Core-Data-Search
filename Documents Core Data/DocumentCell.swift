//
//  DocumentCell.swift
//  Documents
//
//  Created by Ante Plecas on 2/7/20.
//  Copyright © 2020 Ante Plecas. All rights reserved.
//

import UIKit

class DocumentCell: UITableViewCell {
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var modLabel: UILabel!
    
    
     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)

         // Configure the view for the selected state
     }

}
