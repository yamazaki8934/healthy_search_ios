//
//  SelectRestaurantViewController.swift
//  healthy_search_ios
//
//  Created by 山崎浩毅 on 2019/10/12.
//  Copyright © 2019 山崎浩毅. All rights reserved.
//

import UIKit
import Koloda

final class SelectRestaurantViewController: UIViewController {
    
    @IBOutlet private weak var restaurantCardView: KolodaView!
    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var restaurantName: UILabel!
    @IBOutlet private weak var restaurantGenre: UILabel!
    @IBOutlet private weak var restaurantAddress: UILabel!
    @IBOutlet private weak var restaurantOverView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantCardView.dataSource = self
        restaurantCardView.delegate = self
    }


}

extension SelectRestaurantViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
}

extension SelectRestaurantViewController: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return images.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: images[index])
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)[0] as? OverlayView
    }
}
