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
    var coreRound:Round?
    var fetchedHoles:[Hole]?
    
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
        
        previousButton.isHidden = true
        previousButton.isEnabled = false
        
        
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
        
        createRound()
        
        //calling extension function from HomeViewController
        self.hideKeyboardWhenTappedAround()
    
    }

//This function will call the next hole after error checking
    @IBAction func nextHoleButton(_ sender: Any) {
        
            //This code stops from going to next hole when on hole 18
       
        nextButton(hole: holeNumberCounter)
        
        if(errorCheck())
        {
            performHoleSave()
            //updateUserStats(courseHole: holeNumberCounter)
        
        
            if(holeNumberCounter > actualHole)
            {
                actualHole = holeNumberCounter
            }
            //calcScoreToPar(whatHole: actualHole)
        
            holeNumberCounter += 1
            setupHole(holeCounter: holeNumberCounter, toPar: 1)
        }
        
    }
    
        //This takes you to the previous hole
    @IBAction func prevHoleButton(_ sender: Any) {
        
        holeNumberCounter -= 1
        
        setupHole(holeCounter: holeNumberCounter, toPar: 1)
        let index = holeNumberCounter - 1
        fairwayHit = holeF[index]
        GIRHit = holeG[index]
        
//        updateUserStats(courseHole: holeNumberCounter)
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

/*
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
 
 */
    
//SetUp next Hole: increment hole number and setUp Next hole#, par, and yards
    
    func setupHole(holeCounter: Int, toPar: Int)
    {
        
        prevButton(hole: holeCounter)
        nextButton(hole: holeCounter)
        let index = holeCounter - 1
        
    //Changing fields
        userScoreToParLabel.text = coreRound!.scoreToPar.toParText(scoreToPar: Int(coreRound!.scoreToPar))
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
        
        if coreRound!.holes!.count >= holeCounter {
            holeScoreTextField.text = "\(coreRound!.holeArray![index].strokes)"
            holePuttsTextField.text = "\(coreRound!.holeArray![index].putts)"
            coreRound!.holeArray![index].fairwayHit ? changeFairwayYes() : changeFairwayNo()
            coreRound!.holeArray![index].girHit ? changeGIRYes() : changeGIRNo()
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
    
    func prevButton(hole: Int) {
        if hole == 1 {
            previousButton.isHidden = true
            previousButton.isEnabled = false
        }
        else {
            previousButton.isHidden = false
            previousButton.isEnabled = true
        }
    }
    
    func nextButton(hole: Int) {
        if hole == 18 {
            nextButton.isHidden = true
            nextButton.isEnabled = false
        }
        else {
            nextButton.isHidden = false
            nextButton.isEnabled = true
        }
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
/*
    let storyBoard: UIStoryboard = UIStoryboard(name: "Balance", bundle: nil)
    let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "balance") as! BalanceViewController
    self.present(balanceViewController, animated: true, completion: nil)
    */
    @IBAction func cancelRound(_ sender: Any) {
        
        let cancelRoundAlert = UIAlertController(title: "Cancel Round", message: "You are about to cancel the round. You will lose this rounds data. Are you sure you want to cancel?", preferredStyle: .alert)
        
        cancelRoundAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.deleteRound()
            self.backToHomeViewController()
        }))
        
        cancelRoundAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(cancelRoundAlert, animated: true)
    }
    
    @IBAction func saveRound(_ sender: Any) {
    
        let saveRoundHoleAlert = UIAlertController(title: "Save Round", message: "You are about to save the round. This prevents any more changes. Are you sure you want to save?", preferredStyle: .alert)
        
        saveRoundHoleAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            do {
                try self.coreRound?.managedObjectContext?.save()
            } catch {
                print("Round was not saved")
            }
            self.backToHomeViewController()
        }))
        saveRoundHoleAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(saveRoundHoleAlert, animated: true)
    }
    
    func backToHomeViewController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! HomeViewController
        self.present(homeViewController, animated: true, completion: nil)
    }
    
    func performHoleSave() {
        
        let holeNumber = holeNumberCounter
        let putts = Int(holePuttsTextField.text!)
        let strokes = Int(holeScoreTextField.text!)
        print(holeScoreTextField.text!)
        let gir = GIRHit
        let fairway = fairwayHit
        let scoreToPar = strokes! - course!.holes[holeNumberCounter - 1].par
        
        let hole = Hole(holeNumber: Int16(holeNumber), putts: Int16(putts!), strokes: Int16(strokes!), fairwayHit: fairway, girHit: gir)
        coreRound?.addToHoles(hole)
        do {
            try hole.managedObjectContext?.save()
        } catch {
            print("Hole was not saved")
        }
        editRoundValues(strokes: strokes!, putts: putts!, gir: gir, fairway: fairway, scoreToPar: scoreToPar)
    }
    
    func createRound()
    {
        coreRound = Round(courseName: (course?.name)!, date: Date(), scoreToPar: 0, totalFairways: 0, totalGIRs: 0, totalPutts: 0, totalScore: 0)
        
        do {
            try coreRound?.managedObjectContext?.save()
            
        } catch {
            print("Could not save round.")
        }
    }
    
    func editRoundValues(strokes: Int, putts: Int, gir: Bool, fairway: Bool, scoreToPar: Int) {
        coreRound?.totalScore += Int16(strokes)
        coreRound?.totalPutts += Int16(putts)
        coreRound?.scoreToPar += Int16(scoreToPar)
        if gir {
            coreRound?.totalGIRs += 1
        }
        if fairway {
            coreRound?.totalFairways += 1
        }
    }
    
    func deleteRound() {
        guard let managedContext = coreRound?.managedObjectContext else {
            return
        }
        
        managedContext.delete(coreRound!)
        
        do {
            try managedContext.save()
        } catch {
            print("Round not deleted.")
        }
    }
    
        //This prepares for round summary
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "endRound") {
            let endVC = segue.destination as! endRoundViewController
            endVC.endRound = coreRound
        }
    }
}
