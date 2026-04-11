Pod::Spec.new do |s|
  s.name             = 'adaptive_core'
  s.version          = '1.0.12'
  s.summary          = 'Flutter iOS plugin for the Adaptive Core SDK.'
  s.description      = 'Provides SDK initialization, user session management, and offline queue for the Adaptive e-learning platform.'
  s.homepage         = 'https://github.com/AdaptiveSDK/AdaptiveiOSSDK'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'AlAdwaa' => 'dev_team@aladwaa.org' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AdaptiveCore', '~> 1.0.12'
  s.platform         = :ios, '13.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version    = '5.9'
end
