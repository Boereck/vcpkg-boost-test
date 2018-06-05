# Pass "static" as parameter to script to use static binding

# Get vcpkg
if(Test-Path .\vcpkg) {
    cd vcpkg
    git pull
    cd ..
} else {
    git clone https://github.com/Microsoft/vcpkg.git
    cd vcpkg
    .\bootstrap-vcpkg.bat
    cd ..
}

$triplet = "x64-windows"
$firstArg = $args[0]
if($firstArg -and $firstArg.Equals("static")) {
    $triplet = "$triplet-static"
}

# install boost dependency
.\vcpkg\vcpkg install boost-optional --triplet $triplet

$rootdir = $pwd
mkdir $triplet -ErrorAction Ignore
cd $triplet

cmake .. -G "Visual Studio 15 2017 Win64" "-DVCPKG_TARGET_TRIPLET=$triplet" "-DCMAKE_TOOLCHAIN_FILE=$rootdir\vcpkg\scripts\buildsystems\vcpkg.cmake"

cd ..