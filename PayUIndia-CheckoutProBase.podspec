# Supress warning messages.
original_verbose, $VERBOSE = $VERBOSE, nil

# Read file
vars_from_file = File.read("../Dependency/PayUParamsKit/GitHub/Version.txt")
eval(vars_from_file)

# Activate warning messages again.
$VERBOSE = original_verbose

Pod::Spec.new do |s|
  s.name                = "PayUIndia-CheckoutProBase"
  s.version             = CHECKOUT_PRO_BASE_POD_VERSION
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayUCheckoutPro-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The CheckoutProBase SDK provides basic classes and method used across other framewroks"
  s.description         = "The CheckoutProBase SDK provides basic classes and method used across other framewroks."

  s.source              = { :git => "https://github.com/payu-intrepos/PayUCheckoutPro-iOS.git",
                            :tag => "#{s.name}_#{s.version}"
                          }
  
  s.ios.deployment_target = "11.0"
  s.vendored_frameworks = 'PayUCheckoutProBaseKit/PayUCheckoutProBaseKit.xcframework'

  CHECKOUT_PRO_BASE_PODSPEC_DEPENDENCIES.each do |dependency|
    dependency
  end

end
