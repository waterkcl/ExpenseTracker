//
//  AddExpenseViewController.swift
//  ExpenseTracker2
//
//  Created by ChanKa Long on 27/7/2017.
//  Copyright © 2017 ChanKa Long. All rights reserved.
//

import UIKit
import CoreData

class AddExpenseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UITextViewDelegate {

    var expenseArray:[Key] = []
    @IBOutlet weak var noteTxt: UITextView!
    @IBOutlet weak var moneyTxt: UITextField!
    @IBOutlet weak var expenseDate: UITextField!
    @IBOutlet weak var SelectCollectionView: UICollectionView!
    let datePicker = UIDatePicker()
    
    var  images = ["breakfast", "dinner", "snacks", "grocery", "social", "drinks", "lunch", "traffic", "fun", "clothing"]
    var expenseType: String?
    
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var datePickerTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.SelectCollectionView.delegate = self
        self.SelectCollectionView.dataSource = self
        
        createDatePicker()
        
        noteTxt.delegate = self
        moneyTxt.delegate = self
        expenseDate.delegate = self
        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        if let money = moneyTxt?.text,
            !money.isEmpty,
            let date = expenseDate?.text,
            !date.isEmpty {
            
            let fetchRequest : NSFetchRequest<NSFetchRequestResult>
            
            if #available(iOS 10.0, *) {
                fetchRequest = Expense.fetchRequest()
            } else {
                fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Key")
            }
            
            let predicate = NSPredicate(format: "dateKey=%@", date)
            fetchRequest.predicate = predicate
            
            do {
                let results = try context.fetch(fetchRequest)
                if(results.count != 0){
                    let expense = results.last as! Key
                    let details = Expense(context: context)
                    details.expenseDate = datePicker.date as NSDate
                    details.expenseMoney = Int16(money)!
                    details.expenseType = expenseType
                    details.expense = expense
                    
                    expense.addToExpenseDetails(details)
                    do {
                        try context.save()
                    } catch  {
                        print ("Error \(error)")
                    }
                } else if (results.count == 0) {
                    
                    let expense = NSEntityDescription.insertNewObject(forEntityName: "Key", into: context) as! Key
                    let details = Expense(context: context)
                    
                    details.expenseDate = datePicker.date as NSDate
                    details.expenseMoney = Int16(money)!
                    details.expenseType = expenseType
                    details.expense = expense
                    
                    expense.dateKey = date
                    expense.addToExpenseDetails(details)
                    
                    do {
                        try context.save()
                    } catch  {
                        print ("Error \(error)")
                    }
                }
            } catch {
                print(error)
            }
        } else {
            print("Please fill the Expense money and Date")
        }
    }
    
    func fetchData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let results = try context.fetch(Key.fetchRequest()) as [Key]
            print(results)
        } catch {
            print(error)
        }
    }
    
    func createDatePicker() {
        
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        moneyTxt.inputAccessoryView = toolbar
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! ExpenseCollectionViewCell
        
        cell.selectImageView.image = UIImage(named: images[indexPath.row])
        cell.tag = indexPath.row
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected row is" , indexPath.row)
        expenseType = images[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor(white: 217.0/255.0, alpha: 1.0) // Apple default cell highlight color
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = nil
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

}
