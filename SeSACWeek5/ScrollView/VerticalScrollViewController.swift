//
//  VerticalScrollViewController.swift
//  SeSACWeek5
//
//  Created by 박현진 on 8/5/25.
//

import UIKit
import SnapKit
//수직 스크롤뷰
class VerticalScrollViewController: UIViewController {

    let scrollView = UIScrollView()
    
    let contentView = UIView() //스크롤뷰는 뷰 하나만 관리하는 형태가 가장 편하다
    
    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()
    
    
    //사진, 설명, 지도, 버튼 등으로 구성된 세로로 긴 컨텐츠를 스크롤시에 테이블뷰로 하기는 어려워 : 그룹화하자
    // 이 들을 미리 감싸서 UIView에 담아, 이 UIView만 스크롤뷰에 담아 관리하는 형태 : 이들을 uiview에 담을 때 레이아웃은?
    //싹 다 고정으로 레이아웃 잡아두고 딱 한개(영화줄거리같이 무한대로 늘어날 수 있는 애: 유동적인 높이를 가진 애)만 두고 처음에는 테스트를 해보는게 낫다
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        contentView.addSubview(button)

        scrollView.backgroundColor = .lightGray //당기면 뒤에 회색배경이 보여짐: 이게 싫으면 바운스 끄면 됨
        contentView.backgroundColor = .red
        
        scrollView.bouncesVertically = false //바운스(땡기는것) 끄기
        
        label.backgroundColor = .orange
        button.backgroundColor = .purple
        imageView.backgroundColor = .gray
        
        
        
        
        //높이는 고정 너비가 얼마나 길어질지 모르기 때문에 고정하지 않는다 : 안의 내용물에 의해 알아서 결정됨
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide) //디바이스 꽉 차게
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width) //너비는 고정하고
            //높이는 고정X //내부에 들어있는 객체들의 높이가 고정되어 잇으면 컨텐츠의 높이는 알아서 결정되고 이 결정으로 스크롤뷰의 높이도 알아서 결정됨
            make.verticalEdges.equalTo(scrollView) // 상단과 하단에만 컨텐트엣지로 고정.
            
        }
        
        
        //uiview안에 넣는 것들은 의도적으로 많이 키워둠: 얼마나 길어질지 모르니까 테스트로
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(900) //테스트용 //참고로 아이폰 16프로의 높이가 800얼마: 이미 스크롤이 필요한 상황으로 만듬
        }
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.top.equalTo(label.snp.bottom).offset(50)
            make.bottom.equalTo(imageView.snp.top).offset(-50)
            //make.height.equalTo(50) //이미지같이 기본 높이가 없는 애들은 높이 설정 필요 //버튼(ex.레이블,스위치,세그먼트 등등)은 글자 영역이 있어서 최소 높이가 글자에 따라 결정됨 :
        }
        imageView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView).inset(20) //컨텐트뷰의 끝나는 지점에 맞춰
            make.height.equalTo(200)
        }
        
    }
    

    

}
