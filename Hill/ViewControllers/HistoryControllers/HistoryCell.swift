//
//  HistoryCell.swift
//  Hill
//
//  Created by Tixon Markin on 03.12.2019.
//  Copyright © 2019 Tixon Markin. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var matrixDimensionLabel: UILabel!
    @IBOutlet weak var keyTextLabel: UILabel!
    @IBOutlet weak var alphabetNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
