Pod::Spec.new do |s|
  s.name             = 'TPShareKit'
  s.version          = '0.1.0'
  s.summary          = 'TPShareKit is a shared component library.'

  s.description      = <<-DESC
TPShareKit 是一个分享组件的库
                       DESC

  s.homepage         = 'https://github.com/Topredator/TPShareKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Topredator' => 'luyanggold@163.com' }
  s.source           = { :git => 'https://github.com/Topredator/TPShareKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.static_framework = true
  s.source_files = 'TPShareKit/Classes/TPShareKit.h'

  s.subspec 'Base' do |ss|
    ss.source_files = 'TPShareKit/Classes/Base/**/*'
  end

  s.subspec 'ShareUI' do |ss|
    ss.source_files = 'TPShareKit/Classes/ShareUI/**/*'
    ss.dependency 'TPShareKit/Base'
    ss.dependency 'Masonry', '~> 1.1.0'
    ss.dependency 'pop'
    ss.resources = 'TPShareKit/Assets/**/*'
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
