Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutProBase"
  s.version             = "2.5.0"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayUCheckoutPro-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The CheckoutProBase SDK provides basic classes and method used across other framewroks"
  s.description         = "The CheckoutProBase SDK provides basic classes and method used across other framewroks."

  s.source              = { :git => "https://github.com/payu-intrepos/PayUCheckoutPro-iOS.git",
                            :tag => "#{s.name}_#{s.version}"
                          }
  
  s.ios.deployment_target = "10.0"
  s.vendored_frameworks = 'PayUCheckoutProBaseKit/PayUCheckoutProBaseKit.xcframework'

  s.dependency            'PayUIndia-PayUParams', '~> 2.0'

end
