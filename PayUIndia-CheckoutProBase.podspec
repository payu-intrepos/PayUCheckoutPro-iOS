Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutProBase"
  s.version             = "8.10.0"

  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayUCheckoutPro-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The CheckoutProBase SDK provides basic classes and method used across other framewroks"
  s.description         = "The CheckoutProBase SDK provides basic classes and method used across other framewroks."

  s.source              = { :git => "https://github.com/payu-intrepos/PayUCheckoutPro-iOS.git",
                            :tag => "#{s.version}"
                          }
  
  s.ios.deployment_target = "13.0"
  s.vendored_frameworks = 'PayUCheckoutPro/PayUCheckoutProBaseKit.xcframework'

  s.dependency            'PayUIndia-PayUParams', '~> 6.8'
  s.dependency            'PayUIndia-PG-SDK', '~> 11.9'

end
