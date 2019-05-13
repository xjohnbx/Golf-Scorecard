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
        
        
        playRoundButton.layer.cornerRadius = 53.0
        priorRoundsButton.layer.cornerRadius = 5.0
        
        priorRoundsButton.layer.borderColor = UIColor.black.cgColor
        priorRoundsButton.layer.borderWidth = 0.5
        
        
        sycamoreGolfCourse.layer.cornerRadius = 5.0
        kishwaukeeCountryClub.layer.cornerRadius = 5.0
        emeraldHillGolfCourse.layer.cornerRadius = 5.0
        
        self.sycamoreGolfCourse.layer.borderColor = UIColor.black.cgColor
        self.sycamoreGolfCourse.layer.borderWidth = 0.5
        
    }

    @IBAction func sycamoreChoice(_ sender: Any) {
        courseChoice = 1
        
        self.sycamoreGolfCourse.layer.borderColor = UIColor.black.cgColor
        self.sycamoreGolfCourse.layer.borderWidth = 0.5
        
        self.kishwaukeeCountryClub.layer.borderColor = UIColor.clear.cgColor
        self.emeraldHillGolfCourse.layer.borderColor = UIColor.clear.cgColor
    }
   
    @IBAction func kishChoice(_ sender: Any) {
        courseChoice = 2
        
        self.kishwaukeeCountryClub.layer.borderColor = UIColor.black.cgColor
        self.kishwaukeeCountryClub.layer.borderWidth = 0.5
        
        self.sycamoreGolfCourse.layer.borderColor = UIColor.clear.cgColor
        self.emeraldHillGolfCourse.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func emeraldHillChoice(_ sender: Any) {
        courseChoice = 3
        
        self.emeraldHillGolfCourse.layer.borderColor = UIColor.black.cgColor
        self.emeraldHillGolfCourse.layer.borderWidth = 0.5
        
        self.sycamoreGolfCourse.layer.borderColor = UIColor.clear.cgColor
        self.kishwaukeeCountryClub.layer.borderColor = UIColor.clear.cgColor
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
