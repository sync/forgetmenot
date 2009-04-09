#!/bin/sh
~/Scripts/clang/latest/scan-build --status-bugs -warn-objc-missing-dealloc xcodebuild -sdk iphonesimulator3.0 -configuration Debug