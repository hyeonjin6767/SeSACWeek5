//
//  ImageZoomViewController.swift
//  SeSACWeek5
//
//  Created by 박현진 on 8/5/25.
//

import UIKit
import SnapKit
//확대 스크롤뷰
class ImageZoomViewController: UIViewController {

    
    //스크롤뷰
    //이미지뷰를 톡톡 누르면 커지게 : 확대 축소하려면 이미지뷰
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .yellow
        view.image = UIImage(systemName: "star")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true //제스처(인터랙션) 인식 가능하게 : 더블 클릭 인식 가능하게
        return view
    }()
    
    let scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green //드래그로 땡기면 바탕색이 보임
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = true
        view.minimumZoomScale = 1
        view.maximumZoomScale = 5
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageView) //스크롤뷰에 에드 주의!
        
        scrollView.delegate = self //스크롤뷰의 프로토콜 채택

        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        //이미지뷰 위치(4개 엣지)가 고정이 되면 안되 : 확대된다면 사이즈 지정이 되어있으면 의미가 없으니
        //스크롤뷰의 안쪽을 레이아웃 잡는게 중요!
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView) //스크롤뷰에 사이즈를 꼭 맞춰줘야함!
        }
        
        //더블클릭했을때 커지게
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(doubleTap))
        
        tap.numberOfTapsRequired = 2 //최소 몇개의 탭이 되야 인식이 될건지: 더블탭
        //어디에 제스처를 넣어줘야 하나
        imageView.addGestureRecognizer(tap) //스크롤뷰에 이미지가 있기 때문에: 스크롤뷰에 추가하면 안되고 이미지뷰에 추가해줘야함
    }
    
    @objc func doubleTap() {
        print(#function)
        //scrollView.setZoomScale(3, animated: true) //무조건 "3배"로 사이즈 늩려줘
        
        //조건에 따라 몇배로 사이즈 늘리고 줄일지
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(3, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true) //조건문으로 원본으로 사이즈로 돌리기
        }
    }
}

extension ImageZoomViewController: UIScrollViewDelegate { //줌해주는 기능을 담당하는 친구
    //스크롤뷰가 3배커질때 이미지뷰도 따라갈건지 안따라갈건지 결정해주는
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView //줌이 될때 가지고 있는 이미지뷰를 보내줘
    }
    
}
