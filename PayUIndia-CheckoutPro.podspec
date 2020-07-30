Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutPro"
  s.version             = "1.0.0-beta1"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayUCheckoutPro-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The CheckoutPro SDK provides a complete Mobile Checkout solution for iOS Apps."
  s.description         = "The CheckoutPro experience allows you to integrate with the PayU PG with minimal integration effort and accept payments faster."

  s.source              = { :git => "https://github.com/payu-intrepos/PayUCheckoutPro-iOS.git",
                            :tag => "#{s.name}_#{s.version}"
                          }
  
  s.ios.deployment_target = "10.0"
  s.vendored_frameworks = 'PayUCheckoutPro/PayUCheckoutPro.framework'

  s.dependency            'PayUIndia-Networking', '1.0.1'
  s.dependency            'PayUIndia-Custom-Browser', '6.0'
  s.dependency            'Socket.IO-Client-Swift', '15.1.0'
  s.dependency            'PayUIndia-PG-SDK', '4.0.0'
  s.dependency            'PayUIndia-AssetLibrary', '1.0.0'
  s.dependency            'PayUIndia-CheckoutProBase', '1.0.0-beta1'

end
