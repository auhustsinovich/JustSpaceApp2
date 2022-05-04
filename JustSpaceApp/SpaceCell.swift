//
//  CourseCell.swift
//  JustSpaceApp
//
//  Created by Daniil on 18.04.22.
//

import UIKit

class SpaceCell: UITableViewCell {
    
    @IBOutlet var pictureView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
        
    func configure(with picture: Picture) {
        titleLabel.text = picture.title
        dateLabel.text = picture.date
        authorLabel.text = picture.copyright
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        guard let url = URL(string: picture.url ?? "") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            DispatchQueue.main.async {
                self.pictureView.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            }
            
        }.resume()
    }
}
