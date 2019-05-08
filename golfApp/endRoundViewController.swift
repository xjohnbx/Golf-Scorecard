//
//  endRoundViewController.swift
//  golfApp
//
//Name/Author: John Brechon


import UIKit

class endRoundViewController: UIViewController {

    
    var endRound:Round?
    
    @IBOutlet weak var endScoreLabel: UILabel!
    @IBOutlet weak var endPuttLabel: UILabel!
    @IBOutlet weak var endGIRLabel: UILabel!
    @IBOutlet weak var endFairwayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

            //Adding the background image to ViewController
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "homeScreen.jpg")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        endScoreLabel.text = "\(String(describing: endRound?.totalScore))" + "(\(String(describing: endRound?.scoreToPar.toParText)))"

        endPuttLabel.text = "\(String(describing: endRound?.totalPutts))"
        endGIRLabel.text = "\(String(describing: endRound?.totalGIRs))"
        endFairwayLabel.text = "\(String(describing: endRound?.totalFairways))"
        
    }
}
