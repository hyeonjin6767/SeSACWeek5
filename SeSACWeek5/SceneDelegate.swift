//
//  SceneDelegate.swift
//  SeSACWeek5
//
//  Created by 박현진 on 7/29/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    

    //중요한 기능을 담당하는 윈도우 계층
    var window: UIWindow? // 옵셔널 윈도우 : 닐이 들어갈 수 있어 : "그동안은 스토리보드에서 알아서 첫화면 실행" : 아이폰과 뷰 사이에 있는게 윈도우
    //우리가 보는 화면은 UIWindow이고 뷰컨트롤러가 여기서 띄어짐 : 기기와 뷰컨 사이에 중간역할
    //우리가 띄우는 모든 뷰컨들은 사실상 UIWindow에 띄워주는 것 :지금은 UIWindow객체가 nil인 상태이기 때문에 아무것도 못보여줘서 띄워지고 있지도 않은 상태
    //"아이폰에 윈도우 객체가 뷰컨에 수많은 뷰들을 띄워주고 있는 것": 실질적으로 아이폰과 UIView가 만날 일은 없다 UIWindow가 중간에 있어
    //그래서 우리가 코드로 UIWindow가 nil이 아니라 특정 뷰컨을 담당할 수 있게 해줘야함: 이걸 여기 SceneDelegate에서 해주면 됨(아래 가드문)
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        print(#function) //실행되고 첫화면 준비해달라고 호출 :willConnectTo가 실행되면 main스토리보드를 찾아서 Entry point찾아서 빌드를 해주었는데
        //지금은 우리가 다 지워서 실행할 화면이 없어서 까맣게 나오는거
        //스토리보드가 있을 때는 스토리보드가 알아서 윈도우에 첫화면을 띄워주는 거였고, 지금은 우리가 수동으로 다 처리해야함
        
        
        //매개변수 scene이 아래 가드문에 UIWindowScene와 매칭이 되서 옵셔널이 해제가 되는지 즉, 씬이 존재하는지 확인하는 것.
        guard let scene = (scene as? UIWindowScene) else { return } //씬이 존재하는지 확인
        
        //scene가 옵셔널이 해제되면서 매개변수로 들어갈 수 있고
        window = UIWindow(windowScene: scene)
        
        let nav = UINavigationController(rootViewController: VerticalScrollViewController()) // 메인에서 네비컨 임베드했던 행위를 이렇게 코드로
        //root는 가장 밑에 확인해야 하는 첫화면 : "루트"뷰를 PhotoViewController()로 지정해주겠다.
        window?.rootViewController = nav

        //필수 : "이 window에 뭐가 들어있다면 보이게 해달라"
        window?.makeKeyAndVisible() //필수 //window?에서 ?는 : 윗줄에서 확실히 데이터를 넣어줬는데도 왜 붙여야 하냐면 : UIWindow "자체가" 옵셔널이기 때문에
    
    
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

