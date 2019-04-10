//
//  CurrentRunVC.swift
//  Sport
//
//  Created by Amir on 4/5/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class CurrentRunVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var swipeBGImageView: UIImageView!
    @IBOutlet weak var sliderButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderButton.addGestureRecognizer(swipeGesture)
        sliderButton.isUserInteractionEnabled = true
        swipeGesture.delegate = self
    }

    @objc func endRunSwiped(sender: UIPanGestureRecognizer){
        let minAdjust: CGFloat = 62
        let maxAdjust: CGFloat = 110
        if let sliderView = sender.view{
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIPanGestureRecognizer.State.changed{
                let translation = sender.translation(in: self.view)
                if sliderView.center.x >= (swipeBGImageView.center.x - minAdjust) && sliderView.center.x <= (swipeBGImageView.center.x + maxAdjust){
                    sliderView.center.x = sliderView.center.x + translation.x
                }else if sliderView.center.x >= (swipeBGImageView.center.x + maxAdjust){
                    sliderView.center.x = swipeBGImageView.center.x + maxAdjust
                    dismiss(animated: true, completion: nil)
                }else{
                    sliderView.center.x = swipeBGImageView.center.x - minAdjust
                }
                sender.setTranslation(CGPoint.zero, in: self.view)
            }else if sender.state == UIPanGestureRecognizer.State.ended{
                UIView.animate(withDuration: 0.1, animations: {
                    sliderView.center.x = self.swipeBGImageView.center.x - minAdjust
                })
            }
        }
    }
    
}
