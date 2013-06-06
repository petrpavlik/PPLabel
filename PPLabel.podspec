Pod::Spec.new do |s|
  s.name         = "PPLabel"
  s.version      = "0.5"
  s.summary      = "UIlabel subclass with ability to detect touches on individual letters"
  s.description  = <<-DESC
                    The advantage os this implementation is that it uses the ability of UILabel to display 
                    NSAttributedString on iOS 6.0+. There is no hacking of the drawRect: or drawText: 
                    method of UILabel. CoreText is used only to detect touched letters.
                   DESC
  s.homepage     = "http://petr-pavlik.squarespace.com/"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Petr Pavlik' => 'petrpavlik@me.com' }
  s.source       = { :git => "https://github.com/petrpavlik/PPLabel", :tag => s.version.to_s }
  s.platform     = :ios, '6.0'
  s.source_files = '*.{h,m}'
  s.framework    = "CoreText"
  s.requires_arc = true
end
