Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutPro"
  s.version             = "5.2.0"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayUCheckoutPro-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The CheckoutPro SDK provides a complete Mobile Checkout solution for iOS Apps."
  s.description         = "The CheckoutPro experience allows you to integrate with the PayU PG with minimal integration effort and accept payments faster."

  s.source              = { :git => "https://github.com/payu-intrepos/PayUCheckoutPro-iOS.git",
                            :tag => "#{s.version}"
                          }
  
  s.ios.deployment_target = "11.0"
  s.vendored_frameworks = 'PayUCheckoutProKit/PayUCheckoutProKit.xcframework'

  s.dependency            'PayUIndia-CheckoutProBase', '~> 5.2'
  s.dependency            'PayUIndia-AssetLibrary', '~> 3.1'
  s.dependency            'PayUIndia-PG-SDK', '~> 8.6'
  s.dependency            'PayUIndia-UPICore', '~> 6.3'
  s.dependency            'PayUIndia-Custom-Browser', '~> 9.1'
  s.dependency            'PayUIndia-PayUParams', '~> 4.2'
  s.dependency            'PayUIndia-CrashReporter', '~> 2.1'
  s.dependency            'PayUIndia-NetworkReachability', '~> 1.0'
  s.dependency            'PayUIndia-NativeOtpAssist', '~> 2.1'
  s.dependency            'PayUIndia-CardScanner', '~> 1.0'
  s.dependency            'PayUIndia-Analytics', '3.0'

end
