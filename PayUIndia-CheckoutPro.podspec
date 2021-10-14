Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutPro"
  s.version             = "3.0.0"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayUCheckoutPro-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The CheckoutPro SDK provides a complete Mobile Checkout solution for iOS Apps."
  s.description         = "The CheckoutPro experience allows you to integrate with the PayU PG with minimal integration effort and accept payments faster."

  s.source              = { :git => "https://github.com/payu-intrepos/PayUCheckoutPro-iOS.git",
                            :tag => "#{s.name}_#{s.version}"
                          }
  
  s.ios.deployment_target = "11.0"
  s.vendored_frameworks = 'PayUCheckoutProKit/PayUCheckoutProKit.xcframework'

  s.dependency            'PayUIndia-CheckoutProBase', '~> 3.0'
  s.dependency            'PayUIndia-AssetLibrary', '~> 2.4'
  s.dependency            'PayUIndia-PG-SDK', '~> 6.4'
  s.dependency            'PayUIndia-UPICore', '~> 5.0'
  s.dependency            'PayUIndia-Custom-Browser', '~> 7.1'
  s.dependency            'PayUIndia-PayUParams', '~> 2.1'
  s.dependency            'PayUIndia-CrashReporter', '~> 1.0'
  s.dependency            'PayUIndia-NetworkReachability', '~> 1.0'
  
end
