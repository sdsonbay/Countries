//
//  CustomFavoriteTableViewCell.swift
//  Countries
//
//  Created by Deniz Sonbay on 20.08.2022.
//

import UIKit

class CustomFavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
