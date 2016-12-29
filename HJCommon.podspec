
Pod::Spec.new do |s|
s.name = 'HJCommon'
s.version = '0.0.2'
s.license = 'MIT'
s.summary = 'An common unit on iOS.'
s.homepage = 'https://github.com/tianyahaijiaoHYX520/test_cocoapods'
s.authors = { '肖密' => '' }
s.source = { :git => 'https://github.com/tianyahaijiaoHYX520/test_cocoapods.git', :tag => '0.0.2' }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'HJCommon/*.{h,m}'
s.dependency 'AFNetworking','3.1.0'
end
