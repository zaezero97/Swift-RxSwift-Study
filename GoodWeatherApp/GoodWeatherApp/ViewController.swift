//
//  ViewController.swift
//  GoodWeatherApp
//
//  Created by 재영신 on 2021/12/15.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: {
                city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }, onError: {
                _ in
                print("error 🤣")
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
 
    }
    
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp)℉"
            self.humidityLabel.text = "\(weather.humidity)💦"
        } else {
            self.temperatureLabel.text = "😇"
            self.humidityLabel.text = "❌"
        }
    }
    
    private func fetchWeather(by city: String) {
        guard let city = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL.urlForWeatherAPI(city: city) else { return }
        
        let resource = Resource<WeatherResult>(url: url)
        
        let search = URLRequest.load(resource: resource)
            .retry(3)
            .catch({ error in
                print("Error 🙀!!!", error.localizedDescription)
                return Observable.just(WeatherResult.empty)
            })
            .asDriver(onErrorJustReturn: WeatherResult.empty)

        search.map { "\($0.main.temp)℉"}
        .drive(self.temperatureLabel.rx.text)
        .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity)💦" }
        .drive(self.humidityLabel.rx.text)
        .disposed(by: disposeBag
        )
    }
}

