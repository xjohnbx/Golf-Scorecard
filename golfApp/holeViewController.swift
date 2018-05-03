//
//  holeViewController.swift
//  golfApp
//
//Name/Author: John Brechon

// This viewController deals with all the calculations for each hole

import UIKit
import CoreData

class holeViewController: UIViewController {

//course hole and flags
    var courseChoiceHole = 1
    var badUserScoreFlag = false
    var badUserPuttsFlag = false
    var hole18flag = false

//User Values
    var fairwayHit = false
    var GIRHit = false
    var holeNumberCounter = 1
    var actualHole = 1
    var userScoreToPar = 0
    var totalScore = 0
    var totalPutts = 0
    var totalGIRs = 0
    var totalFairways = 0

//played?
    var hole1Pl = false
    var hole2Pl = false
    var hole3Pl = false
    var hole4Pl = false
    var hole5Pl = false
    var hole6Pl = false
    var hole7Pl = false
    var hole8Pl = false
    var hole9Pl = false
    var hole10Pl = false
    var hole11Pl = false
    var hole12Pl = false
    var hole13Pl = false
    var hole14Pl = false
    var hole15Pl = false
    var hole16Pl = false
    var hole17Pl = false
    var hole18Pl = false

//fairways
    var hole1F = false
    var hole2F = false
    var hole3F = false
    var hole4F = false
    var hole5F = false
    var hole6F = false
    var hole7F = false
    var hole8F = false
    var hole9F = false
    var hole10F = false
    var hole11F = false
    var hole12F = false
    var hole13F = false
    var hole14F = false
    var hole15F = false
    var hole16F = false
    var hole17F = false
    var hole18F = false
//GIRs
    var hole1G = false
    var hole2G = false
    var hole3G = false
    var hole4G = false
    var hole5G = false
    var hole6G = false
    var hole7G = false
    var hole8G = false
    var hole9G = false
    var hole10G = false
    var hole11G = false
    var hole12G = false
    var hole13G = false
    var hole14G = false
    var hole15G = false
    var hole16G = false
    var hole17G = false
    var hole18G = false
//Putts
    var hole1P = 0
    var hole2P = 0
    var hole3P = 0
    var hole4P = 0
    var hole5P = 0
    var hole6P = 0
    var hole7P = 0
    var hole8P = 0
    var hole9P = 0
    var hole10P = 0
    var hole11P = 0
    var hole12P = 0
    var hole13P = 0
    var hole14P = 0
    var hole15P = 0
    var hole16P = 0
    var hole17P = 0
    var hole18P = 0
//Score
    var hole1S = 0
    var hole2S = 0
    var hole3S = 0
    var hole4S = 0
    var hole5S = 0
    var hole6S = 0
    var hole7S = 0
    var hole8S = 0
    var hole9S = 0
    var hole10S = 0
    var hole11S = 0
    var hole12S = 0
    var hole13S = 0
    var hole14S = 0
    var hole15S = 0
    var hole16S = 0
    var hole17S = 0
    var hole18S = 0

//These are for course details. Yards and Pars
    var courseName = ""
    var courseSlope = 0
    var courseRating = 0
    var coursetotalPar = 0
    var course1Par = 0
    var course1Yards = 0
    var course2Par = 0
    var course2Yards = 0
    var course3Par = 0
    var course3Yards = 0
    var course4Par = 0
    var course4Yards = 0
    var course5Par = 0
    var course5Yards = 0
    var course6Par = 0
    var course6Yards = 0
    var course7Par = 0
    var course7Yards = 0
    var course8Par = 0
    var course8Yards = 0
    var course9Par = 0
    var course9Yards = 0
    var course10Par = 0
    var course10Yards = 0
    var course11Par = 0
    var course11Yards = 0
    var course12Par = 0
    var course12Yards = 0
    var course13Par = 0
    var course13Yards = 0
    var course14Par = 0
    var course14Yards = 0
    var course15Par = 0
    var course15Yards = 0
    var course16Par = 0
    var course16Yards = 0
    var course17Par = 0
    var course17Yards = 0
    var course18Par = 0
    var course18Yards = 0
 
//Outlets for on screen info
    @IBOutlet weak var holeScoreTextField: UITextField!
    @IBOutlet weak var holePuttsTextField: UITextField!
    @IBOutlet weak var holeGIRYesButton: UIButton!
    @IBOutlet weak var holeGIRNoButton: UIButton!
    @IBOutlet weak var holeFairwayYesButton: UIButton!
    @IBOutlet weak var holeFairwayNoButton: UIButton!
    @IBOutlet weak var holeNumber: UILabel!
    @IBOutlet weak var holePar: UILabel!
    @IBOutlet weak var holeYards: UILabel!
    @IBOutlet weak var userScoreToParLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var viewSummary: UIButton!
    @IBOutlet weak var cancelRound: UIButton!
    @IBOutlet weak var saveRound: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readCourse()
        
