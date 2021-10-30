#include <pybind11/pybind11.h>

#include <Eigen/PardisoSupport>
#include <Eigen/Sparse>
#include <iostream>

// Namespace Stuff
using namespace std;
namespace py = pybind11;

// Type Definitions
using M3 = Eigen::SparseMatrix<double>;

// Simple function
int add(int i, int j) { return i + j; }

// Complicated function
inline void do_mkl_stuff() {
  int i = 45;

  M3 m1;
  m1.insert(0, 0) = 43;
  m1.insert(0, 2) = 432;
  m1.insert(1, 1) = 6.519;
  M3 m2;
  m2.insert(2, 2) = 55.88;
  m2.insert(1, 0) = 7;
  m2.insert(0, 1) = 3.141592;

  Eigen::PardisoLDLT<M3> pp(m1);

  M3 ans = pp.solve(m2);

  cout << ans.coeffRef(0, 0) << endl;
}

PYBIND11_MODULE(actions, m) {
  m.def("add", &add);
  m.def("do_mkl_stuff", &do_mkl_stuff);
}
