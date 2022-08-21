//
//  CustomTableViewCell.swift
//  Countries
//
//  Created by Deniz Sonbay on 17.08.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
