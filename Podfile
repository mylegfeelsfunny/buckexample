# Podfile

inhibit_all_warnings!
use_frameworks!

pre_install do |installer|
   Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
end


def shared_stash
    pod 'StashUI', :path => "StashUI"

end

abstract_target 'Dependencies' do
    platform :ios, '9.0'

    shared_stash

    target 'BuckExample'
end


post_install do |installer|

    installer.pods_project.targets.each do |target|
        puts "#{target.name}"
        target.build_configurations.each do |config|
            if config.name == 'Debug'
                config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
            end
        end
    end
    puts("Update debug pod settings to speed up build time")
    Dir.glob(File.join("Pods", "**", "Pods*{debug,Private}.xcconfig")).each do |file|
        File.open(file, 'a') { |f| f.puts "\nDEBUG_INFORMATION_FORMAT = dwarf" }
    end
    
end
