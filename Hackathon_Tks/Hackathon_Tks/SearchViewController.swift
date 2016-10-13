//
//  SearchViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()

    }
    
    func initViewController() {
        customizeSearchTextField()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customizeSearchTextField() {
        searchTextField.leftViewMode = .UnlessEditing
        let leftImageView = UIImageView(frame: CGRectMake(4, 0, 26, 18))
        leftImageView.contentMode = .ScaleAspectFit
        leftImageView.image = UIImage(named: "searchIcon")
        searchTextField.leftView = leftImageView
        
        let cancelButton = UIButton(frame: CGRectMake(0, 0, 50, 30))
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        cancelButton.setTitleColor(UIColor.init(rgba: "#5FB760"), forState: .Normal)
        cancelButton.addTarget(self, action: #selector(SearchViewController.clearSearchTextField), forControlEvents: UIControlEvents.TouchUpInside)
        searchTextField.rightView = cancelButton
        searchTextField.rightViewMode = .WhileEditing
    }
    
    func clearSearchTextField() {
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        //tbl.hidden = true
    }
    func textFieldDidChange(textField: UITextField) {
        NSLog("abc")
//        APIManager.shareInstance.searchMSNStockWithKeyword(textField.text!).continueWithExecutor(BFExecutor.mainThreadExecutor(), withBlock: { [weak self](task) -> AnyObject? in
//            guard let result = task.result as? [StockModel], let wSelf = self else {
//                self!.listStock.removeAll()
//                self!.tbl.reloadData()
//                return nil
//            }
//            self!.listStock.removeAll()
//            for i in 0 ..< result.count {
//                self!.listStock.append(result[i])
//            }
//            
//            self!.tbl.reloadData()
//            //wSelf.tableView.reloadData()
//            return nil
//            })
    }

}
extension SearchViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
//        contentView.bringSubviewToFront(tbl)
//        tbl?.hidden = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        
//        if textField.isEqual(searchTextField) {
//            searchTextField.text = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string.uppercaseString)
//            self.textFieldDidChange(self.searchTextField)
//            return false
//        }
//        self.textFieldDidChange(self.searchTextField)
        return true
    }
    
}

