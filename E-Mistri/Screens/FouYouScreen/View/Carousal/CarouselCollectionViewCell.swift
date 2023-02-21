//
//  CarouselCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 13/01/2023.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "CarouselCollectionViewCell"
    let carousalData: [CarousalData] = [
        CarousalData(
            carausalPrimaryText: Text.carouselTitleText,
            carausalSecondaryText: Text.carouselSecondaryText,
            carausalImage: Images.castrolJar
        ),
        CarousalData(
            carausalPrimaryText: Text.carouselTitleText,
            carausalSecondaryText: Text.carouselSecondaryText,
            carausalImage: Images.castrolJar
        ),
        CarousalData(
            carausalPrimaryText: Text.carouselTitleText,
            carausalSecondaryText: Text.carouselSecondaryText,
            carausalImage: Images.castrolJar
        )
    ]
    
    @IBOutlet weak var carouselBody: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carouselBody.showsHorizontalScrollIndicator = false
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        carouselBody.collectionViewLayout = flowLayout
        carouselBody.isPagingEnabled = true
        carouselBody.delegate = self
        carouselBody.dataSource = self
        carouselBody.register(
            UINib(
                nibName: CarouselEffectCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: CarouselEffectCollectionViewCell.identifier
        )
    }
}

extension CarouselCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carousalData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = indexPath.section
        if section == 0 {
            if let carouselCell = carouselBody.dequeueReusableCell(
                withReuseIdentifier: CarouselEffectCollectionViewCell.identifier,
                for: indexPath
            ) as? CarouselEffectCollectionViewCell {
                carouselCell.carouselTitleText.text = carousalData[indexPath.row].carausalPrimaryText
                carouselCell.carouselSecondaryText.text = carousalData[indexPath.row].carausalSecondaryText
                carouselCell.carouselImage.image = UIImage(named: carousalData[indexPath.row].carausalImage)
                return carouselCell
            }
        }
        return UICollectionViewCell()
    }
}

extension CarouselCollectionViewCell: UICollectionViewDelegate {
    
}

extension CarouselCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.bounds.size.width, height: 230)
    }
}
