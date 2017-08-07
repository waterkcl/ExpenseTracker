//
//  DetailViewController.swift
//  ExpenseTracker2
//
//  Created by ChanKa Long on 1/8/2017.
//  Copyright © 2017 ChanKa Long. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    
    var details: Expense?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        amountText.delegate = self
        typeText.delegate = self
        dateText.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        amountText.placeholder = details?.expenseMoney.description
        typeText.placeholder = details?.expenseType?.description
        dateText.placeholder = details?.expenseDate?.description
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        let predicate = NSPredicate(format: "expenseDate=%@", (details?.expenseDate)!)
        fetchRequest.predicate = predicate
        do{
            let results = try context.fetch(fetchRequest)
            if(results.count != 0){
                let details = results.last as! Expense
                details.expenseMoney = Int16(amountText.text!)!
            }
            do {
                try context.save()
                self.navigationController?.popToRootViewController(animated: true)
            } catch  {
                print ("Error \(error)")
            }
        } catch {
            
        }
        
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        let predicate = NSPredicate(format: "expenseDate=%@", (details?.expenseDate)!)
        fetchRequest.predicate = predicate
        do{
            let results = try context.fetch(fetchRequest)
            if(results.count != 0){
                let details = results.last as! Expense
                context.delete(details)
            }
            do {
                try context.save()
                self.navigationController?.popToRootViewController(animated: true)
            } catch  {
                print ("Error \(error)")
            }
        } catch {
            
        }
        

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }

}
