//
//  ViewController.swift
//  Faces
//
//  Created by Kelly II, Richard W. on 9/1/16.
//  Copyright © 2016 Kelly II, Richard W. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    var trayOriginalCenter : CGPoint!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!

    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceORiginalCenter: CGPoint!
    
    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
        
    }
    
    func panCreatedFace(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceORiginalCenter = newlyCreatedFace.center
        }  else if sender.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceORiginalCenter.x + translation.x, y: newlyCreatedFaceORiginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.Ended {
            
        }
        
    }
    
    @IBAction func didPanFace(sender: UIPanGestureRecognizer) {

        let translation = sender.translationInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y  += trayView.frame.origin.y
            newlyCreatedFaceORiginalCenter = newlyCreatedFace.center
            newlyCreatedFace.transform = CGAffineTransformMakeScale(2, 2)
        }  else if sender.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceORiginalCenter.x + translation.x, y: newlyCreatedFaceORiginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.Ended {
            newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)
            newlyCreatedFace.userInteractionEnabled = true
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panCreatedFace:")
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            panGestureRecognizer.delegate = self
            

        }
    }
    @IBAction func didPanTray(sender: UIPanGestureRecognizer) {
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        let location = sender.locationInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
        }  else if sender.state == UIGestureRecognizerState.Changed {
            if location.y < 400 {
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y / 10)
            } else {
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            }
        } else if sender.state == UIGestureRecognizerState.Ended {
            trayView.center = trayOriginalCenter
            if velocity.y > 0 {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { 
                        self.trayView.center = self.trayDown
                    }, completion: { (Bool) in
                })
            } else {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = self.trayUp
                    }, completion: { (Bool) in
                })
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

