# Update
sudo apt update
# sudo apt upgrade

# Install Compiler
sudo apt install $COMPILER
$COMPILER -v
echo "CC=$COMPILER" >>$GITHUB_ENV
COMPILER_NAME=${COMPILER%-*}
COMPILER_VERSION=${COMPILER#*-}
if [[ $COMPILER_NAME == "clang" ]]; then
  echo "CXX=$COMPILER_NAME++-$COMPILER_VERSION" >>$GITHUB_ENV
else
  echo "CXX=g++-$COMPILER_VERSION" >>$GITHUB_ENV
fi

# Install MKL
if [[ "$CACHE_HIT" == 'true' ]]; then
  sudo cp --verbose --force --recursive ~/oneapi/* /
else
  cd /tmp
  wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
  sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
  rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
  echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
  sudo apt update

  oneapi_packages=(
    "intel-oneapi-common-licensing"
    # "intel-oneapi-common-vars"
    # "intel-oneapi-compiler-cpp-eclipse-cfg"
    "intel-oneapi-compiler-dpcpp-cpp"
    "intel-oneapi-compiler-dpcpp-cpp-common"
    "intel-oneapi-compiler-dpcpp-cpp-runtime"
    # "intel-oneapi-compiler-dpcpp-eclipse-cfg"
    "intel-oneapi-compiler-shared"
    "intel-oneapi-compiler-shared-common"
    "intel-oneapi-compiler-shared-runtime"
    # "intel-oneapi-condaindex"
    "intel-oneapi-dev-utilities"
    # "intel-oneapi-dev-utilities-eclipse-cfg"
    "intel-oneapi-dpcpp-cpp"
    # "intel-oneapi-dpcpp-cpp-debugger"
    # "intel-oneapi-dpcpp-cpp-debugger-eclipse-cfg"
    "intel-oneapi-libdpstd-devel"
    "intel-oneapi-mkl"
    "intel-oneapi-mkl-common"
    "intel-oneapi-mkl-common-devel"
    "intel-oneapi-mkl-devel"
    "intel-oneapi-openmp"
    "intel-oneapi-openmp-common"
    "intel-oneapi-tbb"
    "intel-oneapi-tbb-common"
    "intel-oneapi-tbb-common-devel"
    "intel-oneapi-tbb-devel"
  )
  mkdir -p ~/oneapi
  for pkg in ${oneapi_packages[@]}; do
    sudo apt-get install ${pkg}-$ONEAPI_VERSION
    sudo dpkg -L ${pkg}-$ONEAPI_VERSION | while IFS= read -r f; do if test -f $f; then echo $f; fi; done | xargs cp --parents --target-directory ~/oneapi/
  done

  # echo "NEW KEYS SHOULD BE:"
  # apt-cache policy intel-oneapi-mkl | grep -oP '(?<=Candidate:\s)(.+)'
  # apt-cache policy intel-oneapi-mkl-devel | grep -oP '(?<=Candidate:\s)(.+)'
  # apt-cache policy intel-oneapi-openmp | grep -oP '(?<=Candidate:\s)(.+)'
  # apt-cache policy intel-oneapi-compiler-dpcpp-cpp | grep -oP '(?<=Candidate:\s)(.+)'

  echo "dpkg -L output:"
  sudo dpkg -L intel-oneapi-mkl-$ONEAPI_VERSION

  # mkdir -p ~/mkl
  # sudo dpkg -L intel-oneapi-mkl | while IFS= read -r f; do if test -f $f; then echo $f; fi; done | xargs cp --parents --target-directory ~/mkl/
  # sudo dpkg -L intel-oneapi-mkl-devel | while IFS= read -r f; do if test -f $f; then echo $f; fi; done | xargs cp --parents --target-directory ~/mkl/
  # sudo dpkg -L intel-oneapi-openmp | while IFS= read -r f; do if test -f $f; then echo $f; fi; done | xargs cp --parents --target-directory ~/mkl/
  # sudo dpkg -L intel-oneapi-compiler-dpcpp-cpp | while IFS= read -r f; do if test -f $f; then echo $f; fi; done | xargs cp --parents --target-directory ~/mkl/
fi

source /opt/intel/oneapi/mkl/latest/env/vars.sh
echo "MKLROOT=$MKLROOT" >>$GITHUB_ENV
echo "INTEL=/opt/intel/oneapi" >>$GITHUB_ENV

find /opt/intel -name "libiomp*"
