# # 设置编译环境

set(CROSS_COMPILE_PREFIX arm-none-eabi)
include(${CMAKE_CURRENT_LIST_DIR}/gcc-arm-none-eabi.cmake)

include(${CMAKE_CURRENT_LIST_DIR}/utilities.cmake)
# 导入目标对应的变量或者选项. 这行不要动
include(${CMAKE_CURRENT_LIST_DIR}/target-port.cmake)
