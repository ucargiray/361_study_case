//
//  PopUpAnimation.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 10.01.2022.
//

import UIKit

@IBDesignable
class PopUpAnimation: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var contentView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        contentView = loadViewFromNib()
        contentView!.frame = bounds
        contentView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView!)
        self.layer.cornerRadius = self.frame.width / 3
        print(self.frame.width / 3)
    }

    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }

}
