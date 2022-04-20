TOP_DIR=$(cd $(dirname $0);pwd)
echo $TOP_DIR

rm -rf $TOP_DIR/build

if [ ! -d "$TOP_DIR/build" ]; then
  mkdir -p $TOP_DIR/build
fi
# cross compile platforms/readme.txt
# -DCV_ENABLE_INTRINSICS=OFF -DENABLE_NEON=OFF for mac arm64 error:
# /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.0.0/include/mmintrin.h:33:5: error: use of undeclared identifier '__builtin_ia32_emms'; did you mean '__builtin_isless'?
# quit for another error:
# Undefined symbols for architecture arm64: "_png_do_expand_palette_rgba8_neon", referenced from: _png_do_read_transformations in liblibpng.a(pngrtran.o)
cmake -G "Xcode" -DBUILD_SHARED_LIBS=OFF -DBUILD_WITH_STATIC_CRT=OFF -DBUILD_PROTOBUF=OFF -DWITH_WEBP=OFF -DWITH_IPP=OFF -DBUILD_ITT=OFF -DCV_ENABLE_INTRINSICS=OFF -DENABLE_NEON=OFF -DBUILD_OPENJPEG=OFF -DWITH_OPENEXR=OFF -DCMAKE_INSTALL_PREFIX=$TOP_DIR/bin -B$TOP_DIR/build -H$TOP_DIR
cd $TOP_DIR/build
xcodebuild -arch x86-64 ONLY_ACTIVE_ARCH=NO -configuration Release -target install -sdk macosx build