//
//  HabitAdderController.swift
//  Habbit
//
//  Created by Brandon David on 4/18/18.
//  Copyright © 2018 IrisBrandon. All rights reserved.
//

import Foundation
import UIKit
import BouncyLayout

class HabitAdderController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    
    @IBOutlet weak var addHeader: UIView!
    @IBOutlet weak var addHeaderText: UILabel!
    
    @IBOutlet weak var habitName: UITextField!
    
    var iconsArray: [UIImage] = [#imageLiteral(resourceName: "icon_dog"), #imageLiteral(resourceName: "icon-read"), #imageLiteral(resourceName: "icon-yoga"), #imageLiteral(resourceName: "icon-sleep"), #imageLiteral(resourceName: "icon-health"), #imageLiteral(resourceName: "icon-call-parents"), #imageLiteral(resourceName: "icon_drink"), #imageLiteral(resourceName: "icon_eat"), #imageLiteral(resourceName: "icon_shop"), #imageLiteral(resourceName: "icon_run")]
    var selectedIcon: UIImage? = nil
    var currentCell: IconImageCell? = nil
    var habitNames: [String?] = []
    
    @IBOutlet weak var iconCollectionView: UICollectionView!
    let layout = BouncyLayout()
    
    @IBOutlet weak var iconCVShadow: UIView!
    @IBOutlet weak var buttonText: UIButton!
    
    @IBAction func adderButton(_ sender: Any) {
        if habitName.text == "" || (habitName.text?.trimmingCharacters(in: .whitespaces).isEmpty)!  {
            let alertController = UIAlertController(title: "Invalid Habit Name", message: "Please choose a valid habit name.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        } else if habitName.text![habitName.text!.index(habitName.text!.startIndex, offsetBy: 0)] == " " {
                let alertController = UIAlertController(title: "Invalid Habit Name", message: "Please choose a valid habit name.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
        } else if selectedIcon == nil {
            let alertController = UIAlertController(title: "Missing a Habit Icon", message: "Please select a habit icon.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
//        } else if habitNames.contains(habitName.text) {
//            let alertController = UIAlertController(title: "Habit Already Exists", message: "You already have a habit with this name. Please choose a different name.", preferredStyle: .alert)
//            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//            present(alertController, animated: true, completion: nil)
        } else {
            addHabit(habitName: habitName.text!, habitIcon: selectedIcon!)
            let alertController = UIAlertController(title: "Started a new habit!", message: "You have successfully created a new habit.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in
                self.performSegue(withIdentifier: "unwindSegueToHabitVC", sender: self)
            })
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let habitVC = segue.destination as? HabitViewController {
            habitVC.arrayChanged = true
            updateGrid = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 255.0/255.0, green: 240.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        iconCollectionView.delegate = self
        iconCollectionView.dataSource = self
        layout.scrollDirection = .horizontal
        iconCollectionView.collectionViewLayout = layout
        iconCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        iconCollectionView.layer.cornerRadius = 10
        
        iconCVShadow.layer.cornerRadius = 10
        iconCVShadow.layer.shadowColor = UIColor.black.cgColor
        iconCVShadow.layer.shadowOpacity = 0.2
        iconCVShadow.layer.shadowOffset = CGSize.init(width: 1.5, height: 1.5)
        iconCVShadow.layer.shadowRadius = 2
        iconCVShadow.layer.shouldRasterize = true
        
        iconCollectionView.reloadData()
        
        habitName.layer.shadowColor = UIColor.black.cgColor
        habitName.layer.shadowOpacity = 0.2
        habitName.layer.shadowOffset = CGSize.init(width: 1.5, height: 1.5)
        habitName.layer.shadowRadius = 1.5
        habitName.layer.shouldRasterize = true
        
        buttonText.layer.cornerRadius = 20
        buttonText.layer.shadowColor = UIColor.black.cgColor
        buttonText.layer.shadowOpacity = 0.2
        buttonText.layer.shadowOffset = CGSize.init(width: 1.5, height: 1.5)
        buttonText.layer.shadowRadius = 2
        buttonText.layer.shouldRasterize = true
        
        addHeaderText.text = "Create a name and select an icon for your new habit."
        addHeader.layer.shadowColor = UIColor.black.cgColor
        addHeader.layer.shadowOpacity = 0.3
        addHeader.layer.shadowOffset = CGSize.zero
        addHeader.layer.shadowRadius = 7
        addHeader.layer.shouldRasterize = true
    }
    
    // Hide keyboard when user touches outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as? IconImageCell {
            cell.iconImage.image = iconsArray[indexPath.item]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    let borderColor = UIColor.init(red: 140/255, green: 222/255, blue: 130/255, alpha: 1.0)
    let backgroundColor = UIColor.init(red: 0.7843, green: 1.0, blue: 0.7843, alpha: 0.25)
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentCell != nil {
            currentCell!.backgroundColor = UIColor.clear
            currentCell!.layer.borderColor = UIColor.clear.cgColor
        }
        currentCell = iconCollectionView.cellForItem(at: indexPath) as? IconImageCell
        currentCell?.backgroundColor = backgroundColor
        currentCell?.layer.borderWidth = 2.0
        currentCell?.layer.borderColor = borderColor.cgColor
        selectedIcon = currentCell?.iconImage.image
        
    }
    
}

