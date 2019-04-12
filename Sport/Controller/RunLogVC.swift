//
//  RunLogVC.swift
//  Sport
//
//  Created by Amir on 4/5/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class RunLogVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as? RunLogCell{
            guard let run = Run.getAllRuns()?[indexPath.row] else { return RunLogCell()}
            cell.configure(run: run)
            return cell
        }else{
            return RunLogCell()
        }
    }

}
