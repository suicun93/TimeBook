//
//  FirstViewController.swift
//  TimeBook
//
//  Created by Hoang Duc on 7/26/19.
//  Copyright © 2019 Hoang Duc. All rights reserved.
//

import UIKit

class DailyView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var listMeditationByHour:[String] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listMeditationByHour = Config.loadListMeditationByHour()
        Config.didNotFirst()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DailyView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "dailyCell") as! TableViewCell
        cell.timeLbl.text = Hour.allValues[indexPath.row].rawValue
        cell.chamNgonLbl.text = listMeditationByHour[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Select your meditation at \(Hour.allValues[indexPath.row].rawValue)",
            message: "It's recommended you keep in mind your meditation.",
            preferredStyle: .actionSheet)
        
        for n in ChamNgon.allValues {
            alert.addAction(UIAlertAction(title: n.rawValue, style: .default, handler: {action in
                self.listMeditationByHour[indexPath.row] = n.rawValue
                Config.saveListMeditation(listChinh: self.listMeditationByHour)
                self.tableView.reloadRows(at: [indexPath], with: .top)
                }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}



