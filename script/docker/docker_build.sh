#!/bin/bash

# 切换到脚本所在目录
cd "$(dirname "$0")" || exit

# 定义临时目录（脚本所在目录）
TEMP=$(pwd)
# 跳转到上层两层目录作为根目录
cd ../../ || exit
ROOT=$(pwd)
# 切回临时目录
cd "${TEMP}" || exit

# 定义常量
AdminName="ruoyi-admin"
MonitorAdminName="ruoyi-monitor-admin"
SnailjobName="ruoyi-snailjob-server"

Namespace="ruoyi-tdesign"
Version="1.4.0"

# 显示菜单
echo ""
echo "  [1] docker build ${AdminName}.jar"
echo "  [2] docker build ${MonitorAdminName}.jar"
echo "  [3] docker build ${SnailjobName}.jar"
echo "  [0] exit"
echo ""

# 读取用户输入
read -p "Please enter the serial number of the selected item: " ID

# 分支逻辑
case "${ID}" in
    1)
        __IMAGE_NAME="${Namespace}/${AdminName}:${Version}"
        __DOCKERFILE_PATH="${ROOT}/${AdminName}/Dockerfile"
        __PATH="${ROOT}/${AdminName}"
        __BUILD_ARG="target/${AdminName}.jar"
        ;;
    2)
        __IMAGE_NAME="${Namespace}/${MonitorAdminName}:${Version}"
        __DOCKERFILE_PATH="${ROOT}/ruoyi-extend/${MonitorAdminName}/Dockerfile"
        __PATH="${ROOT}/ruoyi-extend/${MonitorAdminName}"
        __BUILD_ARG="target/${MonitorAdminName}.jar"
        ;;
    3)
        __IMAGE_NAME="${Namespace}/${SnailjobName}:${Version}"
        __DOCKERFILE_PATH="${ROOT}/ruoyi-extend/${SnailjobName}/Dockerfile"
        __PATH="${ROOT}/ruoyi-extend/${SnailjobName}"
        __BUILD_ARG="target/${SnailjobName}.jar"
        ;;
    0)
        exit 0
        ;;
    *)
        echo "Invalid input, exit..."
        exit 1
        ;;
esac

# 执行构建
echo "Building ${__IMAGE_NAME}..."
echo "docker build -t ${__IMAGE_NAME} -f \"${__DOCKERFILE_PATH}\" ${__PATH} --build-arg JAR_FILE=\"${__BUILD_ARG}\" --no-cache"

docker build -t "${__IMAGE_NAME}" -f "${__DOCKERFILE_PATH}" "${__PATH}" --build-arg JAR_FILE="${__BUILD_ARG}" --no-cache
