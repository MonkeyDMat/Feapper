#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "Feapper"
  s.version          = "1.0"
  s.summary          = "Feapper the feature flipper"
  s.description      = <<-DESC
                        Feapper is a frameworks to manage feature flipping
						Check the README for more informations
                       DESC
  s.homepage         = "https://github.com/MonkeyDMat/Feapper"

  s.license          = 'BSD'
  s.author           = { "Mathieu Lecoupeur" => "mathieulecoupeur@gmail.com" }
  s.requires_arc = true
  s.ios.deployment_target     = '9.0'
  s.platforms = { :ios => "9.0" }
  
  s.source           = { :git => 'https://github.com/MonkeyDMat/Feapper.git',
                	 	 :tag => "#{s.version}"}
  s.source_files     = [
    'sources/Feapper/Feapper/**/*.{h,swift}'
  ]
end
