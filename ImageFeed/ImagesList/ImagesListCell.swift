//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Irina Gubina on 27.04.2025.
//

import UIKit

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}

final class ImagesListCell: UITableViewCell {
    weak var delegate: ImagesListCellDelegate?
    
    // MARK: - Constants
    static let reuseIdentifier = "ImagesListCell"
    
    // MARK: - IB Outlets
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    // MARK: - Private Properties
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
            cellImageView.kf.cancelDownloadTask()
            cellImageView.image = nil
           // fullsizeImageView.kf.cancelDownloadTask()
        }
    
    @IBAction private func likeButtonClicked(_ sender: UIButton) {
        delegate?.imageListCellDidTapLike(self)
    }
    
    // MARK: - Public Methods
    func configure(with photo: Photo) {
            cellImageView.kf.setImage(
                with: URL(string: photo.thumbImageURL),
                placeholder: UIImage(named: "image_placeholder")
            )
        if let date = photo.createdAt {
                let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM yyyy"
                formatter.locale = Locale(identifier: "ru_RU")
                dateLabel.text = formatter.string(from: date)
            } else {
                dateLabel.text = ""
            }
            setLikeButtonImage(isLiked: photo.isLiked)
            setupGradient()
        }
        
        func setLikeButtonImage(isLiked: Bool) {
            let imageName = isLiked ? "like_on" : "like_off"
            likeButton.setImage(UIImage(named: imageName), for: .normal)
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
