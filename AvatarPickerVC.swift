//
//  AvatarPickerVC.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 30/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - Outlets

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCollectionViewCell", for: indexPath) as? AvatarCollectionViewCell else { return UICollectionViewCell() }

        return cell
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 20
    }

    @IBAction func backButtonPressed(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func segmentControlChanged(_: UISegmentedControl) {}
}
