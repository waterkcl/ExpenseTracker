//
//  AddIncomeViewController.swift
//  ExpenseTracker2
//
//  Created by ChanKa Long on 6/8/2017.
//  Copyright © 2017 ChanKa Long. All rights reserved.
//

import UIKit
import CoreData

class AddIncomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var incomeDate: UITextField!
    @IBOutlet weak var datePickerTxt: UITextField!
    @IBOutlet weak var moneyTxt: UITextField!
    @IBOutlet weak var noteTxt: UITextView!
    @IBOutlet weak var SelectCollectionView: UICollectionView!
    
    var  images = ["salary", "bonus", "allowance", "investment", "other"]
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.SelectCollectionView.delegate = self
        self.SelectCollectionView.dataSource = self
        createDatePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveBtn(_ sender: Any) {
//        if let money = moneyTxt?.text,
//            !money.isEmpty,
//            let date = incomeDate?.text,
//            !date.isEmpty {
//            
//            let fetchRequest : NSFetchRequest<NSFetchRequestResult>
//            
//            if #available(iOS 10.0, *) {
//                fetchRequest = Expense.fetchRequest()
//            } else {
//                fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
//            }
//            
//            let predicate = NSPredicate(format: "dateKey=%@", date)
//            fetchRequest.predicate = predicate
//            
//            do {
//                let results = try context.fetch(fetchRequest)
//                if(results.count != 0){
//                    let expense = results.last as! Expense
//                    let details = Details(context: context)
//                    details.expenseDate = datePicker.date as NSDate
//                    details.expenseMoney = Int16(money)!
//                    details.expenseType = expenseType
//                    details.expense = expense
//                    
//                    expense.addToDetails(details)
//                    do {
//                        try context.save()
//                    } catch  {
//                        print ("Error \(error)")
//                    }
//                } else if (results.count == 0) {
//                    
//                    let expense = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: context) as! Expense
//                    let details = Details(context: context)
//                    
//                    details.expenseDate = datePicker.date as NSDate
//                    details.expenseMoney = Int16(money)!
//                    details.expenseType = expenseType
//                    details.expense = expense
//                    
//                    expense.dateKey = date
//                    expense.addToDetails(details)
//                    
//                    do {
//                        try context.save()
//                    } catch  {
//                        print ("Error \(error)")
//                    }
//                }
//            } catch {
//                print(error)
//            }
//        } else {
//            print("Please fill the Expense money and Date")
//        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! IncomeCollectionViewCell
        
        cell.selectImageView.image = UIImage(named: images[indexPath.row])
        cell.tag = indexPath.row
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected row is" , indexPath.row)
//        expenseType = images[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor(white: 217.0/255.0, alpha: 1.0) // Apple default cell highlight color
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = nil
        }
    }
    
    func createDatePicker() {
        
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        datePickerTxt.inputAccessoryView = toolbar
        datePickerTxt.inputView = datePicker
        
    }
    
    func donePressed(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        datePickerTxt.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }


}
