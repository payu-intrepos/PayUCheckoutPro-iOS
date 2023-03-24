# Supress warning messages.
original_verbose, $VERBOSE = $VERBOSE, nil

# Read file
vars_from_file = File.read("../Dependency/PayUParamsKit/GitHub/Version.txt")
eval(vars_from_file)

# Activate warning messages again.
$VERBOSE = original_verbose

Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutPro"
  s.version             = CHECKOUT_PRO_POD_VERSION
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
  
  CHECKOUT_PRO_PODSPEC_DEPENDENCIES.each do |dependency|
    dependency
  end

end
