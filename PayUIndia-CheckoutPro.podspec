Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutPro"
  s.version             = "9.1.0"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayUCheckoutPro-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The CheckoutPro SDK provides a complete Mobile Checkout solution for iOS Apps."
  s.description         = "The CheckoutPro experience allows you to integrate with the PayU PG with minimal integration effort and accept payments faster."

  s.source              = { :git => "https://github.com/payu-intrepos/PayUCheckoutPro-iOS.git",
                            :tag => "#{s.version}"
                          }
  
  s.ios.deployment_target = "13.0"
  s.vendored_frameworks = 'PayUCheckoutPro/PayUCheckoutProKit.xcframework'

  s.dependency            'PayUIndia-CheckoutProBase', '~> 9.0'
  s.dependency            'PayUIndia-AssetLibrary', '~> 4.0'
  s.dependency            'PayUIndia-PG-SDK', '~> 12.0'
  s.dependency            'PayUIndia-UPICore', '~> 11.0'
  s.dependency            'PayUIndia-Custom-Browser', '~> 11.3'
  s.dependency            'PayUIndia-PayUParams', '~> 7.0'
  s.dependency            'PayUIndia-CrashReporter', '~> 4.0'
  s.dependency            'PayUIndia-NetworkReachability', '~> 2.0'
  s.dependency            'PayUIndia-NativeOtpAssist', '~> 5.0'
  s.dependency            'PayUIndia-CardScanner', '~> 2.1'
  s.dependency            'PayUIndia-CommonUI', '~>2.3'

end
