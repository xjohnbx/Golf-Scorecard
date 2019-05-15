//
//  HomeViewController.swift
//  golfApp
//
//Name/Author: John Brechon

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var sycamoreGolfCourse: UIButton!
    @IBOutlet weak var kishwaukeeCountryClub: UIButton!
    @IBOutlet weak var emeraldHillGolfCourse: UIButton!
    
    @IBOutlet weak var playRoundButton: UIButton!
    @IBOutlet weak var priorRoundsButton: UIButton!
    
    var courseChoice = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sycamoreGolfCourse.backgroundColor = UIColor.green
        sycamoreGolfCourse.applyFormat()
        kishwaukeeCountryClub.applyFormat()
        emeraldHillGolfCourse.applyFormat()
        priorRoundsButton.applyFormat()
        playRoundButton.applyFormat()
    }

    @IBAction func sycamoreChoice(_ sender: Any) {
        courseChoice = 1
        
        sycamoreGolfCourse.backgroundColor = UIColor.green
        emeraldHillGolfCourse.backgroundColor = UIColor.white
        kishwaukeeCountryClub.backgroundColor = UIColor.white
    }
   
    @IBAction func kishChoice(_ sender: Any) {
        courseChoice = 2
        
        kishwaukeeCountryClub.backgroundColor = UIColor.green
        sycamoreGolfCourse.backgroundColor = UIColor.white
        emeraldHillGolfCourse.backgroundColor = UIColor.white
    }
    
    @IBAction func emeraldHillChoice(_ sender: Any) {
        courseChoice = 3
        
        emeraldHillGolfCourse.backgroundColor = UIColor.green
        sycamoreGolfCourse.backgroundColor = UIColor.white
        kishwaukeeCountryClub.backgroundColor = UIColor.white
    }

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "StartRound")
        {
            let holeController = segue.destination as! holeViewController
            holeController.courseChoiceHole = courseChoice
        }
    }
}

extension Int16 {
    func toParText(scoreToPar: Int) -> String {
        if scoreToPar == 0 {
            return "E"
        }
        else if scoreToPar > 0 {
            return "+" + "\(scoreToPar)"
        }
        else {
            return "\(scoreToPar)"
        }
    }
}

extension Date {
    func asString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}

extension UIButton {
    func applyFormat() {
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
    }
}
