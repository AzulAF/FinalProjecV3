//
//  SplashViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 10/01/25.
//

import UIKit

import UIKit
import Lottie

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let animationView = LottieAnimationView(name: "eventanim")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.5
        
        view.addSubview(animationView)
        
        animationView.play { [weak self] (finished) in
            if finished {
                self?.transitionToMainApp()
                
            }
        }
    }
    
    private func transitionToMainApp() {
        //performSegue(withIdentifier: "seguetomain", sender: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        if let window = view.window {
            window.rootViewController = mainVC
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
