//
//  UIButton+Extension.swift
//  SeSACWeek5
//
//  Created by 박현진 on 8/4/25.
//

import UIKit


//Configuration안에서 필요한곳에서만 설정하겠다
extension UIButton.Configuration {
    
    //filled()처럼 jackstyle()같은걸 만들자
    static func jackStyle(title: String) -> UIButton.Configuration {
        
        var config = UIButton.Configuration.filled() //버튼안에 Configuration구조체 :구조체 안에 내용을 바꿀꺼라 var로 설정
        config.title = title
        config.image = UIImage(systemName: "star.fill")
        //config.subtitle = "여기가 버튼입니다."
        config.baseBackgroundColor = .purple
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        return config
    }
}
