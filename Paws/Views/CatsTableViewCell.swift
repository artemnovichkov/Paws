//
//  CatsTableViewCell.swift
//  Paws
//
//  Created by Артем on 18.04.15.
//  Copyright (c) 2015 Artem Novichkov. All rights reserved.
//

import UIKit

class CatsTableViewCell: PFTableViewCell {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catVotesLabel: UILabel!
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catCreditLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
