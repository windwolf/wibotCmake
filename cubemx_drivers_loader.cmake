# ########## CubeMx MW ##############
file(GLOB CUBEMX_HAL_CORE_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Core/Src/*.*

    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/*.s
)

add_executable(${PROJECT_NAME} ${CUBEMX_HAL_CORE_SRC})

file(GLOB_RECURSE CUBEMX_HAL_DRIVER_HAL_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/${MCU_SERIES}_HAL_Driver/Src/*_hal.c
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/${MCU_SERIES}_HAL_Driver/Src/*_hal_*.c)
list(FILTER CUBEMX_HAL_DRIVER_HAL_SRC EXCLUDE REGEX "(_template.c)$")

file(GLOB_RECURSE CUBEMX_HAL_DRIVER_LL_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/${MCU_SERIES}_HAL_Driver/Src/*_ll_*.c)
list(FILTER CUBEMX_HAL_DRIVER_LL_SRC EXCLUDE REGEX "(_template.c)$")

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

if(USE_FULL_ASSERT)
    target_compile_definitions(${PROJECT_NAME}
        PUBLIC -DUSE_FULL_ASSERT)
endif()

target_include_directories(${PROJECT_NAME}
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Core/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/${MCU_SERIES}_HAL_Driver/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/${MCU_SERIES}_HAL_Driver/Inc/Legacy
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/CMSIS/Device/ST/${MCU_SERIES}/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/cubemx/Drivers/CMSIS/Include

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