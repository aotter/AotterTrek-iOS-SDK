platform :ios, '15.0'
source 'https://cdn.cocoapods.org/'

target 'AotterTrekSample' do
	pod 'AFNetworking'
	pod 'MBProgressHUD'
	pod 'SDWebImage'
  pod 'TrekSDKAdMobMediationObjc'
  #pod 'AotterTrekUID2SDK'
  pod 'Masonry'
  pod 'MJRefresh'

  # pod 'GoogleAds-IMA-iOS-SDK','3.13.0' # '3.12.1'  # '3.11.2'
  # pod 'GoogleAds-IMA-iOS-SDK', '3.9.0'
  
  
  # VAST Video learn more click action error
  #         iOS12/iOS13
  # 3.11.2 -> ?
  # 3.11.1 -> replay
  # 3.10.1 -> video request timeout
  # 3.9.2  -> v
  # 3.9.1  -> v
  # 3.9.0  -> v
  
  #pod 'mopub-ios-sdk', '~> 5.18.0'
  
  
end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
  end
 end

 # 新版 Xcode SDK 把 netinet6/in6.h 列為 module private header，直接 import 會編譯失敗；
 # netinet/in.h 已包含它，移除即可（改 Pods/ 會被 pod install 洗掉，所以在這裡 patch）
 Dir.glob("#{installer.sandbox.root}/AFNetworking/**/*.{h,m}").each do |file|
  src = File.read(file)
  patched = src.gsub(/^#import <netinet6\/in6\.h>\n/, '')
  if patched != src
   File.chmod(0644, file) # CocoaPods 會把 pod 原始檔設為唯讀
   File.write(file, patched)
  end
 end
end