//
//  OnboardingViewController.swift
//  bankley
//
//  Created by aldinugroho on 03/11/22.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject  {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    var currentVC: UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else { return }
            print(index)
            nextBtn.isHidden = index == pages.count - 1
            backBtn.isHidden = index == 0
            doneBtn.isHidden = !(index == pages.count - 1)
        }
    }
    
    let closeBtn = UIButton(type: .system)
    let nextBtn = UIButton(type: .system)
    let doneBtn = UIButton(type: .system)
    let backBtn = UIButton(type: .system)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let page1 = OnboardingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989.")
        let page2 = OnboardingViewController(heroImageName: "world", titleText: "Move your money around the world quickly and securely.")
        let page3 = OnboardingViewController(heroImageName: "thumbs", titleText: "Learn more at www.bankley.com.")
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        currentVC = pages.first!
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
}

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        self.currentVC = pages[index-1]
        return pages[index-1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        self.currentVC = pages[index+1]
        return pages[index+1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

extension OnboardingContainerViewController {
    private func setup() {
        view.backgroundColor = .systemPurple
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor)
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false)
        currentVC = pages.first!
    }
    
    private func style() {
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.setTitle("Close", for: [])
        closeBtn.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        view.addSubview(closeBtn)
        
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.setTitle("Next", for: [])
        nextBtn.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        view.addSubview(nextBtn)
        
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        doneBtn.setTitle("Done", for: [])
        doneBtn.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
        view.addSubview(doneBtn)
        
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.setTitle("Back", for: [])
        backBtn.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
        view.addSubview(backBtn)
    }
    
    private func layout() {
        // CLOSE BTN
        NSLayoutConstraint.activate([
            closeBtn.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeBtn.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
        
        // NEXT BTN
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextBtn.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: nextBtn.bottomAnchor, multiplier: 4)
        ])
        
        // DONE BTN
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneBtn.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: doneBtn.bottomAnchor, multiplier: 4)
        ])

        //  BACK BTN
        NSLayoutConstraint.activate([
            backBtn.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow:  backBtn.bottomAnchor, multiplier: 4)
        ])
    }
}


// MARK: - Actions
extension OnboardingContainerViewController {
    @objc func closeTapped(_ sender: UIButton) {
        // TODO
        delegate?.didFinishOnboarding()
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        // TODO
        guard let nextVC = getNextViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true)
    }
    
    @objc func doneTapped(_ sender: UIButton) {
        // TODO
        delegate?.didFinishOnboarding()
    }
    
    @objc func backTapped(_ sender: UIButton) {
        // TODO
        guard let previousVC = getPreviousViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true)
    }
}
