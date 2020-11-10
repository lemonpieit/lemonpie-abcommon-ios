#
# Be sure to run `pod lib lint ABcommon.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ABcommon'
  s.version          = '1.1.0'
  s.summary          = 'ABenergie iOS library.'
  
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'A library of extensions used for iOS mobile development in ABenergie.'
                       DESC

  s.homepage         = 'https://abenergie.visualstudio.com/ABcommon.ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luigi Aiello' => 'luigi.aiello@abenergie.it', 'Francesco Leoni' => 'francesco.leoni@abenergie.it' }
  s.source           = { :git => 'https://abenergie.visualstudio.com/_git/ABcommon.ios', :tag => 'v1.0.0' }
  s.social_media_url = 'https://github.com/fraleo2406'
  s.social_media_url = 'https://github.com/mo3bius'
  
  s.source_files = 'Source/**/*.swift'
  s.swift_version = '5.2'
  s.platform = :ios, '11.0'
  
  s.subspec 'Extensions' do |extensions|
    extensions.source_files = 'Source/Extensions/*.swift'
  end
  
  s.subspec 'Managers' do |managers|
    managers.source_files = 'Source/Managers/*.swift'
  end
  
  s.subspec 'Protocols' do |protocols|
    extensions.source_files = 'Source/Protocols/*.swift'
  end

  s.subspec 'Helpers' do |helpers|
    extensions.source_files = 'Source/Helpers/*.swift'
  end

  # s.subspec 'MyLibrary' do |libOne|
  #    libOne.source_files  = 'Headers", "Headers/**/*.h'
  #    libOne.exclude_files = 'Headers/Exclude'
  #    libOne.resources = 'SharedAssets/*'
  #
  #    libOne.libraries = 'z','sqlite3' #Zlib for gzip, sqlite3 for event store
  #    libOne.vendored_library = 'libMyLibrary_A.a'
  # end
  
  # s.source_files = 'ABcommon/Classes/**/*'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # s.resource_bundles = {
  #   'ABcommon' => ['ABcommon/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
