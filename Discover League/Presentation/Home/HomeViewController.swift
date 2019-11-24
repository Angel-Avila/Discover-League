//
//  HomeViewController.swift
//  Discover League
//
//  Created by Angel Avila on 19/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let champions: [Champion]!
    private let sections: [ChampionSection]!
    
    private var championHash = [String: Champion]()
    private var skinHash = [String: Skin]()
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<ChampionSection, DataIdentifier>?
    
    init(preferredLanguage language: String) {
        self.champions = Bundle.main.decodeChampions(localization: language)
        self.sections = Bundle.main.decode([ChampionSection].self, from: "sections.json")
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        hashData()
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Discover"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
        collectionView.register(TallCell.self, forCellWithReuseIdentifier: TallCell.reuseIdentifier)
        collectionView.register(MediumCell.self, forCellWithReuseIdentifier: MediumCell.reuseIdentifier)
    }
    
    private func hashData() {
        champions.forEach { champion in
            championHash[champion.id] = champion
            champion.skins.forEach { skinHash[$0.id] = $0 }
        }
    }
}

// MARK: - Collection View DataSource

extension HomeViewController {
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ChampionSection, DataIdentifier>(collectionView: collectionView, cellProvider: { collectionView, indexPath, identifier -> UICollectionViewCell? in
            
            switch self.sections[indexPath.section].type {
            case "mediumTable":
                return self.configure(MediumCell.self, with: identifier, for: indexPath)
            
            case "tallTable":
                return self.configure(TallCell.self, with: identifier, for: indexPath)
            default:
                return self.configure(FeaturedCell.self, with: identifier, for: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else { return nil }
            
            guard let firstDataIdentifier = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstDataIdentifier) else { return nil }
            
            if section.title.isEmpty { return nil }
            
            sectionHeader.title.text = section.title
            sectionHeader.subtitle.text = section.subtitle
            
            return sectionHeader
        }
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<ChampionSection, DataIdentifier>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.dataIdentifiers.shuffled(), toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    private func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with identifier: DataIdentifier, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to deque \(cellType)")
        }
        
        let champion = getChampion(for: identifier)
        let skin = getSkin(for: identifier, andChampion: champion)
        
        cell.configure(with: champion)
        cell.configure(with: skin)
        return cell
    }
    
    private func getChampion(for identifier: DataIdentifier) -> Champion {
        return championHash[identifier.championId] ?? championHash["Teemo"]!
    }
    
    private func getSkin(for identifier: DataIdentifier, andChampion champion: Champion) -> Skin {
        let offset = Int(champion.skins.first!.id)!
        let key = String(offset + (Int(identifier.skinId) ?? 0))
        return skinHash[key] ?? skinHash["17014"]!
    }
}

// MARK: - Collection View Layout

extension HomeViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            let section = self.sections[sectionIndex]
            
            switch section.type {
            case "mediumTable":
                return self.createMediumTableSection(using: section)
            case "tallTable":
                return self.createTallSection(using: section)
            default:
                return self.createFeaturedSection(using: section)
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createFeaturedSection(using section: ChampionSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return layoutSection
    }
    
    private func createTallSection(using section: ChampionSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.48), heightDimension: .absolute(TallCell.height))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        layoutSection.boundarySupplementaryItems = [createSectionHeader()]
        
        return layoutSection
    }
    
    func createMediumTableSection(using section: ChampionSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.46))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        layoutSection.boundarySupplementaryItems = [createSectionHeader()]
        
        return layoutSection
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(90))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct HomePreview: PreviewProvider {
    static var previews: some View {
        ForEach([ColorScheme.dark, ColorScheme.light], id: \.self) { scheme in
            PreviewView()
                .environment(\.colorScheme, scheme)
        }
    }
    
    struct PreviewView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<HomePreview.PreviewView>) -> HomeViewController {
            HomeViewController(preferredLanguage: "en")
        }
        
        func updateUIViewController(_ uiViewController: HomeViewController, context: UIViewControllerRepresentableContext<HomePreview.PreviewView>) {
            
        }
    }
}
