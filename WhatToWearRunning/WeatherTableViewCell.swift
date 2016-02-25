//
//  WeatherTableViewCell.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 2/18/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.registerNib(UINib(nibName: "WeatherCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
    }

}

extension WeatherTableViewCell {

    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set {
            collectionView.contentOffset.x = newValue
        }

        get {
            return collectionView.contentOffset.x
        }
    }
}