//
//  AppLaunchStatus.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/26.
//

import Foundation

//여러 스위프트 파일에서 인스턴스없이 접근할 수 있도록 클래스와 타입메서드 생성
//UserDefaults값에 따라 상태를 구분할 수 있도록 조건문 작성: 앱실행시 UserDefaults 기본값이 nil이므로 기본값상태에 따른 반환값 true로 첫실행임을 구분하고, UserDefaults에 값을 저장하여 조건문에 따라 다음 실행이 첫실행이 아님을 구분한다.
public class AppLaunchStatus {
    static func checkFirstRun() -> Bool {
        if UserDefaults.standard.object(forKey: "isFirstRun") == nil {
            UserDefaults.standard.set("no", forKey: "isFirstRun")
            print(UserDefaults.standard.object(forKey: "isFirstRun"))
            return true
        } else {
            print(UserDefaults.standard.object(forKey: "isFirstRun"))
            return false
        }
    }
}