            //adding formatting to holeView Buttons
        holeGIRYesButton.layer.cornerRadius = 5.0
        holeGIRNoButton.layer.cornerRadius = 5.0
        holeFairwayYesButton.layer.cornerRadius = 5.0
        holeFairwayNoButton.layer.cornerRadius = 5.0
        previousButton.layer.cornerRadius = 2.0
        nextButton.layer.cornerRadius = 2.0
        
        
            //initialize hole1 values
        navigationItem.title = courseName
        holeNumber.text = "\(holeNumberCounter)"
        holePar.text = "\(course1Par)"
        holeYards.text = "\(course1Yards)"
        userScoreToParLabel.text = "E"
        holeScoreTextField.text = ""
        holePuttsTextField.text = ""
        changeGIRNo()
        changeFairwayNo()
        
        
            //calling extension function from HomeViewController
        self.hideKeyboardWhenTappedAround()
    
    }

//This function will call the next hole after error checking
    @IBAction func nextHoleButton(_ sender: Any) {
        
            //This code stops from going to next hole when on hole 18
        if(holeNumberCounter == 18)
        {
            
            updateUserStats(courseHole: holeNumberCounter)
            calcScoreToPar(whatHole: holeNumberCounter)
            hole18flag = true
            
            let noHoleAlert1 = UIAlertController(title: "No Hole Alert!", message: "You cannot go to the next hole. You are on Hole #18!", preferredStyle: .alert)
            
            noHoleAlert1.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(noHoleAlert1, animated: true)
        }
        else
        {
            if(errorCheck())
            {
                updateUserStats(courseHole: holeNumberCounter)
            
            
                if(holeNumberCounter > actualHole)
                {
                    actualHole = holeNumberCounter
                }
                calcScoreToPar(whatHole: actualHole)
            
                holeNumberCounter += 1
                setupHole(holeCounter: holeNumberCounter, toPar: userScoreToPar)
            }
        }
    }
    
        //This takes you to the previous hole
    @IBAction func prevHoleButton(_ sender: Any) {
        
            //If hole number one it doesn't let you go to the previous hole
        if(holeNumberCounter == 1)
        {
            let noHoleAlert = UIAlertController(title: "No Hole Alert!", message: "You cannot go to a previous hole. You are on Hole #1!", preferredStyle: .alert)
            
            noHoleAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(noHoleAlert, animated: true)
        }
        else
        {
            holeNumberCounter -= 1
            setupHole(holeCounter: holeNumberCounter, toPar: userScoreToPar)
        
            switch holeNumberCounter {
                case 1:
                    fairwayHit = hole1F
                    GIRHit = hole1G
                case 2:
                    fairwayHit = hole2F
                    GIRHit = hole2G
                case 3:
                    fairwayHit = hole3F
                    GIRHit = hole3G
                case 4:
                    fairwayHit = hole4F
                    GIRHit = hole4G
                case 5:
                    fairwayHit = hole5F
                    GIRHit = hole5G
                case 6:
                    fairwayHit = hole6F
                    GIRHit = hole6G
                case 7:
                    fairwayHit = hole7F
                    GIRHit = hole7G
                case 8:
                    fairwayHit = hole8F
                    GIRHit = hole8G
                case 9:
                    fairwayHit = hole9F
                    GIRHit = hole9G
                case 10:
                    fairwayHit = hole10F
                    GIRHit = hole10G
                case 11:
                    fairwayHit = hole11F
                    GIRHit = hole11G
                case 12:
                    fairwayHit = hole12F
                    GIRHit = hole12G
                case 13:
                    fairwayHit = hole13F
                    GIRHit = hole13G
                case 14:
                    fairwayHit = hole14F
                    GIRHit = hole14G
                case 15:
                    fairwayHit = hole15F
                    GIRHit = hole15G
                case 16:
                    fairwayHit = hole16F
                    GIRHit = hole16G
                case 17:
                    fairwayHit = hole17F
                    GIRHit = hole17G
                case 18:
                    fairwayHit = hole18F
                    GIRHit = hole18G
                default:
                    break
            }
            
            updateUserStats(courseHole: holeNumberCounter)
        }
    }
   
        //Error checking
    func errorCheck() -> Bool
    {
        var toNextHole = true
        
        
        //soft Errors. High numbers that may be a typo.
        if((holeScoreTextField.text! as NSString).integerValue > 9 && badUserScoreFlag == false) {
            let scoreAlert = UIAlertController(title: "Score Alert!", message: "You have entered a score higher than 9. Is this correct?", preferredStyle: .alert)
            
            scoreAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(scoreAlert, animated: true)
            
            scoreAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                //self.updateUserStats(courseHole: self.holeNumberCounter)
            }))
            
            badUserScoreFlag = true
            toNextHole = false
        }
        
        if((holePuttsTextField.text! as NSString).integerValue > 3 && badUserPuttsFlag == false) {
            let puttsAlert = UIAlertController(title: "Putts Alert!", message: "You have entered more than 3 putts. Is this correct?", preferredStyle: .alert)
            
            puttsAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            puttsAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                //self.updateUserStats(courseHole: self.holeNumberCounter)
            }))
            self.present(puttsAlert, animated: true)
            
            badUserPuttsFlag = true
            toNextHole = false
        }
        if((holeScoreTextField.text! as NSString).integerValue <= (holePuttsTextField.text! as NSString).integerValue || holeScoreTextField.text!.isEmpty || holePuttsTextField.text!.isEmpty)
        {
            var alert = UIAlertController(title: "Error!", message: "Basic Error.", preferredStyle: .alert)
            if(holeScoreTextField.text!.isEmpty || holePuttsTextField.text!.isEmpty)
            {
                alert = UIAlertController(title: "Error!", message: "Score and Putts must have a value.", preferredStyle: .alert)
            }
            else
            {
                alert = UIAlertController(title: "Error!", message: "Putts must be less than Score.", preferredStyle: .alert)
            }
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
            
        else{
            if(toNextHole == true)
            {
                return true
            }
            else if(toNextHole == false)
            {
                if(badUserScoreFlag == true && (holePuttsTextField.text! as NSString).integerValue <= 3)
                {
                    return true
                }
            }
            else if(badUserScoreFlag == true && badUserPuttsFlag == true)
            {
                return true
            }
            
        }
        return false
    }
   
        //This calcualates the userScoreToPar (+1, -2, etc..)
    func calcScoreToPar(whatHole: Int)
    {
        
        switch whatHole {
        case 1:
            userScoreToPar = (hole1S - course1Par)
        case 2:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par)
        case 3:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par)
        case 4:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par)
        case 5:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par)
        case 6:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par)
        case 7:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par)
        case 8:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par)
        case 9:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par) + (hole9S - course9Par)
        case 10:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par) + (hole9S - course9Par) + (hole10S - course10Par)
        case 11:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par) + (hole9S - course9Par) + (hole10S - course10Par) + (hole11S - course11Par)
        case 12:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par) + (hole9S - course9Par) + (hole10S - course10Par) + (hole11S - course11Par) + (hole12S - course12Par)
        case 13:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par) + (hole9S - course9Par) + (hole10S - course10Par) + (hole11S - course11Par) + (hole12S - course12Par) + (hole13S - course13Par)
        case 14:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par) + (hole9S - course9Par) + (hole10S - course10Par) + (hole11S - course11Par) + (hole12S - course12Par) + (hole13S - course13Par) + (hole14S - course14Par)
        case 15:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par) + (hole9S - course9Par) + (hole10S - course10Par) + (hole11S - course11Par) + (hole12S - course12Par) + (hole13S - course13Par) + (hole14S - course14Par) + (hole15S - course15Par)
        case 16:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par) + (hole9S - course9Par) + (hole10S - course10Par) + (hole11S - course11Par) + (hole12S - course12Par) + (hole13S - course13Par) + (hole14S - course14Par) + (hole15S - course15Par) + (hole16S - course16Par)
        case 17:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par) + (hole9S - course9Par) + (hole10S - course10Par) + (hole11S - course11Par) + (hole12S - course12Par) + (hole13S - course13Par) + (hole14S - course14Par) + (hole15S - course15Par) + (hole16S - course16Par) + (hole17S - course17Par)
        case 18:
            userScoreToPar = (hole1S - course1Par) + (hole2S - course2Par) + (hole3S - course3Par) + (hole4S - course4Par) + (hole5S - course5Par) + (hole6S - course6Par) + (hole7S - course7Par) + (hole8S - course8Par) + (hole9S - course9Par) + (hole10S - course10Par) + (hole11S - course11Par) + (hole12S - course12Par) + (hole13S - course13Par) + (hole14S - course14Par) + (hole15S - course15Par) + (hole16S - course16Par) + (hole17S - course17Par) + (hole18S - course18Par)
        default:
            break
        }
        
    }
