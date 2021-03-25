Pod::Spec.new do |spec|
  spec.name         = "XSHoverButton"  #项目名称:导入时需要
  spec.version      = "1.0.1"  #版本号
  spec.summary      = "悬浮按钮" #简介
 
  # 描述
  spec.description  = <<-DESC
         一个简单的悬浮按钮
  DESC
                   
  # 项目主页， 不是 git地址
  spec.homepage = "https://github.com/RedHeartA/XSHoverButton"
 
  # 开源协议
  spec.license = { :type => "MIT", :file => "LICENSE" }
 
  # 作者信息
  spec.author = { "RedHeartA" => "1391122028@qq.com" }
 
  # 支持的平台和版本号
  spec.platform = :ios, "9.0"
  # 支持多个平台
  spec.ios.deployment_target = "9.0"
  # git地址 以及tag值
  spec.source = { :git => "https://github.com/RedHeartA/XSHoverButton.git", :tag => s.version }
  # 文件的路径
  spec.source_files = "XSHoverButton/HoverButton/*.{h,m}"
  
  # pod库使用的系统库
  spec.framework  = "Foundation","UIKit"

end
