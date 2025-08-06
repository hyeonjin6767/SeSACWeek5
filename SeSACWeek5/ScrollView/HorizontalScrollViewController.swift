//
//  HorizontalScrollViewController.swift
//  SeSACWeek5
//
//  Created by 박현진 on 8/5/25.
//

import UIKit
import SnapKit
//수평 스크롤뷰
class HorizontalScrollViewController: UIViewController {

    
    //수평스크롤을 만들어보자 : 스택뷰(레이블 몇개 넣은)를 스크롤뷰에 넣겠다
    // : 스택뷰처럼 그룹을 만들어주는게 쉽게 할수 있더라: 스크롤뷰가 스택뷰 하나만 관리하게끔하는게 수월
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints { make in
            make.height.equalTo(50) //수평으로 스크롤할거니까 높이는 고정
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide) //컨텐츠크기 설정이랑 헷갈림 주의
        }
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.edges.equalTo(scrollView) //여기서 edges는 스크롤뷰안에 들어가는 컨텐츠 크기에 대한 엣지 라고 생각하면 됨
            // 중요!
            //너비 설정하면 수평 스크롤이 안됨
            //수평스크롤(너비에 따라 스크롤이 되니까) : 높이 고정O, 너비 고정X
            //수직스크롤(높이에 따라 스크롤이 되니까) : 높이 고정X 너비 고정O
        }
        
        configureLabel()
        stackView.spacing = 20 //스택뷰간 사이 간격
    }
    
    func configureLabel() {
            let label = UILabel()
            label.backgroundColor = .orange
            label.text = "slafdsafdsafdsafdafdsafdsafdsafdfsafdsa" //글자 길에 맞춰 너비 결정
        
            stackView.addArrangedSubview(label) //스택뷰에 레이블 넣기
            
            let label2 = UILabel()
            label2.backgroundColor = .brown
            label2.text = "slafds"
        
            stackView.addArrangedSubview(label2)
            
            let label3 = UILabel()
            label3.text = "33456"
            label3.backgroundColor = .gray
            label3.textColor = .white
        
            stackView.addArrangedSubview(label3)
            
            let label4 = UILabel()
            label4.text = "34354aasdfsadssafdsafdsa53456"
            label4.backgroundColor = .purple
            label4.textColor = .white
        
            stackView.addArrangedSubview(label4)
            
            let label5 = UILabel()
            label5.text = "3435453456"
            label5.backgroundColor = .orange
            label5.textColor = .white
        
            stackView.addArrangedSubview(label5)

        }
}
