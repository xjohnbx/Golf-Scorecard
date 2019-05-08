//
//  priorRoundHoleViewCell.swift
//  golfApp
//
//  Created by John on 5/7/19.
//  Copyright © 2019 John. All rights reserved.
//

import UIKit

class priorRoundHoleViewCell: UITableViewCell {

    @IBOutlet weak var holeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var puttLabel: UILabel!
    
    
    @IBOutlet weak var fairwayImage: UIImageView!
    @IBOutlet weak var greenImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
