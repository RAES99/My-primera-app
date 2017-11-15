//
//  FormularioViewController.swift
//  Proyectos
//66
//  Created by RM on 14/11/17.
//  Copyright © 2017 RM. All rights reserved.
//

import UIKit
import Alamofire

class FormularioViewController: UIViewController {

    @IBOutlet var boton1: UIButton!
    @IBOutlet var titulo: UILabel!
    @IBOutlet var pro: UILabel!
    @IBOutlet var desc: UITextView!
    @IBOutlet var hor: UITextField!
    var LabelText = String()
    var idProyecto = Int()
    override func viewDidLoad() {
        desc.layer.cornerRadius = 10
        boton1.layer.cornerRadius = 10
        titulo.text = LabelText
       // self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view.
    }

    @IBAction func Click(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        let parameters: Parameters = [
            "id": idProyecto as Int!,
            "horas": hor.text as String!,
            "resumen": desc.text as String!,
            ]
        
        if  hor.text=="" || desc.text=="" {
            let alert = UIAlertController(title: "Error", message: "Debe llenar todos los campos", preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok",style: UIAlertActionStyle.default, handler:nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            Alamofire.request("http://192.168.1.38/api/reporte", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
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

                    }
                    
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cerraroper(_ sender: Any) {
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
