Pod::Spec.new do |s|
  s.name         = "NDLog_Swift"
  s.version      = "0.0.4"
  s.summary      = "A log system."
  s.description  = <<-DESC
  NDLog_Swift is a small and lightweight framework that help log.
                   DESC
  s.homepage     = "https://github.com/hiep-nd/nd-log-swift.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Nguyen Duc Hiep" => "hiep.nd@gmail.com" }
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.swift_versions = ['4.0', '5.1', '5.2']
  #s.source        = { :http => 'file:' + URI.escape(__dir__) + '/' }
  s.source       = { :git => "https://github.com/hiep-nd/nd-log-swift.git", :tag => "Pod-#{s.version}" }
  
  s.source_files  = "NDLog_Swift/**/*.{h,m,mm,swift}"
  s.dependency 'NDLog', '~> 0.0.4'
end
