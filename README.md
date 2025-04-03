This is the Tango CORBA IDL file.

## Installation
- cmake -B build -S .
- cmake --install build

## Usage
Once installed the tango IDL file can be imported in cmake projects through the `find_package` function.

Here is an example:
```
project(Foo)

# Use find_package to import the tangoidl target
find_package(tangoidl)

add_library(libfoo SHARED)

if(tangoidl_FOUND)
    get_target_property(IDL_PKG_INCLUDE_DIRS tangoidl::tangoidl INTERFACE_INCLUDE_DIRECTORIES)
    # Use your `IDL_PKG_INCLUDE_DIRS/tango.idl` and your idl compiler to generate CORBA stubs
endif(tangoidl_FOUND)
```
