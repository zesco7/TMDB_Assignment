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
 -. video데이터에서 key가 7개씩 있어서 배열 첫번째 값으로 재생하려고 keyArray[0]으로 url값 전달하면 index out of range 발생이유?
 -. var videoURL 변수를 어디에 선언해야하는지?
 
 */
class WebViewController: UIViewController {
    static var identifier = "WebViewController"

    @IBOutlet weak var webView: WKWebView!
    var movieID = UserDefaults.standard.integer(forKey: "movieId") //화면전환시 TMDB 정보수신: 영화ID
    var keyArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var videoURL = "\(EndPoint.YouTubeURL)\(keyArray[0])"
        
        requestVideo(movieId: movieID)
        loadVideo(url: videoURL)

    }
    
    func requestVideo(movieId: Int) {
        let castUrl = "\(EndPoint.CastURL)\(movieId)/videos?api_key=\(APIKey.TMDBAPIKey)&language=en-US"
        AF.request(castUrl, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for data in json["results"].arrayValue {
                    let key = data["key"].stringValue
                
                    self.keyArray.append(key)
                }
                
                //self.webView.reloadData()
                print(self.keyArray)
                
            case .failure(let error):
                print(error)
            }
        
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