//Update User Stats
    func updateUserStats(courseHole: Int)
    {
        switch holeNumberCounter {
        case 1:
            hole1S = (holeScoreTextField.text! as NSString).integerValue
            hole1P = (holePuttsTextField.text! as  NSString).integerValue
            hole1Pl = true
            if(fairwayHit == true)
            {
                hole1F = true
            }
            else
            {
                hole1F = false
            }
            
            if(GIRHit == true)
            {
                hole1G = true
            }
            else
            {
                hole1G = false
            }
        case 2:
            hole2S = (holeScoreTextField.text! as NSString).integerValue
            hole2P = (holePuttsTextField.text! as  NSString).integerValue
            hole2Pl = true
            if(fairwayHit == true)
            {
                hole2F = true
            }
            else
            {
                hole2F = false
            }
            
            if(GIRHit == true)
            {
                hole2G = true
            }
            else
            {
                hole2G = false
            }
        case 3:
            hole3S = (holeScoreTextField.text! as NSString).integerValue
            hole3P = (holePuttsTextField.text! as  NSString).integerValue
            hole3Pl = true
            if(fairwayHit == true)
            {
                hole3F = true
            }
            else
            {
                hole3F = false
            }
            
            if(GIRHit == true)
            {
                hole3G = true
            }
            else
            {
                hole3G = false
            }
        case 4:
            hole4S = (holeScoreTextField.text! as NSString).integerValue
            hole4P = (holePuttsTextField.text! as  NSString).integerValue
            hole4Pl = true
            if(fairwayHit == true)
            {
                hole4F = true
            }
            else
            {
                hole4F = false
            }
            
            if(GIRHit == true)
            {
                hole4G = true
            }
            else
            {
                hole4G = false
            }
        case 5:
            hole5S = (holeScoreTextField.text! as NSString).integerValue
            hole5P = (holePuttsTextField.text! as  NSString).integerValue
            hole5Pl = true
            if(fairwayHit == true)
            {
                hole5F = true
            }
            else
            {
                hole5F = false
            }
            
            if(GIRHit == true)
            {
                hole5G = true
            }
            else
            {
                hole5G = false
            }
        case 6:
            hole6S = (holeScoreTextField.text! as NSString).integerValue
            hole6P = (holePuttsTextField.text! as  NSString).integerValue
            hole6Pl = true
            if(fairwayHit == true)
            {
                hole6F = true
            }
            else
            {
                hole6F = false
            }
            
            if(GIRHit == true)
            {
                hole6G = true
            }
            else
            {
                hole6G = false
            }
        case 7:
            hole7S = (holeScoreTextField.text! as NSString).integerValue
            hole7P = (holePuttsTextField.text! as  NSString).integerValue
            hole7Pl = true
            if(fairwayHit == true)
            {
                hole7F = true
            }
            else
            {
                hole7F = false
            }
            
            if(GIRHit == true)
            {
                hole7G = true
            }
            else
            {
                hole7G = false
            }
        case 8:
            hole8S = (holeScoreTextField.text! as NSString).integerValue
            hole8P = (holePuttsTextField.text! as  NSString).integerValue
            hole8Pl = true
            if(fairwayHit == true)
            {
                hole8F = true
            }
            else
            {
                hole8F = false
            }
            
            if(GIRHit == true)
            {
                hole8G = true
            }
            else
            {
                hole8G = false
            }
        case 9:
            hole9S = (holeScoreTextField.text! as NSString).integerValue
            hole9P = (holePuttsTextField.text! as  NSString).integerValue
            hole9Pl = true
            if(fairwayHit == true)
            {
                hole9F = true
            }
            else
            {
                hole9F = false
            }
            
            if(GIRHit == true)
            {
                hole9G = true
            }
            else
            {
                hole9G = false
            }
        case 10:
            hole10S = (holeScoreTextField.text! as NSString).integerValue
            hole10P = (holePuttsTextField.text! as  NSString).integerValue
            hole10Pl = true
            if(fairwayHit == true)
            {
                hole10F = true
            }
            else
            {
                hole10F = false
            }
            
            if(GIRHit == true)
            {
                hole10G = true
            }
            else
            {
                hole10G = false
            }
        case 11:
            hole11S = (holeScoreTextField.text! as NSString).integerValue
            hole11P = (holePuttsTextField.text! as  NSString).integerValue
            hole11Pl = true
            if(fairwayHit == true)
            {
                hole11F = true
            }
            else
            {
                hole11F = false
            }
            
            if(GIRHit == true)
            {
                hole11G = true
            }
            else
            {
                hole11G = false
            }
        case 12:
            hole12S = (holeScoreTextField.text! as NSString).integerValue
            hole12P = (holePuttsTextField.text! as  NSString).integerValue
            hole12Pl = true
            if(fairwayHit == true)
            {
                hole12F = true
            }
            else
            {
                hole12F = false
            }
            
            if(GIRHit == true)
            {
                hole12G = true
            }
            else
            {
                hole12G = false
            }
        case 13:
            hole13S = (holeScoreTextField.text! as NSString).integerValue
            hole13P = (holePuttsTextField.text! as  NSString).integerValue
            hole13Pl = true
            if(fairwayHit == true)
            {
                hole13F = true
            }
            else
            {
                hole13F = false
            }
            
            if(GIRHit == true)
            {
                hole13G = true
            }
            else
            {
                hole13G = false
            }
        case 14:
            hole14S = (holeScoreTextField.text! as NSString).integerValue
            hole14P = (holePuttsTextField.text! as  NSString).integerValue
            hole14Pl = true
            if(fairwayHit == true)
            {
                hole14F = true
            }
            else
            {
                hole14F = false
            }
            
            if(GIRHit == true)
            {
                hole14G = true
            }
            else
            {
                hole14G = false
            }
        case 15:
            hole15S = (holeScoreTextField.text! as NSString).integerValue
            hole15P = (holePuttsTextField.text! as  NSString).integerValue
            hole15Pl = true
            if(fairwayHit == true)
            {
                hole15F = true
            }
            else
            {
                hole15F = false
            }
            
            if(GIRHit == true)
            {
                hole15G = true
            }
            else
            {
                hole15G = false
            }
        case 16:
            hole16S = (holeScoreTextField.text! as NSString).integerValue
            hole16P = (holePuttsTextField.text! as  NSString).integerValue
            hole16Pl = true
            if(fairwayHit == true)
            {
                hole16F = true
            }
            else
            {
                hole16F = false
            }
            
            if(GIRHit == true)
            {
                hole16G = true
            }
            else
            {
                hole16G = false
            }
        case 17:
            hole17S = (holeScoreTextField.text! as NSString).integerValue
            hole17P = (holePuttsTextField.text! as  NSString).integerValue
            hole17Pl = true
            if(fairwayHit == true)
            {
                hole17F = true
            }
            else
            {
                hole17F = false
            }
            
            if(GIRHit == true)
            {
                hole17G = true
            }
            else
            {
                hole17G = false
            }
        case 18:
            hole18S = (holeScoreTextField.text! as NSString).integerValue
            hole18P = (holePuttsTextField.text! as  NSString).integerValue
            hole18Pl = true
            if(fairwayHit == true)
            {
                hole18F = true
            }
            else
            {
                hole18F = false
            }
            
            if(GIRHit == true)
            {
                hole18G = true
            }
            else
            {
                hole18G = false
            }
        default:
            break
        }

    }
        
