//
//  MapViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/22.
//

import UIKit
import MapKit //맵뷰 사용 위해 맵킷 등록
import CoreLocation //위치권한1. 위치권한 담당하는 라이브러리 등록


/*지도 포인트
 -. 지도와 위치권한은 상관없다. 사용자 위치를 보여주는게 아니라 특정위치를 보여주는 것일수도 있기 때문
 -. 지도에 현재 위치를 표시할 때 위치권한을 등록해야 한다.
 -. 원하는 위치에 핀을 표시할 수 있다.
 */

/*위치권한 포인트
 -. 권한은 앱삭제후 재설치해도 반영이 조금씩 느릴 수 있음.
 */

/*위치권한 순서
 1. 라이브러리 등록: CoreLocation
 2. 위치 관련 이벤트 전달 관리하는 클래스 등록
 3,4. 프로토콜 연결, 선언
 5,6. 위치권한 요청 성공, 실패 메서드 생성
 7. iOS버전에 따라 iOS위치서비스 활성화 여부 확인 *실제 코드실행은 7이 5,6보다 먼저 실행
 8. 사용자의 위치 권한 상태 확인
 9. 사용자 권한 상태 바뀔때를 알려줌
 */


/*질문
 -. mapView.addAnnotation(annotation)에서 annotation을 넣는 이유?(문법체크)
 
 */
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    //위치권한2. 위치 관련 이벤트 전달 관리하는 클래스 등록
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //위치권한3. 프로토콜 연결
        locationManager.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 37.544133, longitude: 127.075364)
        setRegionAndAnnotation(center: center)
        
        //앱처음시작할때 locationManagerDidChangeAuthorization 실행되기 때문에 viewDidLoad에서 checkUserDeviceLocationServiceAuthorization 실행 안해도 됨
        //checkUserDeviceLocationServiceAuthorization()
    
    }
    
//    override func viewDidAppear(_ animated: Bool) { //viewDidLoad는 화면뜨기 전이므로 얼럿 실행 안되기 때문에 viewDidAppear에서 얼럿 실행
//        showRequestLocationServiceAlert()
//    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) { //시작위치 -> 현재위치일 때 현재위치에 핀설정하기
        //애플맵 좌표복사해서 지도 중심 설정
        
        
        //지도중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        //지도에 핀 추가: 핀 표시할 위치를 설정하고 글자 표시
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "이곳이 중심이다."
        mapView.addAnnotation(annotation)
    }
    
}

//위치 관련된 User Defined 메서드
extension MapViewController {
    
    //위치권한7. iOS버전에 따라 iOS위치서비스 활성화 여부 확인
    func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus //위치서비스 권한 체크
        
        /*CLAuthorizationStatus 상태 구분
         -. denied: 처음 알림때 허용 안 함 클릭, 나중에 설정에서 거부, 위치서비스 중지, 비행기 모드
         -. restricted: 앱에서 권한 자체가 없는 경우(Ex.자녀보호기능)
         */
        
        if #available(iOS 14.0 , *) {
            //인스턴스를 통해 authorizationStatus가 가지고 있는 상태를 가져옴
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //iOS 위치서비스 활성화 여부 체크: locationServicesEnabled(위치서비스on -> 권한요청, 위치서비스off -> 커스텀얼럿으로 상황알리기)
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
        }
    }
     
    //위치권한8. 사용자의 위치 권한 상태 확인
    //사용자가 위치를 허용했는지 거부했는지 아직 선택하지 않았는지 등을 확인(단, 사전에 iOS 위치서비스 활성화 꼭 확인)
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined: //위치권한 사용 정해지지 않은 경우 권한요청 시도
            print("NOTDETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //위치정확도 설정
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 위치 권한 요청 얼럿 실행(plist에 whenInUse등록되어있어야만 사용가능, 아니면 앱꺼짐)
            locationManager.startUpdatingLocation() //한번 허용을 눌렀을 때 실행
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
        case .authorizedWhenInUse: //위치권한 허용 상태면 startUpdatingLocation을 통해 didUpdateLocations(위치권한5) 실행
            print("WHEN IN USE")
            locationManager.startUpdatingLocation()
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

//위치권한4. 프로토콜 선언
extension MapViewController: CLLocationManagerDelegate {
    //위치권한5. 사용자 위치 데이터 수신 성공한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        /*locationManager.startUpdatingLocation()
         -. 계속 호출되는 특징이 있기 때문에 사용중에 불필요한 호출을 막기 위해 stopUpdatingLocation사용
         -. 위치정보가 많이 바뀌면 자동으로 호출되기 때문에 위치정보 업데이트 안 될 걱정 안해도 됨.
         -. locationManager.stopUpdatingLocation()안해주면 배터리 소모속도가 높아지는 원인이 될 수 있음
         */
        
        if let coordinate = locations.last?.coordinate { //현재위치 정보데이터인 locations.last?.coordinate를 사용하여 핀표시
            setRegionAndAnnotation(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    //위치권한6. 사용자 위치 데이터 수신 실패한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    //위치권한9. 사용자 권한 상태 바뀔때를 알려줌(ex. 위치권한거부 -> 설정에서 허용, notDetermined에서 허용, 허용해서 위치 정보 가져오는 중에 설정에서 거부)
    //앱처음시작할때 메서드 실행됨: 권한요청에 대한 선택을 해서 권한상태가 변경되기 때문에(ex. NOTDETERMINED -> WHEN IN USE or DENIED)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { //iOS14 이상
        print(#function)
        checkUserDeviceLocationServiceAuthorization() //위치서비스 자체를 off할 수 있기 때문에 항상 위치서비스 상태 체크를 해줘야함.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) { //iOS14 미만
        <#code#>
    }
}


extension MapViewController: MKMapViewDelegate {
    //기본핀 대신 커스텀핀 사용할 수 있는 메서드
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        <#code#>
//    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        locationManager.startUpdatingLocation()
    }
    
}
