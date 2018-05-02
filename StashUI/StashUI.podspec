#
# Be sure to run `pod lib lint StashCoach.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StashUI'
  s.version          = '0.1.0'
  s.summary          = 'VIPER Stash UI module'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/StashInvest/stash-invest-swift/StashCore'
  #s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Morgan Collino' => 'mcollino@stashinvest.com' }
  s.source           = { :git => 'https://github.com/StashInvest/stash-invest-swift/StashUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'UI/UI/**/*.{h,m,swift,xcdatamodeld}'
  
  s.resources = 'UI/UI/**/*.{xib,storyboard,png,jpg,pdf,xcassets,imageset}'
  #s.resource_bundles = {
  #  'StashUI' => ['UI/UI/**/*.{xib,storyboard}']
  #}

  s.public_header_files = 'UI/UI/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit'
end
