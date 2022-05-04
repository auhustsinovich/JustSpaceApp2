//
//  ViewController.swift
//  JustSpaceApp
//
//  Created by Daniil on 13.04.22.
//

import UIKit

enum Link: String {
    case imageURL = ""
    case dataURL = "https://api.nasa.gov/planetary/apod?api_key=yqGYvoKD3VLJAWM1mvCnIN3jYqFA3w6vcJdYc8uK&count=10"
}

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPictures" {
            guard let resultVC = segue.destination as? ResultsViewController else { return }
            resultVC.fetchData()
        }
    }
    
    //MARK: - PRIVATE METHODS
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
//MARK: - Extensions
extension MainViewController {
    
    private func fetchData() {
        guard let url = URL(string: Link.dataURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let spaces = try JSONDecoder().decode([Picture].self, from: data)
                print(spaces)
            } catch let error {
                self.failedAlert()
                print(error)
            }
        }.resume()
    }
}
