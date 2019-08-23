//
//  AvatarPickerViewController.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 30/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

/// * 아바타 이미지 선택 뷰 컨트롤러
class AvatarPickerViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var segmentControl: UISegmentedControl!

    // MARK: - Property

    var avatarType = AvatarType.dark

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - IBAction

    @IBAction func backButtonPressed(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func segmentControlChanged(_: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else {
            avatarType = .light
        }
        collectionView.reloadData()
    }
}

extension AvatarPickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: avatarCollectionCell, for: indexPath) as? AvatarCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(index: indexPath.item, type: avatarType)
        return cell
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 20
    }
}

extension AvatarPickerViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        dismiss(animated: true, completion: nil)
    }
}

extension AvatarPickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        var numberOfColumns: CGFloat = 3 // 열의 갯 수 3
        if UIScreen.main.bounds.width > 320 { // 스크린 사이즈가 320을 초과하면,
            numberOfColumns = 4 // 열의 갯수를 4로 설정한다.
        }

        let spaceBetweenCells: CGFloat = 10 // 셀 간의 간격은 10으로 설정한다.
        let pedding: CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - pedding) - (numberOfColumns - 1) * spaceBetweenCells) / numberOfColumns // 아이템 크기를 설정한다.
        return CGSize(width: cellDimension, height: cellDimension)
    }
}
