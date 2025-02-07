//
//  ViewController.swift
//  bmi-calc
//
//  Created by James Chard on 2025/2/7.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var weightUnit: UILabel!
    @IBOutlet weak var heightUnit: UILabel!
    
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var weightInput: UITextField!
    
    @IBOutlet weak var bmiText: UILabel!
    @IBOutlet weak var validWarning: UILabel!
    
    @IBOutlet weak var categoryInfoText: UITextView!
    
    @IBOutlet weak var bmiCategoryText: UILabel!
    
    let categoryText = """
    Underweight = <18.5
    Normal Weight = 18.5 - 24.9
    Overweight = < 25-29.9
    Obesity = 30 or higher
    """
    
    
    
    @IBAction func CalcBtn(_ sender: Any) {
        let weightText = weightInput.text ?? ""
        let weightDouble = Double(weightText) ?? 0.0
        
        let heightText = heightInput.text ?? ""
        let heightDouble = Double(heightText) ?? 0.0
        
        let isValid = weightDouble > 0 && heightDouble > 0
        
        validWarning.isHidden = isValid
        
        if(isValid) {
            var bmi = calculateBMI(fromWeight: weightDouble, fromHeight: heightDouble, inUnits: currentUnitMode)
            
            bmiText.text = String(format: "%.2f", bmi)
            bmiCategoryText.text = getBMICategory(fromBMI: bmi);
        }
    }
    
    var currentUnitMode = "Metric"
    var WeightUnits: [String: String] = [
        "Metric": "kg",
        "Standard": "lb"
    ]
    
    var HeightUnits: [String: String] = [
        "Metric": "cm",
        "Standard": "ft"
    ]
    
    func switchUnitMode () {
        currentUnitMode = currentUnitMode == "Metric" ? "Standard" : "Metric"
        unitLabel.text = currentUnitMode
        weightUnit.text = "(\(WeightUnits[currentUnitMode] ?? "kg"))"
        heightUnit.text = "(\(HeightUnits[currentUnitMode] ?? "kg"))"
    }
    
    func kgToLb(_ kg: Double) -> Double {
        return 2.20462 * kg;
    }
    
    func lbToKg(_ lb: Double) -> Double {
        return 0.45359 * lb
    }
    
    func ftToCm(_ ft: Double) -> Double {
        return 30.48 * ft;
    }
    
    func cmToFt(_ cm: Double) -> Double {
        return 0.03281 * cm;
    }
    
    func calculateBMI(fromWeight weight: Double, fromHeight height: Double, inUnits unit: String) -> Double {
        let metricWeight = unit == "Metric" ? weight : lbToKg(weight)
        let metricHeight = unit == "Metric" ? height / 100 : ftToCm(height) / 100
        print(metricHeight)
        print(metricWeight)
        return metricWeight / (metricHeight * metricHeight)
    }
    
    func getBMICategory(fromBMI bmi: Double) -> String {
        if(bmi < 18.5) {
            return "Underweight"
        } else if(bmi < 25) {
            return "Normal"
        } else if (bmi < 30) {
            return "Overweight"
        } else {
            return "Obese"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        categoryInfoText.text = categoryText
    }
    
    @IBAction func unitSwitch(_ sender: Any) {
        switchUnitMode()
    }


}

