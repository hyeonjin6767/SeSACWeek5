//
//  NextViewController.swift
//  SeSACWeek5
//
//  Created by 박현진 on 8/1/25.
//

import UIKit
import SnapKit

class NextViewController: UIViewController {
    
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    //여기가 레이지 혹은 아래 레이아웃 함수가 static으로 하면
    
    func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100) //디바이스 너비 에 딱 맞춰서
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.backgroundColor = .brown
        
        collectionView.register(NextCollectionViewCell.self, forCellWithReuseIdentifier: NextCollectionViewCell.identifier)
       
        
        collectionView.isPagingEnabled = true //넘길 때 셀이 정중앙에 위치하도록(셀을 디바이스 너비사이즈로): 여백이 없어야 잘됨: 컬렉션뷰가 디바이스 너비에 맞춰서 해줌
    }
    
}
extension NextViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextCollectionViewCell.identifier, for: indexPath) as! NextCollectionViewCell
        return cell
    }
    
    
}
