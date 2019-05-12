//
//  RoundDetailViewController.swift
//  golfApp
//
//Name/Author: John Brechon


import UIKit

class RoundDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ddate: UILabel!
    @IBOutlet weak var dStrokes: UILabel!
    @IBOutlet weak var dScoreToPar: UILabel!
    @IBOutlet weak var dPutts: UILabel!
    @IBOutlet weak var dGIRs: UILabel!
    @IBOutlet weak var dFIRs: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var holeTableView: UITableView!
    
    var round: Round?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.title = round!.courseName
        dStrokes.text = "\(round!.totalScore)"
        ddate.text = round?.newDate?.asString(style: .short)
        
        let par = round!.scoreToPar.toParText(scoreToPar: Int(round!.scoreToPar))
 
        dScoreToPar.text = par
        dPutts.text = "\(round!.totalPutts)"
        dGIRs.text = "\(round!.totalGIRs)"
        dFIRs.text = "\(round!.totalFairways)"
        dStrokes.text = "\(round!.totalScore)"
        holeTableView.delegate = self
        holeTableView.dataSource = self
    }
    
    func fetchHoles() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return round!.holes!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = holeTableView.dequeueReusableCell(withIdentifier: "HOLECELL") as! priorRoundHoleViewCell
        
        cell.holeLabel.text = "\(String(describing: round!.holeArray![indexPath.row].holeNumber))"
        cell.scoreLabel.text = "\(String(describing: round!.holeArray![indexPath.row].strokes))"
        cell.puttsLabel.text = "\(String(describing: round!.holeArray![indexPath.row].putts))"
        
        cell.fairwayImage.image = round!.holeArray![indexPath.row].fairwayHit ? UIImage(named: "Green_Tick") : UIImage(named: "Red_X")
        cell.GIRImage.image = round!.holeArray![indexPath.row].girHit ? UIImage(named: "Green_Tick") : UIImage(named: "Red_X")
        
        print(cell)
        return cell
    }
    
}
