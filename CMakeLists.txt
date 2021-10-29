cmake_minimum_required(VERSION 3.4...3.18)
project(actions)

add_subdirectory(dep/pybind11)

pybind11_add_module(actions src/main.cpp)
