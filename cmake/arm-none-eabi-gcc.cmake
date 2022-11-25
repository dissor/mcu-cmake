# 工具链
set(GCC_PATH "/opt/gcc-arm-none-eabi-10.3-2021.10/bin")
set(PREFIX "arm-none-eabi-")
set(CMAKE_C_COMPILER ${GCC_PATH}/${PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${GCC_PATH}/${PREFIX}gcc)

# 生成工具
set(CP ${GCC_PATH}/${PREFIX}objcopy)
set(SZ ${GCC_PATH}/${PREFIX}size)

message(STATUS "${CMAKE_C_COMPILER}")

# 编译选项
set(CPU "-mcpu=cortex-m3")

# set(FPU "")
# set(FLOAT-AB "")
set(MCU "${CPU} -mthumb ${FPU} ${FLOAT-ABI}")
message(STATUS "${MCU}")

# set(OPT "-Og")
set(CMAKE_C_FLAGS "${MCU} ${OPT} -Wall -fdata-sections -ffunction-sections -g -gdwarf-2")
set(CMAKE_C_FLAGS_DEBUG "-g -gdwarf-2")
set(CMAKE_C_FLAGS_RELEASE "")
message(STATUS "${CMAKE_C_FLAGS}")

SET(CMAKE_ASM_FLAGS "${MCU} ${OPT} -x assembler-with-cpp -Wall -fdata-sections -ffunction-sections")
message(STATUS "${CMAKE_ASM_FLAGS}")