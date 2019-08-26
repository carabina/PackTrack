//
//  PackageController.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-14.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class PackageController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var package: Package? {
        didSet {
            packageNameLabel.text = package?.name
            trackingNumLabel.text = package?.trackingNumber
        }
    }
    
    let packageNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trackingNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Tracking number"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trackingNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customWhite
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let whiteCard: UIView = {
        let view = UIView(frame: CGRect())
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack(tapGestureRecognizer:))))
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftArrowImageView: UIImageView = {
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)
            let symbolImage = UIImage(systemName: "arrow.left", withConfiguration: config)
            let imageView = UIImageView(image: symbolImage)
            imageView.tintColor = .white
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack(tapGestureRecognizer:))))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        } else {
            return UIImageView()
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        setupBackImageView()
        setupPackageNameLabel()
        setupTrackingNumberLabel()
        setupWhiteCard()
        view.backgroundColor = .darkBlue
    }
    
    private func setupBackImageView() {
        view.addSubview(leftArrowImageView)
        leftArrowImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        leftArrowImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    }
    
    private func setupPackageNameLabel() {
        view.addSubview(packageNameLabel)
        packageNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        packageNameLabel.topAnchor.constraint(equalTo: leftArrowImageView.topAnchor).isActive = true
    }
    
    private func setupTrackingNumberLabel() {
        let stackView = UIStackView(arrangedSubviews: [
            trackingNumberLabel,
            trackingNumLabel
        ])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: leftArrowImageView.bottomAnchor, constant: 20).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftArrowImageView.leftAnchor).isActive = true
    }
    
    private func setupWhiteCard() {
        view.addSubview(whiteCard)
        whiteCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.93).isActive = true
        whiteCard.heightAnchor.constraint(equalToConstant: 600).isActive = true
        whiteCard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc func handleBack(tapGestureRecognizer: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}
