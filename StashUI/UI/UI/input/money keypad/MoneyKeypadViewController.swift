//
//  MoneyKeypadView.swift
//  StashInvest
//
//  Created by Daniel Ramteke on 7/26/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public struct MoneyKeypadViewModel {
    let keypadType: MoneyKeypadType
    let keypadStyle: KeypadButtonModel.Style
    let maxAmount: Double?
    
    public init(maxAmount: Double?, type: MoneyKeypadType = .standard, style: KeypadButtonModel.Style = .light) {
        self.maxAmount = maxAmount
        keypadType = type
        keypadStyle = style
    }
    
    public var buttonModels: [KeypadButtonModel] {
        return keypadType.buttonModels(style: keypadStyle)
    }
    
    public var buttonsContainsPeriod: Bool {
        return self.buttonModels.filter { $0.value == String(MoneyKeypadBrain.CustomCharacters.period) }.count > 0
    }
}

public class MoneyKeypadViewController: UIViewController {
    @IBOutlet var collectionView: KeypadCollectionView!
    private var collectionViewDelegate: CollectionViewDelegate!
    private var collectionViewDataSource: CollectionViewDataSource!
    private let keypadBrain: MoneyKeypadBrain
    let model: MoneyKeypadViewModel
    
    public weak var output: MoneyKeypadOutput? {
        set {
            self.keypadBrain.output = newValue
        }
        get {
            return keypadBrain.output
        }
    }
    public var amount: (doubleValue: Double, displayValue: String) {
        return keypadBrain.amount
    }
    
    public func addTo(containerView: UIView, in viewController: UIViewController?) {
        viewController?.addChildViewController(self)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(self.view)
        containerView.addConstraints([
            self.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            self.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        self.didMove(toParentViewController: viewController)
    }
    
    public func removeFromContainer() {
        if parent == nil { return }
        
        self.willMove(toParentViewController: nil)
        view.removeFromSuperview()
        self.removeFromParentViewController()
    }

    public func resetAmount(to newAmount: Decimal) {
        keypadBrain.reset(to: newAmount)
        output?.updatedAmount((keypadBrain.doubleValue, keypadBrain.displayValue))
    }

    public init(model: MoneyKeypadViewModel) {
        self.model = model
        keypadBrain = MoneyKeypadBrain(maxValue: model.maxAmount, queueTyping: !model.buttonsContainsPeriod)
        super.init(nibName: "MoneyKeypadView", bundle: Bundle(for: MoneyKeypadViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        collectionView.isLinesViewHidden = true
        collectionView.register(UINib(nibName: KeypadCollectionViewCell.reuseIdentifier, bundle: Bundle(for: KeypadCollectionViewCell.self)), forCellWithReuseIdentifier: KeypadCollectionViewCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(KeyPadCollectionViewFlow(), animated: false)
        
        let items: [Item] = model.buttonModels.map { keypadButtonModel in
            var item = Item(KeypadCollectionViewCell.self)
            
            item.configure = { cell in
                (cell as? KeypadCollectionViewCell)?.configure(for: keypadButtonModel)
            }
            
            item.didSelect = { [weak keypadBrain, weak self] collectionView, indexPath in
                guard let strongSelf = self else { return }
                
                collectionView.deselectItem(at: indexPath, animated: true)
                guard let value = strongSelf.model.buttonModels[indexPath.row].value else { return }
                keypadBrain?.enter(value: Character(value))
            }
            
            return item
        }
        
        let collection = Collection(section: Section(items: items))
        
        collectionViewDelegate = CollectionViewDelegate(collection: collection)
        collectionViewDataSource = CollectionViewDataSource(collection: collection)
        
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDataSource
    }
}
