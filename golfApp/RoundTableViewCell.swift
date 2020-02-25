//
//  RoundTableViewCell.swift
//  golfApp
//
//Name/Author: John Brechon



import UIKit

class RoundTableViewCell: UITableViewCell {

    @IBOutlet weak var cellCourseName: UILabel!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellToPar: UILabel!
    @IBOutlet weak var cellStrokes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
	
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
