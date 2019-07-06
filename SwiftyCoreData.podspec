
Pod::Spec.new do |s|

  s.name         = "RxSwiftyCoreData"
  s.version      = "0.1.0"
  s.summary      = "ReactiveX implementation of SwiftyCoreData framework"
  s.description  = "SwiftyCoreData is a lightweight libliary written in Swift. General purpose is to make using CoreData easier without unnecessary template code"
  
  s.swift_version = "4.2"

  s.homepage     = "https://github.com/wojtowiczm"

  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author       = { "Michał Wójtowicz" => "wojtowiczmichal97@gmail.com" }
  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/wojtowiczm/RxSwiftyCoreData.git", :tag => "#{s.version}" }


  s.source_files  = "RxSwiftyCoreData/**/*.swift"
  s.dependency = 'RxSwift'
  s.dependency = 'RxCocoa'
  s.dependency = 'SwiftyCoreData', :git => "https://github.com/wojtowiczm/SwiftyCoreData.git"

end
