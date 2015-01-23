//
//  ViewController.swift
//  PhonagotchiSwift
//
//  Created by Michael Reining on 1/22/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var bananaImageView2: UIImageView!
    @IBOutlet weak var monkeyImageView: UIImageView!
    @IBOutlet weak var bananaImageView: UIImageView!
    
    var lastPosition:CGPoint?
    var pinchRecognized: Bool = false
    var monkey: Pet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monkey = Pet()
        bananaImageView2.alpha = 0.0
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleBananaPan(recognizer:UIPanGestureRecognizer) {
        //move banana with finger 1. Get new location 2. Update view to new location 3. Reset to zero for new move
        let newLocation = recognizer.translationInView(self.view) //1.
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + newLocation.x, //2.
            y:recognizer.view!.center.y + newLocation.y)
        recognizer.setTranslation(CGPointZero, inView: self.view) //3.
    }

    
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        
        //move monkey with finger 1. Get new location 2. Update view to new location 3. Reset to zero for new move
        let newLocation = recognizer.translationInView(self.view) //1.
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + newLocation.x, //2.
            y:recognizer.view!.center.y + newLocation.y)
        recognizer.setTranslation(CGPointZero, inView: self.view) //3.
        
        //detect velocity
        var xVelocity = recognizer.velocityInView(self.view).x
        var yVelocity = recognizer.velocityInView(self.view).y
        var totalVelocity = sqrt(xVelocity * xVelocity + yVelocity * yVelocity)
        
        //if monkey if monkey is moved to much, it gets sad.  If it is sad...
        monkey!.petMonkey(totalVelocity)
        if monkey!.mood == .Sad {
            //change image, disable recognizer, show alert, reenable recognizer.
            monkeyImageView.image = UIImage(named: "monkeyUpset")
            recognizer.enabled = false
            
            let message = "Please stop petting me!"
            let alert = UIAlertController(title: "Not so fast!", message: message, preferredStyle: .Alert)
            let action = UIAlertAction(title: "Sorry!", style: .Default, handler: { (action:UIAlertAction!) -> Void in
                self.monkeyImageView.image = UIImage(named: "monkey")
                recognizer.enabled = true
            })
            alert.addAction(action)
            self.presentViewController(alert, animated: true,
                completion: {
                    println("presentViewController(alert, animated: true, completion")
            })
        } else {
            //make it happy again
        }
    }
    
    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
        println("pinch recognized")
        animateSecondBananaAppears()
        
        pinchRecognized = true
        if recognizer.state == .Ended {
            println("pinch has ended")
            pinchRecognized = false
        }
    }
    
//    @IBAction func handleBananaPan(recognizer: UIGestureRecognizer) {
////        if pinchRecognized == true {
//            //move banana with finger 1. Get new location 2. Update view to new location 3. Reset to zero for new move
//            let newLocation = recognizer.translationInView(self.view) //1.
//            recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + newLocation.x, //2.
//                y:recognizer.view!.center.y + newLocation.y)
//            recognizer.setTranslation(CGPointZero, inView: self.view) //3.
//        }
//    }
    
    
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        println("touch has ended")
    }
    
    func gestureRecognizer(UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
            return true
    }
    
    //MARK: Animation Blocks
    
    func animateSecondBananaAppears() {
        UIView.animateWithDuration(0.2,
            delay: 0.4,
            options: .CurveEaseInOut,
            animations: {
                self.bananaImageView2.alpha = 1.0
            },
            completion: { finished in
                println("Second Banana is here!")
                
        })
    
    }
}