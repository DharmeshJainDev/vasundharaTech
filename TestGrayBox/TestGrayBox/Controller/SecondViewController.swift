//
//  SecondViewController.swift
//  TestGrayBox
//
//  Created by Dharmesh Kochar on 16/10/23.
//

import UIKit

class SecondViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var dataSource: [GrayBox] = []
    var totalInputNumber = 10
    var redIndex = -1
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       initialSetup()
    }
    
}

//MARK: - Extension for private function
private extension SecondViewController {
    func initialSetup() {
        dataSource = Array(repeating: GrayBox(), count: totalInputNumber)
        titleLabel.text = "Just Assume User enter text \(totalInputNumber)"
        setSomeIndexBlue()
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        collectionView.register(UINib(nibName: "BoxCell", bundle: nil), forCellWithReuseIdentifier: "BoxCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setSomeIndexBlue(){
        let randomIndex = Int.random(in: 0..<totalInputNumber)
        if dataSource[randomIndex].isSelected {
            setSomeIndexBlue()
        } else {
            dataSource[randomIndex] = GrayBox(isSelected: false, isBlue: true)
        }
    }
}


//MARK: - Extension for objc Functions
@objc extension SecondViewController {
    func userSelectedNewBox(_ sender: UIButton) {
        guard var box = dataSource.first(where: {$0.isBlue && redIndex != dataSource.count - 1 }) else { return }
        box.isSelected = true
        box.isBlue = false
        dataSource[sender.tag] = box
        let totalBoxleft = dataSource.filter{ $0.isSelected == false}
        if totalBoxleft.count > 0 {
            setSomeIndexBlue()
        }
        if totalBoxleft.count == 1 {
            if let lastBox = dataSource.firstIndex(where: {!$0.isSelected}) {
                dataSource[lastBox].isLast = true
                dataSource[sender.tag] = box
            }
        }
        collectionView.reloadData()
    }
}

//MARK: - Extension for collectionView
extension SecondViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoxCell", for: indexPath) as? BoxCell else { fatalError("not able to dequeue")}
        if dataSource[indexPath.row].isLast {
            cell.boxBtn.backgroundColor = .lightGray
        } else if dataSource[indexPath.row].isSelected {
            cell.boxBtn.backgroundColor = .red
        } else if dataSource[indexPath.row].isBlue {
            cell.boxBtn.backgroundColor = .blue
        } else {
            cell.boxBtn.backgroundColor = .white
        }
        cell.boxBtn.isUserInteractionEnabled = dataSource[indexPath.row].isBlue ? true : false
        cell.boxBtn.tag = indexPath.row
        cell.boxBtn.addTarget(self, action: #selector(userSelectedNewBox(_:)), for: .touchUpInside)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

