cmake_minimum_required(VERSION 3.4...3.18)
project(actions)
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# set(BUILD_SHARED_LIBS TRUE)
unset(BUILD_SHARED_LIBS)


################################################################################
# Add/Locate Dependencies
add_subdirectory(dep/pybind11)

find_package(MKL REQUIRED)
find_package(OpenMP REQUIRED)
find_package(Threads REQUIRED)


################################################################################
# Includes, Compiler Flags, and Linker Flags
include_directories(dep/eigen)
include_directories(${MKL_INCLUDE_DIRS})
include_directories(${OpenMP_CXX_INCLUDE_DIRS})
include_directories(${PYBIND11_INCLUDE_DIR})
include_directories(${PYTHON_INCLUDE_DIRS})

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  list(APPEND OPENMP_FLAG "-fopenmp=libiomp5")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GCC")
  list(APPEND OPENMP_FLAG "-fopenmp")
endif()


if(BUILD_SHARED_LIBS AND NOT APPLE)  # Windows and Linux Dynamic Linking
  list(APPEND LINKER_FLAGS "-Wl,--no-undefined -Wl,--no-as-needed")
elseif(UNIX AND NOT APPLE)  # Linux Static Linking
  list(APPEND LINKER_FLAGS "-Wl,--no-undefined -Wl,--start-group ${MKL_LIBRARIES_LIST} -Wl,--end-group")
elseif(APPLE)  # Apple Dynamic and Static Linking
  list(APPEND LINKER_FLAGS "-Xlinker -undefined -Xlinker dynamic_lookup")
else()  # Windows Static Linking
  list(APPEND LINKER_FLAGS "${OpenMP_CXX_FLAGS}")
endif()


################################################################################
# Create module
pybind11_add_module(actions src/main.cpp)
target_link_libraries(actions PRIVATE ${MKL_LIBRARIES} ${OpenMP_CXX_LIBRARIES} Threads::Threads m ${PYTHON_LIBRARIES} ${CMAKE_DL_LIBS})
target_compile_options(actions PUBLIC ${OPENMP_FLAG})
set_target_properties(actions PROPERTIES LINK_FLAGS ${LINKER_FLAGS})
