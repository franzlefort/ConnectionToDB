//
//  HomeModel.swift
//  ConnectionToDB
//
//  Created by Avefranz on 12/06/2019.
//  Copyright © 2019 Avefranz. All rights reserved.
//

import UIKit

protocol HomeModelDelegate {
    
    func itemsDownloaded(customers:[Customer])
}

class HomeModel : NSObject{
    
    var delegate : HomeModelDelegate?
    
    func getItems(){
        
        let serviceUrl = "http://cd94977-wordpress-7.tw1.ru/service.php";
        
        let url = URL(string: serviceUrl);
        
        if let notNullUrl = url {
            
            let session = URLSession(configuration: .default);
            
            let task = session.dataTask(with: notNullUrl) { (data, responce, error) in
                if error == nil {
                    //Suckseed
                    self.parseJson(data!);
                }
                else {
                    //Error
                }
            }
            
            // Запускаем задачу
            task.resume();
        }
    }
    
    func parseJson(_ data : Data){
        
        var customerArray = [Customer]();
        
        do {
            
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray {
                
                let jsonDict = jsonResult as! [String : String];
                
                let customer = Customer(name: jsonDict["Name"]!, age: jsonDict["Age"]!, height: jsonDict["Height"]!, weight: jsonDict["Weight"]!);
                
                customerArray.append(customer);
            }
            
            delegate?.itemsDownloaded(customers: customerArray)
        }
        catch {
            print("That was an error");
        }
    }
}
