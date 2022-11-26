# 工具链
set(GCC_PATH "/opt/gcc-arm-none-eabi-10.3-2021.10/bin")
set(PREFIX "arm-none-eabi-")
set(CMAKE_C_COMPILER ${GCC_PATH}/${PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${GCC_PATH}/${PREFIX}gcc)

# 生成工具
set(CP ${GCC_PATH}/${PREFIX}objcopy)
set(SZ ${GCC_PATH}/${PREFIX}size)

# 编译选项
set(CPU "-mcpu=cortex-m3")

# set(FPU "")
# set(FLOAT-AB "")
set(MCU "${CPU} -mthumb ${FPU} ${FLOAT-ABI}")

# set(OPT "-Og")
set(CMAKE_C_FLAGS "${MCU} ${OPT} -Wall -fdata-sections -ffunction-sections -g -gdwarf-2")
set(CMAKE_C_FLAGS_DEBUG "-g -gdwarf-2")
set(CMAKE_C_FLAGS_RELEASE "")

SET(CMAKE_ASM_FLAGS "${MCU} ${OPT} -x assembler-with-cpp -Wall -fdata-sections -ffunction-sections")
# message(STATUS "${CMAKE_ASM_FLAGS}")

# # 链接脚本
# set(LDSCRIPT "")
# set(LIBS "-lc -lm -lnosys")
# # set(LIBDIR "")
# set(CMAKE_EXE_LINKER_FLAGS
#     "${MCU} -specs=nano.specs -T${LDSCRIPT} ${LIBS} ${LIBDIR} -Wl,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map,--cref -Wl,--gc-sections"
# )