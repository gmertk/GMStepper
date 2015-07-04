Pod::Spec.new do |s|
  s.name             = "GMStepper"
  s.version          = "0.1.1"
  s.summary          = "A stepper with a sliding label in the middle."
  s.homepage         = "https://github.com/gmertk/GMStepper"
  s.screenshots      = "https://dl.dropboxusercontent.com/u/4397140/pod-screenshots/screenshot_1.png"
  s.license          = 'MIT'
  s.author           = { "Gunay Mert Karadogan" => "mertkaradogan@gmail.com" }
  s.source           = { :git => "https://github.com/gmertk/GMStepper.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gunaymertk'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'GMStepper/*.swift'
end
