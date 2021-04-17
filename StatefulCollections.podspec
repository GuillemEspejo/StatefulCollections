Pod::Spec.new do |spec|
  spec.name         = "StatefulCollections"
  spec.version      = "1.0.2"
  spec.summary      = "Simple stateful collection views for iOS in Swift."
  spec.description  = <<-DESC
                    StatefulCollections is a small and lightweight Swift framework that allows to create UITableviews and UICollectionViews that support empty, loading and error states as easy as possible.
                   DESC
  spec.homepage     = "https://github.com"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Guillem Espejo" => "g.espejogarcia@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/GuillemEspejo/StatefulCollections.git", :tag => "#{spec.version}" }
  spec.source_files = "Sources/StatefulCollections/*.{swift}"
  spec.swift_version = "5.0"
end
