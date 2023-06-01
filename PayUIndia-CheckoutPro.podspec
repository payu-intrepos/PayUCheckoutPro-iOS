require 'httparty'
require 'colorize'

# Supress warning messages.
original_verbose, $VERBOSE = $VERBOSE, nil

# Make the API request
url = "https://api.github.com/repos/payu-intrepos/payu-params-iOS/contents/Version.txt"
response = HTTParty.get(url)

# Check if the request was successful
if response.code == 200
  # Extract the content from the response
  content = Base64.decode64(response['content'])
  # Evaluate the content of the file
  eval(content)
else
  puts "\n==> Failed to retrieve Version.txt file. HTTP status code: #{response.code}".red
end

# Activate warning messages again.
$VERBOSE = original_verbose

#Pod

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
