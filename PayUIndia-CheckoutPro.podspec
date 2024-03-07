Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutPro"
  s.version             = "7.5.0"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayUCheckoutPro-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The CheckoutPro SDK provides a complete Mobile Checkout solution for iOS Apps."
  s.description         = "The CheckoutPro experience allows you to integrate with the PayU PG with minimal integration effort and accept payments faster."

  s.source              = { :git => "https://github.com/payu-intrepos/PayUCheckoutPro-iOS.git",
                            :tag => "#{s.version}"
                          }
  
  s.ios.deployment_target = "12.0"
  s.vendored_frameworks = 'PayUCheckoutPro/PayUCheckoutProKit.xcframework'

  s.dependency            'PayUIndia-CheckoutProBase', '~> 7.5'
  s.dependency            'PayUIndia-AssetLibrary', '~> 3.3'
  s.dependency            'PayUIndia-PG-SDK', '~> 10.4'
  s.dependency            'PayUIndia-UPICore', '~> 9.2'
  s.dependency            'PayUIndia-Custom-Browser', '~> 10.2'
  s.dependency            'PayUIndia-PayUParams', '~> 5.3'
  s.dependency            'PayUIndia-CrashReporter', '~> 3.0'
  s.dependency            'PayUIndia-NetworkReachability', '~> 1.0'
  s.dependency            'PayUIndia-NativeOtpAssist', '~> 3.3'
  s.dependency            'PayUIndia-CardScanner', '~> 1.0'
  s.dependency            'PayUIndia-Analytics', '3.0'
  s.dependency            'PayUIndia-CommonUI', '~>1.1'

end
