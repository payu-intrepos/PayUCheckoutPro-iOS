Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutPro"
  s.version             = "8.4.0"
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

  s.dependency            'PayUIndia-CheckoutProBase', '~> 8.4'
  s.dependency            'PayUIndia-AssetLibrary', '~> 4.0'
  s.dependency            'PayUIndia-PG-SDK', '~> 11.3'
  s.dependency            'PayUIndia-UPICore', '~> 10.3'
  s.dependency            'PayUIndia-Custom-Browser', '~> 11.1'
  s.dependency            'PayUIndia-PayUParams', '~>6.3'
  s.dependency            'PayUIndia-CrashReporter', '~> 4.0'
  s.dependency            'PayUIndia-NetworkReachability', '~> 2.0'
  s.dependency            'PayUIndia-NativeOtpAssist', '~> 4.1'
  s.dependency            'PayUIndia-CardScanner', '~> 2.0'
  s.dependency            'PayUIndia-CommonUI', '~>2.1'

end
