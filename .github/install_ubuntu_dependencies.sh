# Update
sudo apt update
# sudo apt upgrade

# Install Compiler
sudo apt install $COMPILER
COMPILER_NAME=${COMPILER%-*}
COMPILER_VERSION=${COMPILER%*-}
if [[ $COMPILER_NAME == "clang" ]]; then
  echo "CC=$COMPILER" >> $GITHUB_ENV
  echo "CXX=$COMPILER_NAME++-$COMPILER_VERSION" >> $GITHUB_ENV
else
  echo "CC=gcc-$COMPILER_VERSION" >> $GITHUB_ENV
  echo "CXX=g++-$COMPILER_VERSION" >> $GITHUB_ENV
fi

# Install MKL
cd /tmp
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
sudo apt update
sudo apt install intel-oneapi-mkl intel-oneapi-mkl-devel
source /opt/intel/oneapi/mkl/latest/env/vars.sh
echo "MKLROOT=$MKLROOT" >> $GITHUB_ENV
echo "INTEL=$INTEL" >> $GITHUB_ENV

echo $MKLROOT
ls $MKLROOT/lib/intel64
echo "*************"
ls /opt/intel/oneapi
echo "*************"
ls /usr/bin/gcc*
ls /usr/bin/g++*
