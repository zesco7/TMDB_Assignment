//
//  IntroPageViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/25.
//

import UIKit

class IntroPageViewController: UIPageViewController {
    
    var pageViewControllerList : [UIViewController] = [] //뷰컨트롤러 빈배열 생성
    var isFirstRun = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        delegate = self
        dataSource = self
        
        createPageViewController()
        configurePageViewController()
        //checkFirstRun()
        AppLaunchStatus.checkFirstRun()
    }
    
    /*
    func checkFirstRun() {
        let firstRun = !UserDefaults.standard.bool(forKey: "FirstRun")
        if firstRun == true {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "IntroPageViewController") as! IntroPageViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            UserDefaults.standard.set(false, forKey: "FirstRun")
        } else if UserDefaults.standard.bool(forKey: "FirstRun") == false {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MoviePosterListViewController") as! MoviePosterListViewController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            }
        print(firstRun)
        print(#function, UserDefaults.standard.bool(forKey: "FirstRun"))
        }
     */
    
    func createPageViewController() { //빈배열에 뷰컨트롤러 넣기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "IntroFirstViewController") as! IntroFirstViewController
        let vc2 = sb.instantiateViewController(withIdentifier: "IntroSecondViewController") as! IntroSecondViewController
        
        pageViewControllerList = [vc1, vc2]
    }
    
    func configurePageViewController() { //화면표시 첫화면 설정
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
    
}

extension IntroPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    //화면이동 기능
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil } //화면이동시 인덱스 설정
        let previousIndex = viewControllerIndex - 1
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex] //끝화면 조건 설정
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil } //화면이동시 인덱스 설정
        let nextIndex = viewControllerIndex + 1
        return nextIndex == pageViewControllerList.count ? nil : pageViewControllerList[nextIndex] //끝화면 조건 설정
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        return index
    }
}
