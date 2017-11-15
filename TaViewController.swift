//
//  TaViewController.swift
//  Proyectos
//
//  Created by RM on 14/11/17.
//  Copyright © 2017 RM. All rights reserved.
//

import UIKit
import Alamofire

class TaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var actorsArray = [AnyObject]()
    var myIndexPath = 0
    var URLs = ["","",""]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        let button =  UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 10
        button.setTitle("Cerrar Sesion", for: .normal)
        button.addTarget(self, action: #selector(self.clickOnButton), for: .touchUpInside)
        self.navigationItem.titleView = button
        
        Alamofire.request("http://192.168.1.38/api/lista").responseJSON{ response in
            let result = response.result
            print(response.result.value ?? String())
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["records"]{
                    self.actorsArray = innerDict as! [AnyObject]
                    self.tableView.reloadData()
                }
            }
            
        }
        super.viewDidLoad()
    }
    
    @objc func clickOnButton(button: UIButton) {
        print("BUTTON SELECTED")
        dismiss(animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        
        let title = actorsArray[indexPath.row]["nombre"]
        cell?.textLabel?.text = title as? String
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndexPath = indexPath.row
        performSegue(withIdentifier: "Formulario", sender: myIndexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "Formulario"){
            let DestViewController = segue.destination as! FormularioViewController
            let index = sender as! Int
            let title = actorsArray[index]["nombre"] as! String
            let id = actorsArray[index]["id"] as! Int
            DestViewController.idProyecto = id
            DestViewController.LabelText = title
        }
        
    
    }

}
