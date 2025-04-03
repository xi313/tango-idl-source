cmake_minimum_required(VERSION 3.18...3.26 FATAL_ERROR)

project(tangoidl)

#need to define the version of the library
set(MAJOR_VERSION "6")
set(MINOR_VERSION "0")
set(PATCH_VERSION "2")

#convenient versions
set(LIBRARY_VERSION "${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}")

project(tangoidl VERSION ${LIBRARY_VERSION})

include(GNUInstallDirs)

add_library(tangoidl INTERFACE)

target_include_directories(tangoidl
    INTERFACE
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "${PROJECT_BINARY_DIR}/tangoidlConfigVersion.cmake"
    VERSION ${LIBRARY_VERSION}
    COMPATIBILITY AnyNewerVersion
    ARCH_INDEPENDENT)

set(ConfigPackageLocation lib/cmake/tangoidl)
set(Namespace tangoidl::)

install(TARGETS tangoidl
    EXPORT tangoidlTargets
    LIBRARY DESTINATION lib COMPONENT Runtime
    ARCHIVE DESTINATION lib COMPONENT Development
    RUNTIME DESTINATION bin COMPONENT Runtime
    PUBLIC_HEADER DESTINATION include COMPONENT Development
    BUNDLE DESTINATION bin COMPONENT Runtime)

configure_package_config_file(
    "${PROJECT_SOURCE_DIR}/cmake/tangoidlConfig.cmake.in"
    "${PROJECT_BINARY_DIR}/tangoidlConfig.cmake"
    INSTALL_DESTINATION ${ConfigPackageLocation})

export(EXPORT tangoidlTargets
    FILE "${PROJECT_BINARY_DIR}/tangoidlTargets.cmake"
    NAMESPACE ${Namespace})

install(EXPORT tangoidlTargets
    NAMESPACE ${Namespace}
    DESTINATION ${ConfigPackageLocation})

install(FILES "${PROJECT_BINARY_DIR}/tangoidlConfigVersion.cmake"
              "${PROJECT_BINARY_DIR}/tangoidlConfig.cmake"
        DESTINATION ${ConfigPackageLocation})

install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/ DESTINATION include)


configure_file("${PROJECT_SOURCE_DIR}/cmake/tangoidl.pc.cmake"
    "${PROJECT_BINARY_DIR}/tangoidl.pc" @ONLY)

install(FILES "${PROJECT_BINARY_DIR}/tangoidl.pc"
DESTINATION "${CMAKE_INSTALL_FULL_LIBDIR}/pkgconfig")

