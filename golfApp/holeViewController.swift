//
//  holeViewController.swift
//  golfApp
//
//Name/Author: John Brechon

// This viewController deals with all the calculations for each hole

import UIKit
import CoreData
import Unbox

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

//played?
    var holePl = [Bool](repeating: false, count: 18)

//fairways
    var holeF = [Bool](repeating: false, count: 18)

//GIRs
    var holeG = [Bool](repeating: false, count: 18)

//Putts
    var holePutts = [Int](repeating: 0, count: 18)

//Score
    var holeScore = [Int](repeating: 0, count: 18)

    var course: Course?
    var round: Round?
    
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
        print(courseChoiceHole)
            //adding formatting to holeView Buttons
        holeGIRYesButton.layer.cornerRadius = 5.0
        holeGIRNoButton.layer.cornerRadius = 5.0
        holeFairwayYesButton.layer.cornerRadius = 5.0
        holeFairwayNoButton.layer.cornerRadius = 5.0
        previousButton.layer.cornerRadius = 2.0
        nextButton.layer.cornerRadius = 2.0
        
        
            //initialize hole1 values
        navigationItem.title = course?.name
        holeNumber.text = "\(holeNumberCounter)"
        holePar.text = "\(course!.holes[0].par)"
        holeYards.text = "\(course!.holes[0].yards)"
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
            //calcScoreToPar(whatHole: holeNumberCounter)
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
                //calcScoreToPar(whatHole: actualHole)
            
                holeNumberCounter += 1
                //setupHole(holeCounter: holeNumberCounter, toPar: userScoreToPar)
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
            //setupHole(holeCounter: holeNumberCounter, toPar: userScoreToPar)
            let index = holeNumberCounter - 1
            fairwayHit = holeF[index]
            GIRHit = holeG[index]
            
            }
            
            updateUserStats(courseHole: holeNumberCounter)
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
/*    func calcScoreToPar(whatHole: Int)
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
 */
//Update User Stats
    func updateUserStats(courseHole: Int)
    {
        let index = holeNumberCounter - 1
        
        holeScore[index] = (holeScoreTextField.text! as NSString).integerValue
        holePutts[index] = (holePuttsTextField.text! as NSString).integerValue
        if fairwayHit {
            holeF[index] = true
        }
        else {
            holeF[index] = false
        }
        if GIRHit {
            holeG[index] = true
        }
        else {
            holeG[index] = false
        }
    }
        
