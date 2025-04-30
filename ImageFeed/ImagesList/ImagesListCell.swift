//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Irina Gubina on 27.04.2025.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    private let gradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientView.bounds
    }
    
    func setupGradient() {
        guard gradientLayer.superlayer == nil else { return }
        let darkColor = UIColor(red: 26/255, green: 27/255, blue: 34/255, alpha: 1.0)
        
        gradientLayer.colors = [
            darkColor.withAlphaComponent(0.6).cgColor,
            darkColor.withAlphaComponent(0.0).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
