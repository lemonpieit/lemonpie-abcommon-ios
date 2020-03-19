#
# Be sure to run `pod lib lint ABcommon.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ABcommon'
  s.version          = '0.1.0'
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
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luigi Aiello' => 'luigi.aiello@abenergie.it', 'Francesco Leoni' => 'francesco.leoni@abenergie.it' }
  s.source           = { :git => 'https://abenergie.visualstudio.com/ABcommon.ios', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/fraleo2406'
  s.social_media_url = 'https://github.com/mo3bius'
  
  s.ios.deployment_target = '13.0'

#  s.source_files = 'ABcommon/Classes/**/*'
    s.source_files = 'Source/**/*.swift'
    s.swift_version = '5.2'
    s.platforms = {
        "ios": "13.0"
    }

  # s.resource_bundles = {
  #   'ABcommon' => ['ABcommon/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end