//SetUp next Hole: increment hole number and setUp Next hole#, par, and yards
    
    func setupHole(holeCounter: Int, toPar: Int)
    {

        let index = holeCounter - 1
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
        holePar.text = "\(course!.holes[index].par)"
        holeYards.text = "\(course!.holes[index].yards)"
        if holePl[index] {
            holeScoreTextField.text = "\(holeScore[index])"
            holePuttsTextField.text = "\(holePutts[index])"
        }
        if holeF[index] {
            changeFairwayYes()
        }
        else {
            changeFairwayNo()
        }
        if holeG[index] {
            changeGIRYes()
        }
        else {
            changeGIRNo()
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
        
        var path = Bundle.main.url(forResource: "kish", withExtension: "json")!
        switch courseChoiceHole {
            case 1:
                path = Bundle.main.url(forResource: "sycamore", withExtension: "json")!
            case 2:
                path = Bundle.main.url(forResource: "kish", withExtension: "json")!
            case 3:
                path = Bundle.main.url(forResource: "emerald", withExtension: "json")!
            default:
                break
         }
        
        var data: Data?
        do {
            data = try Data(contentsOf: path)
        }
        catch {
            print(error)
        }
        
        do {
            course = try unbox(data: data!)
        }
        catch {
            print(error)
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
        //newRound.setValue(courseName, forKey: "courseName")
        newRound.setValue(Date(), forKey: "date")
        newRound.setValue(holeF[0], forKey: "hole1F")
        newRound.setValue(holeF[1], forKey: "hole2F")
        newRound.setValue(holeF[2], forKey: "hole3F")
        newRound.setValue(holeF[3], forKey: "hole4F")
        newRound.setValue(holeF[4], forKey: "hole5F")
        newRound.setValue(holeF[5], forKey: "hole6F")
        newRound.setValue(holeF[6], forKey: "hole7F")
        newRound.setValue(holeF[7], forKey: "hole8F")
        newRound.setValue(holeF[8], forKey: "hole9F")
        newRound.setValue(holeF[9], forKey: "hole10F")
        newRound.setValue(holeF[10], forKey: "hole11F")
        newRound.setValue(holeF[11], forKey: "hole12F")
        newRound.setValue(holeF[12], forKey: "hole13F")
        newRound.setValue(holeF[13], forKey: "hole14F")
        newRound.setValue(holeF[14], forKey: "hole15F")
        newRound.setValue(holeF[15], forKey: "hole16F")
        newRound.setValue(holeF[16], forKey: "hole17F")
        newRound.setValue(holeF[17], forKey: "hole18F")
        newRound.setValue(holeG[0], forKey: "hole1G")
        newRound.setValue(holeG[1], forKey: "hole2G")
        newRound.setValue(holeG[2], forKey: "hole3G")
        newRound.setValue(holeG[3], forKey: "hole4G")
        newRound.setValue(holeG[4], forKey: "hole5G")
        newRound.setValue(holeG[5], forKey: "hole6G")
        newRound.setValue(holeG[6], forKey: "hole7G")
        newRound.setValue(holeG[7], forKey: "hole8G")
        newRound.setValue(holeG[8], forKey: "hole9G")
        newRound.setValue(holeG[9], forKey: "hole10G")
        newRound.setValue(holeG[10], forKey: "hole11G")
        newRound.setValue(holeG[11], forKey: "hole12G")
        newRound.setValue(holeG[12], forKey: "hole13G")
        newRound.setValue(holeG[13], forKey: "hole14G")
        newRound.setValue(holeG[14], forKey: "hole15G")
        newRound.setValue(holeG[15], forKey: "hole16G")
        newRound.setValue(holeG[16], forKey: "hole17G")
        newRound.setValue(holeG[17], forKey: "hole18G")
        newRound.setValue(holePutts[0], forKey: "hole1Putts")
        newRound.setValue(holePutts[1], forKey: "hole2Putts")
        newRound.setValue(holePutts[2], forKey: "hole3Putts")
        newRound.setValue(holePutts[3], forKey: "hole4Putts")
        newRound.setValue(holePutts[4], forKey: "hole5Putts")
        newRound.setValue(holePutts[5], forKey: "hole6Putts")
        newRound.setValue(holePutts[6], forKey: "hole7Putts")
        newRound.setValue(holePutts[7], forKey: "hole8Putts")
        newRound.setValue(holePutts[8], forKey: "hole9Putts")
        newRound.setValue(holePutts[9], forKey: "hole10Putts")
        newRound.setValue(holePutts[10], forKey: "hole11Putts")
        newRound.setValue(holePutts[11], forKey: "hole12Putts")
        newRound.setValue(holePutts[12], forKey: "hole13Putts")
        newRound.setValue(holePutts[13], forKey: "hole14Putts")
        newRound.setValue(holePutts[14], forKey: "hole15Putts")
        newRound.setValue(holePutts[15], forKey: "hole16Putts")
        newRound.setValue(holePutts[16], forKey: "hole17Putts")
        newRound.setValue(holePutts[17], forKey: "hole18Putts")
        newRound.setValue(holeScore[0], forKey: "hole1Score")
        newRound.setValue(holeScore[1], forKey: "hole2Score")
        newRound.setValue(holeScore[2], forKey: "hole3Score")
        newRound.setValue(holeScore[3], forKey: "hole4Score")
        newRound.setValue(holeScore[4], forKey: "hole5Score")
        newRound.setValue(holeScore[5], forKey: "hole6Score")
        newRound.setValue(holeScore[6], forKey: "hole7Score")
        newRound.setValue(holeScore[7], forKey: "hole8Score")
        newRound.setValue(holeScore[8], forKey: "hole9Score")
        newRound.setValue(holeScore[9], forKey: "hole10Score")
        newRound.setValue(holeScore[10], forKey: "hole11Score")
        newRound.setValue(holeScore[11], forKey: "hole12Score")
        newRound.setValue(holeScore[12], forKey: "hole13Score")
        newRound.setValue(holeScore[13], forKey: "hole14Score")
        newRound.setValue(holeScore[14], forKey: "hole15Score")
        newRound.setValue(holeScore[15], forKey: "hole16Score")
        newRound.setValue(holeScore[16], forKey: "hole17Score")
        newRound.setValue(holeScore[17], forKey: "hole18Score")
        newRound.setValue(round?.totalFairways, forKey: "totalFairways")
        newRound.setValue(round?.totalGIRs, forKey: "totalGir")
        newRound.setValue(round?.totalPutts, forKey: "totalPutts")
        newRound.setValue(round?.totalScore, forKey: "totalScore")
        newRound.setValue(round?.userScoreToPar, forKey: "scoreToPar")
        
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
                //calcScoreToPar(whatHole: holeNumberCounter)
            }
        }
        
        if(segue.identifier == "endRound") {
            round?.totalGIRs = 0
            round?.totalFairways = 0
            let endVC = segue.destination as! endRoundViewController
            
            for x in 0..<18{
                round?.totalScore += holeScore[x]
                if holeF[x] {
                    round?.totalFairways += 1
                }
                if holeG[x] {
                    round?.totalGIRs += 1
                }
            }
            
            endVC.endScore = round!.totalScore
            endVC.endPutts = round!.totalPutts
            endVC.endGIR = round!.totalGIRs
            endVC.endFairway = round!.totalFairways
            endVC.endScoreToPar = round!.userScoreToPar
        }
    }
}
