//
//  RegViewController.swift
//  Proyectos
//
//  Created by RM on 13/11/17.
//  Copyright © 2017 RM. All rights reserved.
//

import UIKit
import Alamofire

class RegViewController: UIViewController {

    @IBOutlet weak var pas1: UITextField!
    @IBOutlet weak var em: UITextField!
    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var boton1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        boton1.layer.cornerRadius = 10
        view1.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Click(_ sender: Any) {
        let parameters: Parameters = [
            "email": em.text as String!,
            "name": nom.text as String!,
            "password": pas1.text as String!,
            ]
        if  em.text=="" || nom.text=="" || pas1.text=="" || nom.text==""{
            let alert = UIAlertController(title: "Error", message: "Debe llenar todos los campos", preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok",style: UIAlertActionStyle.default, handler:nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            Alamofire.request("http://192.168.1.38/api/registro", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                //print("Request: \(String(describing: response.request))")   // original url request
                //print("Response: \(String(describing: response.response))") // http url response
                //print("Result: \(response.result)")
                //response serialization result
                
                if let json = response.result.value { //EXTRAEMOS EL JSON
                    print("JSON: \(json)") // serialized json response
                    let mensaje = (json as! [String : AnyObject])["message"] as! String
                    let resultado = (json as! [String : AnyObject])["result"]
                    if (resultado?.boolValue)! {
                        let alert = UIAlertController(title: "Genial!", message: mensaje, preferredStyle:UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok",style: UIAlertActionStyle.default, handler:nil))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle:UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok",style: UIAlertActionStyle.default, handler:nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
            }
        }

        
    }
    
    @IBAction func cerrar1(_ sender: Any) {
    }
    @IBAction func cerrar2(_ sender: Any) {
    }
    @IBAction func cerrar3(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
