# ########## CubeMx MW ##############

# ################## cubemx generated code ######################
file(GLOB CUBEMX_HAL_CORE_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Core/Src/*.*

    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/*.s
)

add_executable(${PROJECT_NAME} ${CUBEMX_HAL_CORE_SRC})
target_include_directories(${PROJECT_NAME}
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Core/Inc)

# ################## HAL lib ####################################
file(GLOB_RECURSE CUBEMX_HAL_DRIVER_HAL_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/${MCU_SERIES}_HAL_Driver/Src/*_hal.c
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/${MCU_SERIES}_HAL_Driver/Src/*_hal_*.c)
list(FILTER CUBEMX_HAL_DRIVER_HAL_SRC EXCLUDE REGEX "(_template.c)$")

file(GLOB_RECURSE CUBEMX_HAL_DRIVER_LL_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/${MCU_SERIES}_HAL_Driver/Src/*_ll_*.c)
list(FILTER CUBEMX_HAL_DRIVER_LL_SRC EXCLUDE REGEX "(_template.c)$")

if(NOT DEFINED USE_HAL_LIB)
    message(STATUS "USE_HAL_LIB: not set, use default value : ON")
    set(USE_HAL_LIB ON)
else()
    message(STATUS "USE_HAL_LIB: ${USE_HAL_LIB}")
endif()

if(USE_HAL_LIB)
    target_sources(${PROJECT_NAME}
        PRIVATE
        ${CUBEMX_HAL_DRIVER_HAL_SRC}
        ${CUBEMX_HAL_DRIVER_LL_SRC})
    target_compile_definitions(${PROJECT_NAME}
        PUBLIC -DUSE_HAL_DRIVER)
else()
    target_sources(${PROJECT_NAME}
        PRIVATE
        ${CUBEMX_HAL_DRIVER_LL_SRC})
    target_compile_definitions(${PROJECT_NAME}
        PUBLIC -DUSE_FULL_LL_DRIVER)
endif()

if(NOT DEFINED USE_FULL_ASSERT)
    message(STATUS "USE_FULL_ASSERT: not set, use default value : OFF")
    set(USE_FULL_ASSERT OFF)
else()
    message(STATUS "USE_FULL_ASSERT: ${USE_FULL_ASSERT}")
endif()

if(USE_FULL_ASSERT)
    target_compile_definitions(${PROJECT_NAME}
        PUBLIC -DUSE_FULL_ASSERT)
endif()

target_include_directories(${PROJECT_NAME}
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/${MCU_SERIES}_HAL_Driver/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/${MCU_SERIES}_HAL_Driver/Inc/Legacy
)

# ############### CMSIS & CMSISDevice ##################
target_include_directories(${PROJECT_NAME}
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/CMSIS/Device/ST/${MCU_SERIES}/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/CMSIS/Include
)

# ############### CMSIS DSP ############################
if(NOT DEFINED USE_CMSIS_DSP_LIB)
    message(STATUS "USE_CMSIS_DSP_LIB: not set, use default value : OFF")
    set(USE_CMSIS_DSP_LIB OFF)
else()
    message(STATUS "USE_CMSIS_DSP_LIB: ${USE_CMSIS_DSP_LIB}")
endif()

if(USE_CMSIS_DSP_LIB)
    file(GLOB_RECURSE CMSIS_DSP_SOURCE_FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/CMSIS/DSP/Source/*.*
    )
    target_sources(${PROJECT_NAME}
        PRIVATE
        ${CMSIS_DSP_SOURCE_FILES})
    target_include_directories(${PROJECT_NAME}
        PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/CMSIS/DSP/Include)
    target_compile_definitions(${PROJECT_NAME}
        PUBLIC
        -D${ARM_MATH}
    )
endif()

# ############### App ##############################
target_include_directories(${PROJECT_NAME}
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/App/inc
)

# gcc flags
target_compile_definitions(${PROJECT_NAME}
    PUBLIC
    -D${MCU_LINE}
)

# ld
file(GLOB __TEMP_LD__
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/*.ld
)
list(GET __TEMP_LD__ 0 LINKER_SCRIPT)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    -T${LINKER_SCRIPT} ${EXTRA_LINK_FLAGS}
)