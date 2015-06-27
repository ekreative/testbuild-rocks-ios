//
//  AVProjectCell.swift
//  AppsV2
//
//  Created by Device Ekreative on 6/27/15.
//  Copyright (c) 2015 Sergei Polishchuk. All rights reserved.
//

import UIKit

class AVProjectCell: UITableViewCell {

    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var createdTime: UILabel!
    @IBOutlet weak var iconProject: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
