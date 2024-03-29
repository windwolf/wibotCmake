if (NOT TARGET_MCU)
    message(FATAL_ERROR "Error: 请在project-settings.cmake中指定 TARGET_MCU.")
else ()
    if (TARGET_MCU MATCHES "^STM32")
        set(HAL_NAME "STM32")
    endif ()
    if (TARGET_MCU MATCHES "^STM32F1")
        set(MCU_SERIES "STM32F1xx")
        set(CPU "cortex-m3")
        set(FPU "")
        set(FLOAT_ABI "")
        set(ARM_MATH "ARM_MATH_CM3")
        string(SUBSTRING ${TARGET_MCU} 0 11 JLINK_DEVICE)
        if (TARGET_MCU MATCHES "^STM32F103VB")
            set(MCU_LINE "STM32F103xB")
        elseif (TARGET_MCU MATCHES "^STM32F103C8")
            set(MCU_LINE "STM32F103xB")
        else ()
            message(WARNING "Error: 未知的MCU_LINE")
        endif ()
        set(BSP_PORT "stm32f1xx")
    elseif (TARGET_MCU MATCHES "^STM32F4")
        set(MCU_SERIES "STM32F4xx")
        set(CPU "cortex-m4")
        set(FPU "fpv4-sp-d16")
        set(FLOAT_ABI "hard")
        set(ARM_MATH "ARM_MATH_CM4")
        string(SUBSTRING ${TARGET_MCU} 0 11 JLINK_DEVICE)
        if (TARGET_MCU MATCHES "^STM32F407")
            set(MCU_LINE "STM32F103xB")
        elseif (TARGET_MCU MATCHES "^STM32F103C8")
            set(MCU_LINE "STM32F103xB")
        else ()
            message(WARNING "Error: 未知的MCU_LINE")
        endif ()
        set(BSP_PORT "stm32f4xx")
    elseif (TARGET_MCU MATCHES "^STM32H7")
        set(MCU_SERIES "STM32H7xx")
        set(CPU "cortex-m7")
        set(FPU "fpv5-d16")
        set(FLOAT_ABI "hard")
        set(ARM_MATH "ARM_MATH_CM7")
        string(SUBSTRING ${TARGET_MCU} 0 11 JLINK_DEVICE)

        if (TARGET_MCU MATCHES "^STM32H750")
            set(MCU_LINE "STM32H750xx")
        else ()
            message(WARNING "Error: 未知的MCU_LINE")
        endif ()
        set(BSP_PORT "stm32h7xx")
    elseif (TARGET_MCU MATCHES "^STM32G0")
        set(MCU_SERIES "STM32G0xx")
        set(CPU "cortex-m0plus")
        set(FPU "")
        set(FLOAT_ABI "")
        set(ARM_MATH "ARM_MATH_CM0PLUS")
        string(SUBSTRING ${TARGET_MCU} 0 11 JLINK_DEVICE)

        if (TARGET_MCU MATCHES "^STM32G031")
            set(MCU_LINE "STM32G031xx")
        else ()
            message(WARNING "Error: 未知的MCU_LINE")
        endif ()
        set(BSP_PORT "stm32g0xx")
    elseif (TARGET_MCU MATCHES "^STM32G4")
        set(MCU_SERIES "STM32G4xx")
        set(CPU "cortex-m4")
        set(FPU "fpv4-sp-d16")
        set(FLOAT_ABI "hard")
        set(ARM_MATH "ARM_MATH_CM4")
        string(SUBSTRING ${TARGET_MCU} 0 11 JLINK_DEVICE)

        if (TARGET_MCU MATCHES "^STM32G431")
            set(MCU_LINE "STM32G431xx")
        elseif (TARGET_MCU MATCHES "^STM32G474")
            set(MCU_LINE "STM32G474xx")
        else ()
            message(WARNING "Error: 未知的MCU_LINE")
        endif ()
        set(BSP_PORT "stm32g4xx")
    else ()
        message(FATAL_ERROR "Error: 未知的TARGET_MCU")
    endif ()
endif ()


message(STATUS "TARGET_MCU: ${TARGET_MCU}")
message(STATUS "MCU_SERIES: ${MCU_SERIES}")
message(STATUS "CPU: ${CPU}")
message(STATUS "FPU: ${FPU}")
message(STATUS "FLOAT_ABI: ${FLOAT_ABI}")
message(STATUS "ARM_MATH: ${ARM_MATH}")
message(STATUS "BSP_PORT: ${BSP_PORT}")
message(STATUS "HAL_NAME: ${HAL_NAME}")
message(STATUS "JLINK_DEVICE: ${JLINK_DEVICE}")
