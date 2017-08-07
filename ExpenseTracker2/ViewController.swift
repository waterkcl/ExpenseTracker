//
//  ViewController.swift
//  ExpenseTracker2
//
//  Created by ChanKa Long on 26/7/2017.
//  Copyright © 2017 ChanKa Long. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var currentIndex : Int = 0
    var totalIndex : Int = 0
    
    var totalAmount: Int = 0
    
    @IBOutlet weak var totalMoney: UILabel!
    var detailView: DetailViewController?
    
    var detailsArray:[Expense] = []
    var expenseArray:[String] = []
    var expenseDict = [String:Set<Expense>]()
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        totalAmount = 0
        //print(expenseArray)
        currentIndex=0
        totalIndex=0
        fetchExpenseData()
        getTotal()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ExpenseCell", owner: self, options: nil)?.first as! ExpenseCell
        cell.itemName.text = detailsArray[indexPath.row].expenseType
        cell.itemPrice.text = "HKD $" + String(describing: detailsArray[indexPath.row].expenseMoney)
        //cell.itemImage.image = UIImage.init(named: detailsArray[indexPath.row].expenseType! + "a")
        if let imageNamed = detailsArray[indexPath.row].expenseType {
            cell.itemImage.image = UIImage(named:imageNamed + "a")
        }
        
//        print(detailsArray[indexPath.row].expenseType! + "a")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "detailView", sender: nil)
        if(detailView == nil) {
            detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        }
        self.detailView?.details = self.detailsArray[indexPath.row]
        self.navigationController?.pushViewController(detailView!, animated: true)
    }
    
    func fetchExpenseData(){
        expenseArray.removeAll()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
           let expenses =  try context.fetch(Key.fetchRequest()) as [Key]
            for expense in expenses {
                if expense.dateKey == nil {
                    print("nil")
                }else{
                expenseDict[(expense.dateKey)!] = expense.expenseDetails
                expenseArray.append(expense.dateKey!)
                totalIndex = expenseArray.count

                }
            }
                    } catch {
            print(error)
        }
        fetchDetailsData()
    }
    
    func fetchDetailsData(){
        detailsArray.removeAll()
        print(expenseDict)
        if expenseArray.count == 0 {
            return
        }
        for details in expenseDict[expenseArray[currentIndex]]! {
            detailsArray.append(details)
        }
        self.title = expenseArray[currentIndex]
        self.tableView.reloadData()
    }
    
    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if expenseArray.count>0{
            if gesture.direction == UISwipeGestureRecognizerDirection.right {
                print("Swipe Right")
                if currentIndex>0 {
                    currentIndex -= 1
                    fetchExpenseData()
                    getTotal()
                }
            } else if gesture.direction == UISwipeGestureRecognizerDirection.left {
                print("Swipe Left")
                if currentIndex<totalIndex-1 {
                    currentIndex += 1
                    fetchExpenseData()
                    getTotal()
                }
            }
        }
    }
    
    func getTotal(){
        totalAmount=0
        for details in detailsArray {
            totalAmount=totalAmount+Int(details.expenseMoney)
        }
        totalMoney.text = String(totalAmount)
    }
}

