//
//  ColorPickerViewController.swift
//  forfun
//
//  Created by WEN-HSUAN TUNG on 2021/7/22.
//

import UIKit

class ColorPickerViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!

        override func updateViewConstraints() {
            // distance to top introduced in iOS 13 for modal controllers
            // they're now "cards"
            let TOP_CARD_DISTANCE: CGFloat = 40.0

            // calculate height of everything inside that stackview
            var height: CGFloat = 0.0
            for v in self.stackView.subviews {
                height = height + v.frame.size.height
            }

            // change size of Viewcontroller's view to that height
            self.view.frame.size.height = height
            // reposition the view (if not it will be near the top)
            self.view.frame.origin.y = UIScreen.main.bounds.height - height - TOP_CARD_DISTANCE
            // apply corner radius only to top corners
            self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
            super.updateViewConstraints()
        }

}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
