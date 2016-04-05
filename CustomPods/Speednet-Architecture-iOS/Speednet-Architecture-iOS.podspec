#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "Speednet-Architecture-iOS"
  s.version          = "0.1.171"
  s.summary          = "Speednet iOS Architecture Library"
  s.description      = "Speednet iOS Architecture Library Pod"
  s.homepage         = "http://www.speednet.pl"
  #s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "" => "gsagadyn@speednet.pl" }
  s.source           = { :git => "https://scm.speednet.pl/scm/git/Speednet-Architecture-iOS" }
  #s.social_media_url = 'https://twitter.com/EXAMPLE'

  s.platform     = :ios, '7.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true
  
  s.source_files = 'ArchitectureSampleApp/Architecture/**/*.{h,m}'
  #s.resources = 'ArchitectureSampleApp/Architecture/**/*.png'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/*.h'
  
  s.dependency 'CommonLib-iOS'
end
