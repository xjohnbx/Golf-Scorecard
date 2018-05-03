//
//  AboutAppViewController.swift
//  golfApp
//
//Name/Author: John Brechon
//Z-ID: Z1750010
//CSCI 321/521, Spring 2018
//Activity: Student iOS Project

import UIKit

class AboutAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "About App"
    }
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func aboutAuthorButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "AboutAuthorViewController") as! AboutAuthorViewController
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
