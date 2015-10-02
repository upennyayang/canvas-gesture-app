//
//  CanvasViewController.swift
//  canvas-gesture-app
//
//  Created by Yayang Tian on 10/1/15.
//  Copyright © 2015 walmartlabs. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    var trayOriginalCenter: CGPoint!
    
    var trayOpenPoint: CGPoint!
    var trayClosePoint: CGPoint!

    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(trayView.bounds)
        
        trayOpenPoint = trayView.center
        
        trayClosePoint = CGPoint(x: trayView.center.x, y: 750)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        trayView.addGestureRecognizer(panGestureRecognizer)
    
    }
    
    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(trayView.superview)
        let velocity = panGestureRecognizer.velocityInView(trayView.superview)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            trayOriginalCenter = trayView.center
       
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            trayView.center = CGPoint(
                x: trayOriginalCenter.x,
                y: point.y
            )
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            
            let bounds = self.trayView.bounds
            
                      // moving down
            if(velocity.y > 0) {
                trayView.center = trayClosePoint
                
                UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: {
                    self.view.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
                    //                self.view.enabled = false
                    }, completion: nil)
            }
            if (velocity.y < 0){
                trayView.center = trayOpenPoint
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
