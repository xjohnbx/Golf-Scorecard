//
//  RoundDetailViewController.swift
//  golfApp
//
//Name/Author: John Brechon
//Z-ID: Z1750010
//CSCI 321/521, Spring 2018
//Activity: Student iOS Project

import UIKit

class RoundDetailViewController: UIViewController {

    
    @IBOutlet weak var dcourseName: UILabel!
    @IBOutlet weak var ddate: UILabel!
    @IBOutlet weak var dStrokes: UILabel!
    @IBOutlet weak var dScoreToPar: UILabel!
    @IBOutlet weak var dPutts: UILabel!
    @IBOutlet weak var dGIRs: UILabel!
    @IBOutlet weak var dFIRs: UILabel!
    @IBOutlet weak var dHole1Score: UILabel!
    @IBOutlet weak var dHole2Score: UILabel!
    @IBOutlet weak var dHole3Score: UILabel!
    @IBOutlet weak var dHole4Score: UILabel!
    @IBOutlet weak var dHole5Score: UILabel!
    @IBOutlet weak var dHole6Score: UILabel!
    @IBOutlet weak var dHole7Score: UILabel!
    @IBOutlet weak var dHole8Score: UILabel!
    @IBOutlet weak var dHole9Score: UILabel!
    @IBOutlet weak var dHole10Score: UILabel!
    @IBOutlet weak var dHole11Score: UILabel!
    @IBOutlet weak var dHole12Score: UILabel!
    @IBOutlet weak var dHole13Score: UILabel!
    @IBOutlet weak var dHole14Score: UILabel!
    @IBOutlet weak var dHole15Score: UILabel!
    @IBOutlet weak var dHole16Score: UILabel!
    @IBOutlet weak var dHole17Score: UILabel!
    @IBOutlet weak var dHole18Score: UILabel!
    @IBOutlet weak var dHole1Fairway: UILabel!
    @IBOutlet weak var dHole2Fairway: UILabel!
    @IBOutlet weak var dHole3Fairway: UILabel!
    @IBOutlet weak var dHole4Fairway: UILabel!
    @IBOutlet weak var dHole5Fairway: UILabel!
    @IBOutlet weak var dHole6Fairway: UILabel!
    @IBOutlet weak var dHole7Fairway: UILabel!
    @IBOutlet weak var dHole8Fairway: UILabel!
    @IBOutlet weak var dHole9Fairway: UILabel!
    @IBOutlet weak var dHole10Fairway: UILabel!
    @IBOutlet weak var dHole11Fairway: UILabel!
    @IBOutlet weak var dHole12Fairway: UILabel!
    @IBOutlet weak var dHole13Fairway: UILabel!
    @IBOutlet weak var dHole14Fairway: UILabel!
    @IBOutlet weak var dHole15Fairway: UILabel!
    @IBOutlet weak var dHole16Fairway: UILabel!
    @IBOutlet weak var dHole17Fairway: UILabel!
    @IBOutlet weak var dHole18Fairway: UILabel!
    @IBOutlet weak var dHole1Green: UILabel!
    @IBOutlet weak var dHole2Green: UILabel!
    @IBOutlet weak var dHole3Green: UILabel!
    @IBOutlet weak var dHole4Green: UILabel!
    @IBOutlet weak var dHole5Green: UILabel!
    @IBOutlet weak var dHole6Green: UILabel!
    @IBOutlet weak var dHole7Green: UILabel!
    @IBOutlet weak var dHole8Green: UILabel!
    @IBOutlet weak var dHole9Green: UILabel!
    @IBOutlet weak var dHole10Green: UILabel!
    @IBOutlet weak var dHole11Green: UILabel!
    @IBOutlet weak var dHole12Green: UILabel!
    @IBOutlet weak var dHole13Green: UILabel!
    @IBOutlet weak var dHole14Green: UILabel!
    @IBOutlet weak var dHole15Green: UILabel!
    @IBOutlet weak var dHole16Green: UILabel!
    @IBOutlet weak var dHole17Green: UILabel!
    @IBOutlet weak var dHole18Green: UILabel!
    
