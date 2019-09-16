//
//  ViewController.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-10.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class PackagesController: UICollectionViewController, PackagesViewModelDelegate {
    var viewModel: PackagesViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    let blueBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let activePackagesNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .customGreen
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deliveredPackagesNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textColor = .customLightGray
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activePackagesLabel: UILabel = {
        let label = UILabel()
        label.text = "Active parcels"
        label.textColor = .customGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deliveredPackagesLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivered parcels"
        label.textColor = .customLightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel = PackagesViewModel()
        viewModel?.delegate = self 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .customWhite
        setupBlueBackgroundView()
        setupCountLabels()
        setupCollectionView()
        setupAddButton()
    }
    
    private func setupBlueBackgroundView() {
        view.addSubview(blueBackgroundView)
        blueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        blueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        blueBackgroundView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100).isActive = true
    }
    
    private func setupCountLabels() {
        let activePackagesStackView = UIStackView(arrangedSubviews: [
            activePackagesNumberLabel,
            activePackagesLabel
        ])
        activePackagesStackView.axis = .vertical
        
        let deliveredPackagesStackView = UIStackView(arrangedSubviews: [
            deliveredPackagesNumberLabel,
            deliveredPackagesLabel
        ])
        deliveredPackagesStackView.axis = .vertical
        
        let horizontalStackView = UIStackView(arrangedSubviews: [
            activePackagesStackView,
            deliveredPackagesStackView
        ])
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.spacing = 35
        
        view.addSubview(horizontalStackView)
        horizontalStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
    }
    
    private func setupCollectionView() {
        view.bringSubviewToFront(collectionView)
        collectionView.backgroundColor = .clear
        
        collectionView.register(PackageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.94).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func handleAdd() {
        viewModel?.addPackage(name: "Chair", trackingNumber: "123456789")
        collectionView.reloadData()
    }
    
    private func setupAddButton() {
        let addPackageButton = AddPackageButton()
        addPackageButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        
        view.addSubview(addPackageButton)
        addPackageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPackageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
    }
    
    func didUpdatePackages() {
        collectionView.reloadData()
    }
}

