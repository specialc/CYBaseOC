#
# Be sure to run `pod lib lint CYBaseOC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CYBaseOC'
  s.version          = '0.1.14'
  s.summary          = '基础类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/specialc/CYBaseOC.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '787984594@qq.com' => '2248895786@qq.com' }
  s.source           = { :git => 'https://github.com/specialc/CYBaseOC.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CYBaseOC/Classes/**/*'
  
  s.resource_bundles = {
      'CYBaseOC' => ['CYBaseOC/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'JSONModel', '~> 1.8.0'
  s.dependency 'Masonry'
  s.dependency 'MJRefresh'
  s.dependency 'SDWebImage', '~> 5.0'
  s.dependency 'YYImage'
  s.dependency 'YYText', '~> 1.0.7'
  s.dependency 'AFNetworking', '~> 3.2.1'
  s.dependency 'HMSegmentedControl', '~> 1.5.5'
  s.dependency 'NJKWebViewProgress', '~> 0.2.3'
  s.dependency 'YBImageBrowser', '~> 2.2.0'
  s.dependency 'SVGAPlayer', '~> 2.1.3'
  s.dependency 'GCDWebServer', '~> 3.4.2'
end
