//
//  WebViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/17.
//

import UIKit
import WebKit

import Alamofire
import Kingfisher
import SwiftyJSON

/*질문
 -. 화면전환시 webview가 잠깐 떴다가 사라지는 이유?
 -. video데이터에서 key가 7개씩 있어서 배열 첫번째 값으로 재생하려고 keyArray[0]으로 url값 전달하면 index out of range 발생이유? -> 배열접근하는 방법이 따로 있는건지?, data["key"][0].stringValue처럼 애초에 첫번째 배열값만 받아 올수는 없는건지?
 -. var videoURL 변수를 어디에 선언해야하는지?
 
 */
class WebViewController: UIViewController, UIWebViewDelegate {
    static var identifier = "WebViewController"

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet var UIView: UIView!
    
    var movieID: Int? //화면전환시 TMDB 정보수신: 영화ID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTrailer(movieID: 985939)
    
        navigationItemAttribute()

    }
    
    //동영상화면 -> 영화정보목록화면 이동 기능 추가
    func navigationItemAttribute() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonItemClicked))
    }
    
    @objc func leftBarButtonItemClicked() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate =  windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TMDBViewController") as! TMDBViewController
        let navi = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = navi
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    func requestTrailer(movieID: Int) {
        APIManager.shared.requestVideoKey(movieId: movieID) { movieKey in
            self.loadVideo(url: movieKey)
            print(movieID)
        }
    }
    
    func loadVideo(url: String) {
        guard let url = URL(string: url) else {
        print("Invalid URL")
        return
    }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}


