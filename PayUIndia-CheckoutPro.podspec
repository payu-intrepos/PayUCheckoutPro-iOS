Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutPro"
  s.version             = "2.4.1"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayUCheckoutPro-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The CheckoutPro SDK provides a complete Mobile Checkout solution for iOS Apps."
  s.description         = "The CheckoutPro experience allows you to integrate with the PayU PG with minimal integration effort and accept payments faster."

  s.source              = { :git => "https://github.com/payu-intrepos/PayUCheckoutPro-iOS.git",
                            :tag => "#{s.name}_#{s.version}"
                          }
  
  s.ios.deployment_target = "10.0"
  s.vendored_frameworks = 'PayUCheckoutProKit/PayUCheckoutProKit.framework'

  s.dependency            'PayUIndia-CheckoutProBase', '~> 2.4'
  s.dependency            'PayUIndia-AssetLibrary', '~> 2.2'
  s.dependency            'PayUIndia-PG-SDK', '~> 6.2'
  s.dependency            'PayUIndia-UPICore', '~> 4.1'
  s.dependency            'PayUIndia-Custom-Browser', '~> 7.0'
  s.dependency            'PayUIndia-PayUParams', '~> 2.0'
  
end
