//
//  WeatherMapViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/24.
//

import UIKit
import CoreLocation

/*날씨 포인트
 -. 네트워크 통신할 때 클로저 사용필요: 네트워크 통신 결과로 받은 JSON데이터를 네트워크 통신 함수 바깥에서 사용하기 위해 클로저를 통해 completionHandler의 인자를 넘겨준다. 이때 프로퍼티를 만들고 인자를 대입하면 인자에 접근할 수 있다.
 */
class WeatherMapViewController: UIViewController {
    static var identifier = "WeatherMapViewController"
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    let locationManager = CLLocationManager()
    let weatherInfo : [WeatherModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        locationManager.delegate = self
        
    }
}

extension WeatherMapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        
        cell.configureCell()
        cell.currentTemperature?.text = "\(weatherInfo[indexPath.row].temp)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension WeatherMapViewController {
    //위치서비스 사용체크
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus //위치서비스 이벤트 관리 열거형
        
        //ios버젼 체크
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //위치서비스 사용체크
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus) //위치서비스 사용중이면 위치권한 요청
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
            showRequestLocationServiceAlert() //위치서비스 사용중 아니면 설정에서 위치서비스 켜기 얼럿 띄우기
        }
    }
        
        //위치권한 요청
        func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
            switch authorizationStatus {
            case .notDetermined:
                print("NOTDETERMINED")
                locationManager.desiredAccuracy = kCLLocationAccuracyBest //위치정확도 높이기
                locationManager.requestWhenInUseAuthorization() //위치권한 요청 얼럿 띄우기
            case .restricted, .denied:
                print("DENIED") //다시 빌드해도 권한거부 상태이므로 위치권한 on권유
            case .authorizedWhenInUse:
                print("WHENINUSE")
                locationManager.startUpdatingLocation() //위치정보 업데이트
            default: print("DEFAULT")
            }
        }
        
        func showRequestLocationServiceAlert() { //사용자가 위치서비스 사용거부했을 때 얼럿 추가(DENIED 상태때 실행)
            let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
            let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
                if let appSetting = URL(string: UIApplication.openSettingsURLString) { //"설정으로 이동"눌렀을 때 디바이스 설정메뉴로 이동하도록 액션 추가
                    UIApplication.shared.open(appSetting)
                }
            }
            let cancel = UIAlertAction(title: "취소", style: .default)
            requestLocationServiceAlert.addAction(cancel)
            requestLocationServiceAlert.addAction(goSetting)
            
            present(requestLocationServiceAlert, animated: true, completion: nil)
        }
    }

extension WeatherMapViewController: CLLocationManagerDelegate {
    //위치권한 사용O
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        if let location = locations.last?.coordinate {
            print(location)
            APIManager.shared.requestWeatherInformation(latitude: location.latitude, longitude: location.longitude) { weather in
                let weatherInfo = weather //네트워크 통신 결과로 받은 JSON데이터를 네트워크 통신 함수 바깥에서 사용하기 위해 클로저를 통해 completionHandler의 인자를 넘겨준다. 이때 프로퍼티를 만들고 인자를 대입하면 인자에 접근할 수 있다.
                DispatchQueue.main.async {
                    self.weatherTableView.reloadData()
                }
                print(weatherInfo)
            }
        }
        locationManager.stopUpdatingLocation()
    }
    
    //위치권한 사용X
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    //위치권한 사용변경
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
}

