//
//  priorRoundsViewController.swift
//  golfApp
//
//Name/Author: John Brechon


import UIKit
import CoreData

class priorRoundsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var roundArray:[GolfRound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = 90
        self.fetchData()
        self.tableView.reloadData()
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roundArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! RoundTableViewCell
        
        let round = roundArray[indexPath.row]
        
        var toPar = " "
        if(round.scoreToPar == 0)
        {
            toPar = "E"
        }
        else if(round.scoreToPar > 0)
        {
            toPar = "+" + "\(round.scoreToPar)"
        }
        else
        {
            toPar = "\(round.scoreToPar)"
        }
        
        cell.cellCourseName.text = round.courseName
        cell.cellDate.text = (round.date)?.asString(style: .short)
        cell.cellToPar.text = toPar
        cell.cellStrokes.text = "\(round.totalScore)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            
            let round = roundArray[indexPath.row]
            context.delete(round)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
            do {
                roundArray = try context.fetch(GolfRound.fetchRequest())
            }
            catch{
                print(error)
            }
            
        }
        
        tableView.reloadData()
        
        
        
        
    }
    
    func fetchData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            roundArray = try context.fetch(GolfRound.fetchRequest())
        }
        catch {
            print(error)
        }
        
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "roundDetail"){
            let destVC = segue.destination as! RoundDetailViewController
            destVC.round = roundArray[(self.tableView.indexPathForSelectedRow?.row)!]
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
