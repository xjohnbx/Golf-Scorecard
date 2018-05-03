//
//  HomeViewController.swift
//  golfApp
//
//Name/Author: John Brechon
//Z-ID: Z1750010
//CSCI 321/521, Spring 2018
//Activity: Student iOS Project


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
        
        //setting the background image
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "homeScreen.jpg")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        playRoundButton.layer.cornerRadius = 53.0
        priorRoundsButton.layer.cornerRadius = 5.0
        sycamoreGolfCourse.layer.cornerRadius = 5.0
        kishwaukeeCountryClub.layer.cornerRadius = 5.0
        emeraldHillGolfCourse.layer.cornerRadius = 5.0
        

        addRightNavigationBarInfoButton()
        
    }

        //Add the aboutApp button
    func addRightNavigationBarInfoButton() {
        let button = UIButton(type: .infoDark)
        button.addTarget(self, action: #selector(self.showAboutAppView), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func showAboutAppView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AboutAppNavigationController") as! UINavigationController
        
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func sycamoreChoice(_ sender: Any) {
        courseChoice = 1
        
        self.sycamoreGolfCourse.backgroundColor = UIColor.green
        self.sycamoreGolfCourse.setTitleColor(.black, for: .normal)
        
        self.kishwaukeeCountryClub.backgroundColor = UIColor.clear
        self.kishwaukeeCountryClub.setTitleColor(.black, for: .normal)
        
        self.emeraldHillGolfCourse.backgroundColor = UIColor.clear
        self.emeraldHillGolfCourse.setTitleColor(.black, for: .normal)
    }
   
    @IBAction func kishChoice(_ sender: Any) {
        courseChoice = 2
        
        self.kishwaukeeCountryClub.backgroundColor = UIColor.green
        self.kishwaukeeCountryClub.setTitleColor(.black, for: .normal)
        
        self.sycamoreGolfCourse.backgroundColor = UIColor.clear
        self.sycamoreGolfCourse.setTitleColor(.black, for: .normal)
        
        self.emeraldHillGolfCourse.backgroundColor = UIColor.clear
        self.emeraldHillGolfCourse.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func emeraldHillChoice(_ sender: Any) {
        courseChoice = 3
        
        self.emeraldHillGolfCourse.backgroundColor = UIColor.green
        self.emeraldHillGolfCourse.setTitleColor(.black, for: .normal)
        
        self.sycamoreGolfCourse.backgroundColor = UIColor.clear
        self.sycamoreGolfCourse.setTitleColor(.black, for: .normal)
        
        self.kishwaukeeCountryClub.backgroundColor = UIColor.clear
        self.kishwaukeeCountryClub.setTitleColor(.black, for: .normal)
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "playRound")
        {
            let holeVC = segue.destination as! holeViewController
            
            holeVC.courseChoiceHole = courseChoice
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Date {
    func asString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}
