//
//  ResultsViewController.swift
//  JustSpaceApp
//
//  Created by Daniil on 18.04.22.
//

import UIKit

class ResultsViewController: UITableViewController {

    private var pictures: [Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spaceCell", for: indexPath) as! SpaceCell
        let picture = pictures[indexPath.row]
        cell.configure(with: picture)

        return cell
    }
}

//MARK: - NETWORKING
extension ResultsViewController {

    
    func fetchData() {
        guard let url = URL(string: Link.dataURL.rawValue) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                self.pictures = try JSONDecoder().decode([Picture].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
