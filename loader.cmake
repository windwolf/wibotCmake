# 设置BUILD_TYPE
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

if(CMAKE_BUILD_TYPE MATCHES Debug)
    message(STATUS "Build type: Debug")
elseif(CMAKE_BUILD_TYPE MATCHES Release)
    message(STATUS "Build type: Release")
endif()

# # 设置编译选项
set(MCU_FLAGS "-mcpu=${CPU}")

if(NOT FPU MATCHES "")
    set(MCU_FLAGS "${MCU_FLAGS}  -mcpu=${CPU}")
endif()

if(NOT FLOAT_ABI MATCHES "")
    set(MCU_FLAGS "${MCU_FLAGS}  -mfloat-abi=${FLOAT_ABI}")
endif()

set(LINK_FLAGS "${MCU_FLAGS} -Wl,--gc-sections,--print-memory-usage")
set(EXTRA_LINK_FLAGS "-Wl,-Map=${PROJECT_NAME}.map,--cref,--no-warn-mismatch -specs=nano.specs -specs=nosys.specs")
include(${CMAKE_CURRENT_LIST_DIR}/stm32-gcc-flags.cmake)

# 打印配置信息
message(STATUS "Specified C compiler: ${CMAKE_C_COMPILER}")
message(STATUS "Linker script: ${LINKER_SCRIPT}")
message(STATUS "Use Segger SystemView library: ${USE_SYSTEM_VIEW}")

# # 版本信息
set(VERSION_MAJOR 0 CACHE STRING "Project major version number.")
set(VERSION_MINOR 1 CACHE STRING "Project minor version number.")
set(VERSION_PATCH 0 CACHE STRING "Project patch version number.")

if(USE_SYSTEM_VIEW)
    add_definitions("-DENABLE_SYSTEMVIEW")
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cubemx_drivers_loader.cmake)

include(${CMAKE_CURRENT_LIST_DIR}/os_loader.cmake)

# ###### Load Libs ###############
list_library_directories(${CMAKE_CURRENT_SOURCE_DIR}/libs LIBRARY_NAMES CMakeLists.txt)

foreach(ln ${LIBRARY_NAMES})
    message(STATUS "lib: ${ln} loading...")
    add_subdirectory(${ln})
    message(STATUS "lib: ${ln} loaded.")
endforeach()

# ###### Load App ###################
process_src_dir(${CMAKE_CURRENT_SOURCE_DIR}/App ${PROJECT_NAME})

target_compile_definitions(${PROJECT_NAME} PUBLIC -D${PROJECT_BUILD_TYPE})

# post build
include(${CMAKE_CURRENT_LIST_DIR}/stm32-gcc-postbuild.cmake)

message(STATUS "cmake config finish.")

# # debug
include(${CMAKE_CURRENT_LIST_DIR}/stm32-gcc-jlink.cmake)
