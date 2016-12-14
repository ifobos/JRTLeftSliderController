Pod::Spec.new do |s|
  s.name         = "JRTLeftSliderController"
  s.version      = "0.0.8"
  s.summary      = "JRTLeftSliderController contains 2 sub viewControllers, one of which is shown from the left"
  s.homepage     = "https://github.com/ifobos/JRTLeftSliderController"
  s.license      = "MIT"
  s.author       = { "ifobos" => "juancarlos.garcia.alfaro@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/ifobos/JRTLeftSliderController.git", :tag => "0.0.8" }
  s.source_files = "JRTLeftSliderController/JRTLeftSliderController/PodFiles/*.{h,m}"
  s.resources    = "JRTLeftSliderController/JRTLeftSliderController/PodFiles/*.{png,bundle,xib,nib}"
  s.requires_arc = true
end