    var round: GolfRound?
    var par = " "

    
    override func viewDidLoad() {
        super.viewDidLoad()

        dcourseName.text = round!.courseName
        dStrokes.text = "\(round!.totalScore)"
        ddate.text = (round!.date)?.asString(style: .short)
        
        if(round!.scoreToPar == 0)
        {
            par = "E"
        }
        else if(round!.scoreToPar > 0)
        {
            par = "+" + "\(round!.scoreToPar)"
        }
        else
        {
            par = "\(round!.scoreToPar)"
        }
        
        dScoreToPar.text = par
        dPutts.text = "\(round!.totalPutts)"
        dGIRs.text = "\(round!.totalGir)"
        dFIRs.text = "\(round!.totalFairways)"
        dStrokes.text = "\(round!.totalScore)"
        dHole1Score.text = "\(round!.hole1Score)"
        dHole2Score.text = "\(round!.hole2Score)"
        dHole3Score.text = "\(round!.hole3Score)"
        dHole4Score.text = "\(round!.hole4Score)"
        dHole5Score.text = "\(round!.hole5Score)"
        dHole6Score.text = "\(round!.hole6Score)"
        dHole7Score.text = "\(round!.hole7Score)"
        dHole8Score.text = "\(round!.hole8Score)"
        dHole9Score.text = "\(round!.hole9Score)"
        dHole10Score.text = "\(round!.hole10Score)"
        dHole11Score.text = "\(round!.hole11Score)"
        dHole12Score.text = "\(round!.hole12Score)"
        dHole13Score.text = "\(round!.hole13Score)"
        dHole14Score.text = "\(round!.hole14Score)"
        dHole15Score.text = "\(round!.hole15Score)"
        dHole16Score.text = "\(round!.hole16Score)"
        dHole17Score.text = "\(round!.hole17Score)"
        dHole18Score.text = "\(round!.hole18Score)"
        
        dHole1Fairway.text = ""
        if(round!.hole1F == true)
        {
            self.dHole1Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole1Fairway.backgroundColor = UIColor.red
        }
        dHole2Fairway.text = ""
        if(round!.hole2F == true)
        {
            self.dHole2Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole2Fairway.backgroundColor = UIColor.red
        }
        dHole3Fairway.text = ""
        if(round!.hole3F == true)
        {
            self.dHole3Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole3Fairway.backgroundColor = UIColor.red
        }
        dHole4Fairway.text = ""
        if(round!.hole4F == true)
        {
            self.dHole4Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole4Fairway.backgroundColor = UIColor.red
        }
        dHole5Fairway.text = ""
        if(round!.hole5F == true)
        {
            self.dHole5Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole5Fairway.backgroundColor = UIColor.red
        }
        dHole6Fairway.text = ""
        if(round!.hole6F == true)
        {
            self.dHole6Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole6Fairway.backgroundColor = UIColor.red
        }
        dHole7Fairway.text = ""
        if(round!.hole7F == true)
        {
            self.dHole7Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole7Fairway.backgroundColor = UIColor.red
        }
        dHole8Fairway.text = ""
        if(round!.hole8F == true)
        {
            self.dHole8Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole8Fairway.backgroundColor = UIColor.red
        }
        dHole9Fairway.text = ""
        if(round!.hole9F == true)
        {
            self.dHole9Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole9Fairway.backgroundColor = UIColor.red
        }
        dHole10Fairway.text = ""
        if(round!.hole10F == true)
        {
            self.dHole10Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole10Fairway.backgroundColor = UIColor.red
        }
        dHole11Fairway.text = ""
        if(round!.hole11F == true)
        {
            self.dHole11Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole11Fairway.backgroundColor = UIColor.red
        }
        dHole12Fairway.text = ""
        if(round!.hole12F == true)
        {
            self.dHole12Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole12Fairway.backgroundColor = UIColor.red
        }
        dHole13Fairway.text = ""
        if(round!.hole13F == true)
        {
            self.dHole13Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole13Fairway.backgroundColor = UIColor.red
        }
        dHole14Fairway.text = ""
        if(round!.hole14F == true)
        {
            self.dHole14Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole14Fairway.backgroundColor = UIColor.red
        }
        dHole15Fairway.text = ""
        if(round!.hole15F == true)
        {
            self.dHole15Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole15Fairway.backgroundColor = UIColor.red
        }
        dHole16Fairway.text = ""
        if(round!.hole16F == true)
        {
            self.dHole16Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole16Fairway.backgroundColor = UIColor.red
        }
        dHole17Fairway.text = ""
        if(round!.hole17F == true)
        {
            self.dHole17Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole17Fairway.backgroundColor = UIColor.red
        }
        dHole18Fairway.text = ""
        if(round!.hole18F == true)
        {
            self.dHole18Fairway.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole18Fairway.backgroundColor = UIColor.red
        }
       
 //Greens
        dHole1Green.text = ""
        if(round!.hole1G == true)
        {
            self.dHole1Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole1Green.backgroundColor = UIColor.red
        }
        dHole2Green.text = ""
        if(round!.hole2G == true)
        {
            self.dHole2Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole2Green.backgroundColor = UIColor.red
        }
        dHole3Green.text = ""
        if(round!.hole3G == true)
        {
            self.dHole3Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole3Green.backgroundColor = UIColor.red
        }
        dHole4Green.text = ""
        if(round!.hole4G == true)
        {
            self.dHole4Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole4Green.backgroundColor = UIColor.red
        }
        dHole5Green.text = ""
        if(round!.hole5G == true)
        {
            self.dHole5Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole5Green.backgroundColor = UIColor.red
        }
        dHole6Green.text = ""
        if(round!.hole6G == true)
        {
            self.dHole6Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole6Green.backgroundColor = UIColor.red
        }
        dHole7Green.text = ""
        if(round!.hole7G == true)
        {
            self.dHole7Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole7Green.backgroundColor = UIColor.red
        }
        dHole8Green.text = ""
        if(round!.hole8G == true)
        {
            self.dHole8Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole8Green.backgroundColor = UIColor.red
        }
        dHole9Green.text = ""
        if(round!.hole9G == true)
        {
            self.dHole9Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole9Green.backgroundColor = UIColor.red
        }
        dHole10Green.text = ""
        if(round!.hole10G == true)
        {
            self.dHole10Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole10Green.backgroundColor = UIColor.red
        }
        dHole11Green.text = ""
        if(round!.hole11G == true)
        {
            self.dHole11Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole11Green.backgroundColor = UIColor.red
        }
        dHole12Green.text = ""
        if(round!.hole12G == true)
        {
            self.dHole12Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole12Green.backgroundColor = UIColor.red
        }
        dHole13Green.text = ""
        if(round!.hole13G == true)
        {
            self.dHole13Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole13Green.backgroundColor = UIColor.red
        }
        dHole14Green.text = ""
        if(round!.hole14G == true)
        {
            self.dHole14Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole14Green.backgroundColor = UIColor.red
        }
        dHole15Green.text = ""
        if(round!.hole15G == true)
        {
            self.dHole15Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole15Green.backgroundColor = UIColor.red
        }
        dHole16Green.text = ""
        if(round!.hole16G == true)
        {
            self.dHole16Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole16Green.backgroundColor = UIColor.red
        }
        dHole17Green.text = ""
        if(round!.hole17G == true)
        {
            self.dHole17Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole17Green.backgroundColor = UIColor.red
        }
        dHole18Green.text = ""
        if(round!.hole18G == true)
        {
            self.dHole18Green.backgroundColor = UIColor.green
        }
        else
        {
            self.dHole18Green.backgroundColor = UIColor.red
        }
    }
}