//SetUp next Hole: increment hole number and setUp Next hole#, par, and yards
    
    func setupHole(holeCounter: Int, toPar: Int)
    {

        
    //Changing fields
        if(toPar == 0)
        {
            userScoreToParLabel.text = "E"
        }
        else if(toPar > 0)
        {
            userScoreToParLabel.text = "+" + "\(toPar)"
        }
        else
        {
            userScoreToParLabel.text = "\(toPar)"
        }
        
        holeScoreTextField.text = ""
        holePuttsTextField.text = ""
    
        fairwayHit = false
        GIRHit = false
        
        self.holeGIRYesButton.backgroundColor = UIColor.white
        self.holeGIRYesButton.setTitleColor(.blue, for: .normal)
        
        self.holeGIRNoButton.backgroundColor = UIColor.white
        self.holeGIRNoButton.setTitleColor(.blue, for: .normal)
        
        self.holeFairwayNoButton.backgroundColor = UIColor.white
        self.holeFairwayNoButton.setTitleColor(.blue, for: .normal)
        
        self.holeFairwayYesButton.backgroundColor = UIColor.white
        self.holeFairwayYesButton.setTitleColor(.blue, for: .normal)
        
        badUserPuttsFlag = false
        badUserScoreFlag = false
        
        
        holeNumber.text = "\(holeCounter)"
     
    //non changing fields
        switch holeCounter {
        case 1:
            holePar.text = "\(course1Par)"
            holeYards.text = "\(course1Yards)"
            if(hole1Pl == true)
            {
                holeScoreTextField.text = "\(hole1S)"
                holePuttsTextField.text = "\(hole1P)"
            }
            if(hole1F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole1G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 2:
            holePar.text = "\(course2Par)"
            holeYards.text = "\(course2Yards)"
            if(hole2Pl == true)
            {
                holeScoreTextField.text = "\(hole2S)"
                holePuttsTextField.text = "\(hole2P)"
            }
            if(hole2F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole2G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 3:
            holePar.text = "\(course3Par)"
            holeYards.text = "\(course3Yards)"
            if(hole3Pl == true)
            {
                holeScoreTextField.text = "\(hole3S)"
                holePuttsTextField.text = "\(hole3P)"
            }
            if(hole3F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole3G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 4:
            holePar.text = "\(course4Par)"
            holeYards.text = "\(course4Yards)"
            if(hole4Pl == true)
            {
                holeScoreTextField.text = "\(hole4S)"
                holePuttsTextField.text = "\(hole4P)"
            }
            if(hole4F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole4G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 5:
            holePar.text = "\(course5Par)"
            holeYards.text = "\(course5Yards)"
            if(hole5Pl == true)
            {
                holeScoreTextField.text = "\(hole5S)"
                holePuttsTextField.text = "\(hole5P)"
            }
            if(hole5F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole5G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 6:
            holePar.text = "\(course6Par)"
            holeYards.text = "\(course6Yards)"
            if(hole6Pl == true)
            {
                holeScoreTextField.text = "\(hole6S)"
                holePuttsTextField.text = "\(hole6P)"
            }
            if(hole6F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole6G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 7:
            holePar.text = "\(course7Par)"
            holeYards.text = "\(course7Yards)"
            if(hole7Pl == true)
            {
                holeScoreTextField.text = "\(hole7S)"
                holePuttsTextField.text = "\(hole7P)"
            }
            if(hole7F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole7G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 8:
            holePar.text = "\(course8Par)"
            holeYards.text = "\(course8Yards)"
            if(hole8Pl == true)
            {
                holeScoreTextField.text = "\(hole8S)"
                holePuttsTextField.text = "\(hole8P)"
            }
            if(hole8F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole8G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 9:
            holePar.text = "\(course9Par)"
            holeYards.text = "\(course9Yards)"
            if(hole9Pl == true)
            {
                holeScoreTextField.text = "\(hole9S)"
                holePuttsTextField.text = "\(hole9P)"
            }
            if(hole9F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole9G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 10:
            holePar.text = "\(course10Par)"
            holeYards.text = "\(course10Yards)"
            if(hole10Pl == true)
            {
                holeScoreTextField.text = "\(hole10S)"
                holePuttsTextField.text = "\(hole10P)"
            }
            if(hole10F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole10G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 11:
            holePar.text = "\(course11Par)"
            holeYards.text = "\(course11Yards)"
            if(hole11Pl == true)
            {
                holeScoreTextField.text = "\(hole11S)"
                holePuttsTextField.text = "\(hole11P)"
            }
            if(hole11F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole11G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 12:
            holePar.text = "\(course12Par)"
            holeYards.text = "\(course12Yards)"
            if(hole12Pl == true)
            {
                holeScoreTextField.text = "\(hole12S)"
                holePuttsTextField.text = "\(hole12P)"
            }
            if(hole12F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole12G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 13:
            holePar.text = "\(course13Par)"
            holeYards.text = "\(course13Yards)"
            if(hole13Pl == true)
            {
                holeScoreTextField.text = "\(hole13S)"
                holePuttsTextField.text = "\(hole13P)"
            }
            if(hole13F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole13G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 14:
            holePar.text = "\(course14Par)"
            holeYards.text = "\(course14Yards)"
            if(hole14Pl == true)
            {
                holeScoreTextField.text = "\(hole14S)"
                holePuttsTextField.text = "\(hole14P)"
            }
            if(hole14F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole14G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 15:
            holePar.text = "\(course15Par)"
            holeYards.text = "\(course15Yards)"
            if(hole15Pl == true)
            {
                holeScoreTextField.text = "\(hole15S)"
                holePuttsTextField.text = "\(hole15P)"
            }
            if(hole15F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole15G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 16:
            holePar.text = "\(course16Par)"
            holeYards.text = "\(course16Yards)"
            if(hole16Pl == true)
            {
                holeScoreTextField.text = "\(hole16S)"
                holePuttsTextField.text = "\(hole16P)"
            }
            if(hole16F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole16G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 17:
            holePar.text = "\(course17Par)"
            holeYards.text = "\(course17Yards)"
            if(hole17Pl == true)
            {
                holeScoreTextField.text = "\(hole17S)"
                holePuttsTextField.text = "\(hole17P)"
            }
            if(hole17F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole17G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        case 18:
            holePar.text = "\(course18Par)"
            holeYards.text = "\(course18Yards)"
            if(hole18Pl == true)
            {
                holeScoreTextField.text = "\(hole18S)"
                holePuttsTextField.text = "\(hole18P)"
            }
            if(hole18F == true)
            {
                changeFairwayYes()
            }
            else
            {
                changeFairwayNo()
            }
            
            if(hole18G == true)
            {
                changeGIRYes()
            }
            else
            {
                changeGIRNo()
            }
        default:
            break
        }
    
    }
    
    func changeGIRYes()
    {
        self.holeGIRYesButton.backgroundColor = UIColor.green
        self.holeGIRYesButton.setTitleColor(.black, for: .normal)
        self.holeGIRNoButton.backgroundColor = UIColor.clear
        self.holeGIRNoButton.setTitleColor(.black, for: .normal)
        
    }
    
    func changeGIRNo()
    {
        self.holeGIRNoButton.backgroundColor = UIColor.red
        self.holeGIRNoButton.setTitleColor(.black, for: .normal)
        self.holeGIRYesButton.backgroundColor = UIColor.clear
        self.holeGIRYesButton.setTitleColor(.black, for: .normal)
    }
    
    func changeFairwayYes()
    {
        self.holeFairwayYesButton.backgroundColor = UIColor.green
        self.holeFairwayYesButton.setTitleColor(.black, for: .normal)
        self.holeFairwayNoButton.backgroundColor = UIColor.clear
        self.holeFairwayNoButton.setTitleColor(.black, for: .normal)
    }
    
    func changeFairwayNo()
    {
        self.holeFairwayNoButton.backgroundColor = UIColor.red
        self.holeFairwayNoButton.setTitleColor(.black, for: .normal)
        self.holeFairwayYesButton.backgroundColor = UIColor.clear
        self.holeFairwayYesButton.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func GIRYes(_ sender: Any) {
        GIRHit = true
        changeGIRYes()
    }
    
    @IBAction func GIRNo(_ sender: Any) {
        GIRHit = false
        changeGIRNo()
    }

    
    @IBAction func fairwayYes(_ sender: Any) {
        fairwayHit = true
        changeFairwayYes()
    }
    
    @IBAction func fairwayNo(_ sender: Any) {
        fairwayHit = false
        changeFairwayNo()
    }
    
        //can use some kind of parameter to choose between courses in the list then use if statements for what plist gets read.
    func readCourse()
    {
        var path = Bundle.main.path(forResource: "sycamoreCourse", ofType: "plist")!
        switch courseChoiceHole {
        case 1:
            path = Bundle.main.path(forResource: "sycamoreCourse", ofType: "plist")!
        case 2:
            path = Bundle.main.path(forResource: "kishwaukeeCourse", ofType: "plist")!
        case 3:
            path = Bundle.main.path(forResource: "emeraldHillCourse", ofType: "plist")!
        default:
            break
        }
        
        let courseArray:NSArray = NSArray(contentsOfFile:path)!
        
        for course in courseArray {
            let dictionary: [String: Any] = (course as? Dictionary)!
            
            courseName = dictionary["Name"] as! String
            courseSlope = dictionary["Slope"] as! Int
            courseRating = dictionary["Rating"] as! Int
            coursetotalPar = dictionary["totalPar"] as! Int
            course1Par = dictionary["hole1Par"] as! Int
            course1Yards = dictionary["hole1Yards"] as! Int
            course2Par = dictionary["hole2Par"] as! Int
            course2Yards = dictionary["hole2Yards"] as! Int
            course3Par = dictionary["hole3Par"] as! Int
            course3Yards = dictionary["hole3Yards"] as! Int
            course4Par = dictionary["hole4Par"] as! Int
            course4Yards = dictionary["hole4Yards"] as! Int
            course5Par = dictionary["hole5Par"] as! Int
            course5Yards = dictionary["hole5Yards"] as! Int
            course6Par = dictionary["hole6Par"] as! Int
            course6Yards = dictionary["hole6Yards"] as! Int
            course7Par = dictionary["hole7Par"] as! Int
            course7Yards = dictionary["hole7Yards"] as! Int
            course8Par = dictionary["hole8Par"] as! Int
            course8Yards = dictionary["hole8Yards"] as! Int
            course9Par = dictionary["hole9Par"] as! Int
            course9Yards = dictionary["hole9Yards"] as! Int
            course10Par = dictionary["hole10Par"] as! Int
            course10Yards = dictionary["hole10Yards"] as! Int
            course11Par = dictionary["hole11Par"] as! Int
            course11Yards = dictionary["hole11Yards"] as! Int
            course12Par = dictionary["hole12Par"] as! Int
            course12Yards = dictionary["hole12Yards"] as! Int
            course13Par = dictionary["hole13Par"] as! Int
            course13Yards = dictionary["hole13Yards"] as! Int
            course14Par = dictionary["hole14Par"] as! Int
            course14Yards = dictionary["hole14Yards"] as! Int
            course15Par = dictionary["hole15Par"] as! Int
            course15Yards = dictionary["hole15Yards"] as! Int
            course16Par = dictionary["hole16Par"] as! Int
            course16Yards = dictionary["hole16Yards"] as! Int
            course17Par = dictionary["hole17Par"] as! Int
            course17Yards = dictionary["hole17Yards"] as! Int
            course18Par = dictionary["hole18Par"] as! Int
            course18Yards = dictionary["hole18Yards"] as! Int
        }
    }
    
    
    @IBAction func cancelRound(_ sender: Any) {
        
        let cancelRoundAlert = UIAlertController(title: "Cancel Round", message: "You are about to cancel the round. You will lose this rounds data. Are you sure you want to cancel?", preferredStyle: .alert)
        
        cancelRoundAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        cancelRoundAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(cancelRoundAlert, animated: true)
    }
    
    
    @IBAction func saveRound(_ sender: Any) {
    
        let saveRoundHoleAlert = UIAlertController(title: "Save Round", message: "You are about to save the round. This prevents any more changes. Are you sure you want to save?", preferredStyle: .alert)
        
        saveRoundHoleAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.performSave()
            self.navigationController?.popViewController(animated: true)
        }))
        saveRoundHoleAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(saveRoundHoleAlert, animated: true)
    }
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func performSave()
    {
        let newRound = NSEntityDescription.insertNewObject(forEntityName: "GolfRound", into: context)
        newRound.setValue(courseName, forKey: "courseName")
        newRound.setValue(Date(), forKey: "date")
        newRound.setValue(hole1F, forKey: "hole1F")
        newRound.setValue(hole2F, forKey: "hole2F")
        newRound.setValue(hole3F, forKey: "hole3F")
        newRound.setValue(hole4F, forKey: "hole4F")
        newRound.setValue(hole5F, forKey: "hole5F")
        newRound.setValue(hole6F, forKey: "hole6F")
        newRound.setValue(hole7F, forKey: "hole7F")
        newRound.setValue(hole8F, forKey: "hole8F")
        newRound.setValue(hole9F, forKey: "hole9F")
        newRound.setValue(hole10F, forKey: "hole10F")
        newRound.setValue(hole11F, forKey: "hole11F")
        newRound.setValue(hole12F, forKey: "hole12F")
        newRound.setValue(hole13F, forKey: "hole13F")
        newRound.setValue(hole14F, forKey: "hole14F")
        newRound.setValue(hole15F, forKey: "hole15F")
        newRound.setValue(hole16F, forKey: "hole16F")
        newRound.setValue(hole17F, forKey: "hole17F")
        newRound.setValue(hole18F, forKey: "hole18F")
        newRound.setValue(hole1G, forKey: "hole1G")
        newRound.setValue(hole2G, forKey: "hole2G")
        newRound.setValue(hole3G, forKey: "hole3G")
        newRound.setValue(hole4G, forKey: "hole4G")
        newRound.setValue(hole5G, forKey: "hole5G")
        newRound.setValue(hole6G, forKey: "hole6G")
        newRound.setValue(hole7G, forKey: "hole7G")
        newRound.setValue(hole8G, forKey: "hole8G")
        newRound.setValue(hole9G, forKey: "hole9G")
        newRound.setValue(hole10G, forKey: "hole10G")
        newRound.setValue(hole11G, forKey: "hole11G")
        newRound.setValue(hole12G, forKey: "hole12G")
        newRound.setValue(hole13G, forKey: "hole13G")
        newRound.setValue(hole14G, forKey: "hole14G")
        newRound.setValue(hole15G, forKey: "hole15G")
        newRound.setValue(hole16G, forKey: "hole16G")
        newRound.setValue(hole17G, forKey: "hole17G")
        newRound.setValue(hole18G, forKey: "hole18G")
        newRound.setValue(hole1P, forKey: "hole1Putts")
        newRound.setValue(hole2P, forKey: "hole2Putts")
        newRound.setValue(hole3P, forKey: "hole3Putts")
        newRound.setValue(hole4P, forKey: "hole4Putts")
        newRound.setValue(hole5P, forKey: "hole5Putts")
        newRound.setValue(hole6P, forKey: "hole6Putts")
        newRound.setValue(hole7P, forKey: "hole7Putts")
        newRound.setValue(hole8P, forKey: "hole8Putts")
        newRound.setValue(hole9P, forKey: "hole9Putts")
        newRound.setValue(hole10P, forKey: "hole10Putts")
        newRound.setValue(hole11P, forKey: "hole11Putts")
        newRound.setValue(hole12P, forKey: "hole12Putts")
        newRound.setValue(hole13P, forKey: "hole13Putts")
        newRound.setValue(hole14P, forKey: "hole14Putts")
        newRound.setValue(hole15P, forKey: "hole15Putts")
        newRound.setValue(hole16P, forKey: "hole16Putts")
        newRound.setValue(hole17P, forKey: "hole17Putts")
        newRound.setValue(hole18P, forKey: "hole18Putts")
        newRound.setValue(hole1S, forKey: "hole1Score")
        newRound.setValue(hole2S, forKey: "hole2Score")
        newRound.setValue(hole3S, forKey: "hole3Score")
        newRound.setValue(hole4S, forKey: "hole4Score")
        newRound.setValue(hole5S, forKey: "hole5Score")
        newRound.setValue(hole6S, forKey: "hole6Score")
        newRound.setValue(hole7S, forKey: "hole7Score")
        newRound.setValue(hole8S, forKey: "hole8Score")
        newRound.setValue(hole9S, forKey: "hole9Score")
        newRound.setValue(hole10S, forKey: "hole10Score")
        newRound.setValue(hole11S, forKey: "hole11Score")
        newRound.setValue(hole12S, forKey: "hole12Score")
        newRound.setValue(hole13S, forKey: "hole13Score")
        newRound.setValue(hole14S, forKey: "hole14Score")
        newRound.setValue(hole15S, forKey: "hole15Score")
        newRound.setValue(hole16S, forKey: "hole16Score")
        newRound.setValue(hole17S, forKey: "hole17Score")
        newRound.setValue(hole18S, forKey: "hole18Score")
        newRound.setValue(totalFairways, forKey: "totalFairways")
        newRound.setValue(totalGIRs, forKey: "totalGir")
        newRound.setValue(totalPutts, forKey: "totalPutts")
        newRound.setValue(totalScore, forKey: "totalScore")
        newRound.setValue(userScoreToPar, forKey: "scoreToPar")
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
        //This prepares for round summary
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(hole18flag == false)
        {
            if(holeNumberCounter == 18)
            {
                updateUserStats(courseHole: holeNumberCounter)
                calcScoreToPar(whatHole: holeNumberCounter)
            }
        }
        
        if(segue.identifier == "endRound")
        {
            totalGIRs = 0
            totalFairways = 0
            let endVC = segue.destination as! endRoundViewController
            totalScore = (hole1S + hole2S + hole3S + hole4S + hole5S + hole6S + hole7S + hole8S + hole9S + hole10S + hole11S + hole12S + hole13S + hole14S + hole15S + hole16S + hole17S + hole18S)
            totalPutts = (hole1P + hole2P + hole3P + hole4P + hole5P + hole6P + hole7P + hole8P + hole9P + hole10P + hole11P + hole12P + hole13P + hole14P + hole15P + hole16P + hole17P + hole18P)
            
            if(hole1G == true) { totalGIRs += 1 }
            if(hole2G == true) { totalGIRs += 1 }
            if(hole3G == true) { totalGIRs += 1 }
            if(hole4G == true) { totalGIRs += 1 }
            if(hole5G == true) { totalGIRs += 1 }
            if(hole6G == true) { totalGIRs += 1 }
            if(hole7G == true) { totalGIRs += 1 }
            if(hole8G == true) { totalGIRs += 1 }
            if(hole9G == true) { totalGIRs += 1 }
            if(hole10G == true) { totalGIRs += 1 }
            if(hole11G == true) { totalGIRs += 1 }
            if(hole12G == true) { totalGIRs += 1 }
            if(hole13G == true) { totalGIRs += 1 }
            if(hole14G == true) { totalGIRs += 1 }
            if(hole15G == true) { totalGIRs += 1 }
            if(hole16G == true) { totalGIRs += 1 }
            if(hole17G == true) { totalGIRs += 1 }
            if(hole18G == true) { totalGIRs += 1 }
            
            if(hole1F == true) { totalFairways += 1 }
            if(hole2F == true) { totalFairways += 1 }
            if(hole3F == true) { totalFairways += 1 }
            if(hole4F == true) { totalFairways += 1 }
            if(hole5F == true) { totalFairways += 1 }
            if(hole6F == true) { totalFairways += 1 }
            if(hole7F == true) { totalFairways += 1 }
            if(hole8F == true) { totalFairways += 1 }
            if(hole9F == true) { totalFairways += 1 }
            if(hole10F == true) { totalFairways += 1 }
            if(hole11F == true) { totalFairways += 1 }
            if(hole12F == true) { totalFairways += 1 }
            if(hole13F == true) { totalFairways += 1 }
            if(hole14F == true) { totalFairways += 1 }
            if(hole15F == true) { totalFairways += 1 }
            if(hole16F == true) { totalFairways += 1 }
            if(hole17F == true) { totalFairways += 1 }
            if(hole18F == true) { totalFairways += 1 }
            
            
            endVC.endScore = totalScore
            endVC.endPutts = totalPutts
            endVC.endGIR = totalGIRs
            endVC.endFairway = totalFairways
            endVC.endScoreToPar = userScoreToPar
        }
    }
}

























