# Install Compiler
brew install $COMPILER
echo "CC=$COMPILER" >> $GITHUB_ENV
COMPILER_NAME=${COMPILER%-*}
COMPILER_VERSION=${COMPILER#*-}
if [[ $COMPILER_NAME == "clang" ]]; then
  echo "CXX=$COMPILER_NAME++-$COMPILER_VERSION" >> $GITHUB_ENV
else
  echo "CXX=g++-$COMPILER_VERSION" >> $GITHUB_ENV
fi

# Install MKL
conda install -c intel mkl-static mkl-devel
PYTHONEXEC=`which python`
export MKLROOT=${PYTHONEXEC%/bin/python}
