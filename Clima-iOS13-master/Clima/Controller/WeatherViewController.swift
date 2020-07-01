//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  
  var weatherManager = WeatherManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    searchTextField.delegate = self
    weatherManager.delegate = self
  }
  
  @IBAction func searchPressed(_ sender: UIButton) {
    searchTextField.endEditing(true)
    guard let searchText = searchTextField.text else { return }
    print(searchText)
  }
  
}

extension WeatherViewController: UITextFieldDelegate {
  // 텍스트 필드에서 유저가 리턴 키를 눌렀을 때
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // 텍스트필드의 수정을 완료하였다는 신호를 보내면 키보드를 내린다.
    searchTextField.endEditing(true)
    guard let searchText = searchTextField.text else { return true }
    print(searchText)
    
    return true
  }
  
  // 텍스트필드 수정을 끝냈을 때
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    guard let city = searchTextField.text else { return }
    weatherManager.fetchWeather(cityName: city)
    
    searchTextField.text = ""
  }
  
  // 텍스트필드에서 유저의 수정이 완료되었을 때 true/false를 validate
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      textField.placeholder = "검색할 내용을 입력해 주세요"
      return false
    }
    
    return true
  }
}

extension WeatherViewController: WeatherManagerDelegate {
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherData) {
    print("DEBUG: ", weather.temperature)
  }
}
