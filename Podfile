platform :ios, '12.0'
source 'https://github.com/CocoaPods/Specs.git'

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
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
  end
 end
end