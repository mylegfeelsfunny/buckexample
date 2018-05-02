apple_resource(
    name = 'AppResources',
    dirs = ['BuckExample'],
    files = glob(['BuckExample/Base.lproj/*.storyboard']),
)

apple_asset_catalog(
  name = 'AppAsset',
  dirs = ['BuckExample/Assets.xcassets'],
)

apple_binary(
    name = 'BuckExample',
    srcs = glob([
        'BuckExample/*.swift',
      ]),
    deps = [':AppResources', ':AppAsset', '//StashUI/UI:StashUI'],
    frameworks = [
        '$SDKROOT/System/Library/Frameworks/Foundation.framework',
        '$SDKROOT/System/Library/Frameworks/UIKit.framework',
    ],
)

apple_bundle(
    name = 'BuckExampleApp',
    binary = ':BuckExample',
    extension = 'app',
    info_plist = './BuckExample/Info.plist',
    info_plist_substitutions = {
        'PRODUCT_BUNDLE_IDENTIFIER': 'com.stash.stashinvest.BuckHalp',
        'CURRENT_PROJECT_VERSION': '1',
        'DEVELOPMENT_LANGUAGE': 'United States',
    },
)

apple_package(
  name = 'BuckExampleAppPackage',
  bundle = ':BuckExampleApp',
)

apple_test(
    name = 'BuckExampleTests',
    srcs = glob(['./BuckExampleTests/*.swift']),
    info_plist = './BuckExampleTests/Info.plist',
    linker_flags = ['-undefined', 'dynamic_lookup'],
    # destination_specifier = {'platform': 'iOS Simulator', 'OS': '11.3', 'name': 'iPhone 5s'},
        info_plist_substitutions = {
            'PRODUCT_BUNDLE_IDENTIFIER': 'com.stash.stashinvest.BuckHalp',
            'CURRENT_PROJECT_VERSION': '1',
            'DEVELOPMENT_LANGUAGE': 'United States',
        },
        deps = [':BuckExample'] ,
        frameworks = [
        '$SDKROOT/System/Library/Frameworks/Foundation.framework',
        '$PLATFORM_DIR/Developer/Library/Frameworks/XCTest.framework',
        '$SDKROOT/System/Library/Frameworks/UIKit.framework',
    ],
)
