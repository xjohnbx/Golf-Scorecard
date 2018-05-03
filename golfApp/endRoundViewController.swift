//
//  endRoundViewController.swift
//  golfApp
//
//Name/Author: John Brechon
//Z-ID: Z1750010
//CSCI 321/521, Spring 2018
//Activity: Student iOS Project

import UIKit

class endRoundViewController: UIViewController {

    
    var endScore = 0
    var endScoreToPar = 0
    var endPutts = 0
    var endGIR = 0
    var endFairway = 0
    
    
    @IBOutlet weak var endScoreLabel: UILabel!
    @IBOutlet weak var endPuttLabel: UILabel!
    @IBOutlet weak var endGIRLabel: UILabel!
    @IBOutlet weak var endFairwayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "homeScreen.jpg")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        
        if(endScoreToPar == 0)
        {
            endScoreLabel.text = "\(endScore)" + " (E)"
        }
        else if(endScoreToPar > 0)
        {
            endScoreLabel.text = "\(endScore)" + " (+" + "\(endScoreToPar)" + ")"
        }
        else
        {
            endScoreLabel.text = "\(endScore)" + " (" + "\(endScoreToPar)" + ")"
        }
        endPuttLabel.text = "\(endPutts)"
        endGIRLabel.text = "\(endGIR)"
        endFairwayLabel.text = "\(endFairway)"
        
    }
}
