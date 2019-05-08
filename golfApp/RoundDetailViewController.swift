//
//  RoundDetailViewController.swift
//  golfApp
//
//Name/Author: John Brechon


import UIKit

class RoundDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dcourseName: UILabel!
    @IBOutlet weak var ddate: UILabel!
    @IBOutlet weak var dStrokes: UILabel!
    @IBOutlet weak var dScoreToPar: UILabel!
    @IBOutlet weak var dPutts: UILabel!
    @IBOutlet weak var dGIRs: UILabel!
    @IBOutlet weak var dFIRs: UILabel!

    
    @IBOutlet weak var holeTableView: UITableView!
    
    var round: Round?
    var hole = 1
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
        holeTableView.delegate = self
        holeTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = holeTableView.dequeueReusableCell(withIdentifier: "HOLECELL") as! priorRoundHoleViewCell
        cell.holeLabel.text = "\(hole)"
        
        
        hole += 1
        print(cell)
        return cell
    }
    
}
