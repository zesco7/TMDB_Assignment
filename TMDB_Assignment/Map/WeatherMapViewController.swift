//
//  WeatherMapViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/24.
//

import UIKit
import CoreLocation

import Kingfisher

/*날씨 포인트
 -.네트워크 통신: 클로저 사용필요함. 네트워크 통신 결과로 받은 JSON데이터를 네트워크 통신 함수 바깥에서 사용하기 위해 클로저를 통해 completionHandler의 인자를 넘겨준다. 이때 프로퍼티를 만들고 인자를 대입하면 인자에 접근할 수 있다.
 -.테이블뷰 화면표시: 데이터 잘 받았는데 화면에 테이블뷰 안뜨면 프토토콜, xib파일(register) 연결 확인한다.
 -.ATS: 데이터 잘들어오는데 화면표시 안될 때 http체크해서 ATS 적용해준다.
 */

/*질문
 -.weatherInfo출력해보면 값이 하나 있는데 weatherInfo.count하면 왜 0인지? -> 해결: 클로저 인자로 받은 weather를 빈배열인 weatherInfo에 바로 넣어줬어야 하는데(self.weatherInfo) 다시 변수를 만들어 값을 넣은뒤 넘겨주려고 생각하니까 헤매면서 시간낭비함.
 */
class WeatherMapViewController: UIViewController {
    static var identifier = "WeatherMapViewController"
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var weatherInfo : [WeatherModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        locationManager.delegate = self
        
    }
}

extension WeatherMapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
 
            //MeasurementFormatter() 클래스 사용하면 여러가지 단위 사용 가능
            let temperature = String(format: "%.1f", weatherInfo[indexPath.row].temp - 273.15) //섭씨변환 + 소수점 이하 자릿수 설정
            
            cell.currentTemperature.text = "   \(temperature)℃에요   "
            cell.currentHumidity.text = "   \(weatherInfo[indexPath.row].humidity)%만큼 습해요   "
            cell.currentWindSpeed.text = "   \(weatherInfo[indexPath.row].windSpeed)m/s의 바람이 불어요   "
            
            let url = URL(string: "\(EndPoint.weatherIconURL)\(weatherInfo[indexPath.row].icon)@2x.png") //클로저로 받은 날씨아이콘코드를 변수로 대입
            cell.weatherImageView.kf.setImage(with: url)
            cell.greetings.text = "   오늘도 행복한 하루 보내세요   "
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 400
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm 현재시간 날씨"
        
        return "\(dateFormatter.string(from: Date()))"
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
                //클로저 인자로 받은 weather를 빈배열인 weatherInfo에 바로 넣어줬어야 하는데(self.weatherInfo) 다시 변수를 만들어 값을 넣은뒤 넘겨주려고 생각하니까 헤매면서 시간낭비함.
                //네트워크 통신 결과로 받은 JSON데이터를 네트워크 통신 함수 바깥에서 사용하기 위해 클로저를 통해 completionHandler의 인자를 넘겨준다. 이때 프로퍼티를 만들고 인자를 대입하면 인자에 접근할 수 있다.
                self.weatherInfo = weather
                
                DispatchQueue.main.async {
                    self.weatherTableView.reloadData()
                }
                print(self.weatherInfo)
            }
            locationManager.stopUpdatingLocation()
        }
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

