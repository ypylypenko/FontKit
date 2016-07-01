Pod::Spec.new do |s|
  s.name = 'FontKit'
  s.version = '0.0.1'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Icon font library for iOS written on swift. Currently supports Weather Icons'
  s.homepage = 'https://github.com/YevheniiPylypenko/FontKit'
  s.authors = { "Yevhenii Pylypenko" => "yevhenii.pylypenko@gmail.com" }
  s.source = { :git => 'https://github.com/YevheniiPylypenko/FontKit.git', :tag => s.version }
  
  s.ios.deployment_target = '8.0'
  s.source_files = 'FontKit/*.{swift}'
  s.resource_bundle = { 'FontKit' => 'FontKit/*.ttf' }
  s.frameworks = 'UIKit', 'CoreText'
  s.requires_arc = true
end
