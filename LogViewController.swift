//
//  LogViewController.swift
//  Proyectos
//
//  Created by RM on 13/11/17.
//  Copyright © 2017 RM. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SystemConfiguration

class LogViewController: UIViewController {
    @IBOutlet weak var em: UITextField!    
    @IBOutlet weak var pas: UITextField!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var boton1: UIButton!
    override func viewDidLoad() {
        let emailk : String? = UserDefaults.standard.object(forKey: "ema") as? String
        let passk : String? = UserDefaults.standard.object(forKey: "pasi") as? String
        let parameters: Parameters = [
            "email": emailk as String!,
            "password": passk as String!,
            ]
        Alamofire.request("http://192.168.1.38/api/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")
            //response serialization result
            
            if let json = response.result.value { //EXTRAEMOS EL JSON
                print("JSON: \(json)") // serialized json response
                let mensaje = (json as! [String : AnyObject])["message"]
                let resultado = (json as! [String : AnyObject])["result"]
                
                if (resultado?.boolValue)! {
                    self.performSegue(withIdentifier: "InicioSegue", sender: self)
                }else{
                    let alert = UIAlertController(title: "Espera!", message: mensaje as? String, preferredStyle:UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok",style: UIAlertActionStyle.default, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        boton1.layer.cornerRadius = 10
        view1.layer.cornerRadius = 10
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Salir"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cerrar1(_ sender: Any) {
    }
    
    @IBAction func cerrar2(_ sender: Any) {
    }
    @IBAction func Click1(_ sender: Any) {
        self.performSegue(withIdentifier: "RegSegue", sender: self)
    }
    @IBAction func Click2(_ sender: Any) {
        let parameters: Parameters = [
            "email": em.text as String!,
            "password": pas.text as String!,
            ]
        UserDefaults.standard.set(em.text, forKey: "ema")
        UserDefaults.standard.set(pas.text, forKey: "pasi")
        print("ENVIANDO PARAMETROS: \(parameters)")
        if isInternetAvailable() {
            Alamofire.request("http://192.168.1.38/api/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                //print("Request: \(String(describing: response.request))")   // original url request
                //print("Response: \(String(describing: response.response))") // http url response
                //print("Result: \(response.result)")
                //response serialization result
                
                if let json = response.result.value { //EXTRAEMOS EL JSON
                    print("JSON: \(json)") // serialized json response
                    let mensaje = (json as! [String : AnyObject])["message"]
                    let resultado = (json as! [String : AnyObject])["result"]
                    
                    if (resultado?.boolValue)! {
                        self.performSegue(withIdentifier: "InicioSegue", sender: self)
                    }else{
                        let alert = UIAlertController(title: "Espera!", message: mensaje as? String, preferredStyle:UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok",style: UIAlertActionStyle.default, handler:nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        }
       
        }else{
            let alert = UIAlertController(title: "Huy!", message: "Parece que no hay conexion a internet", preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok",style: UIAlertActionStyle.default, handler:nil))
            self.present(alert, animated: true, completion: nil)
        }
        

    }
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
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
