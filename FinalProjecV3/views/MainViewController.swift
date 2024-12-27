//
//  MainViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBAction func lista(_ sender: Any) {
        performSegue(withIdentifier: "artistaslista", sender: self)
    }
    
    
    @IBAction func marcador(_ sender: Any) {
        performSegue(withIdentifier: "marcadoreslista", sender: self)
    }
    
    
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
