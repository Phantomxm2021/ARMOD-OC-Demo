# ARMOD-OC-Demo
This project is used to demonstrate how AR MOD and Native app can be used together.


# How to use it?
1. Download the ARMOD-Framework.
2. Setup the `AppConfig.plist` file, and move it into the project directory.
    ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>dashboardConfig</key>
            <dict>
                <key>token</key>
                <string>YOUR_TOKEN</string>
                <key>dashboardGateway</key>
                <string>https://phantomsxr.com/api/v1/getarexperience</string>
            </dict>
        </dict>
        </plist>
    ```
3. Import ARMOD-Framework to `ARDemo/ARMOD SDK` directory.
4. Build

If you want to learn more, please go to the [documentation](https://docs.phantomsxr.com/native-app-embed/ios-embed-oc#import-armod-framework)
