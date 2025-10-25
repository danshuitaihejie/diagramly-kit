#!/bin/bash

# Diagramly Kit 测试实例脚本
# 此脚本演示了如何使用 diagram-dsl-to-image.sh 脚本

echo "=== Diagramly Kit 脚本测试实例 ==="
echo ""

# 定义脚本路径和测试文件
SCRIPT_PATH="./scripts/bash/diagram-dsl-to-image.sh"
TEST_INPUT="./test_diagrams/sample.mmd"

# 检查必需的文件是否存在
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "错误：脚本文件不存在：$SCRIPT_PATH"
    exit 1
fi

if [ ! -f "$TEST_INPUT" ]; then
    echo "错误：测试输入文件不存在：$TEST_INPUT"
    exit 1
fi

# 给脚本添加执行权限
echo "1. 确保脚本具有执行权限..."
chmod +x "$SCRIPT_PATH"
echo "   权限设置完成。"
echo ""

# 显示帮助信息
echo "2. 显示脚本帮助信息："
echo "   命令：$SCRIPT_PATH --help"
echo "   输出："
"$SCRIPT_PATH" --help | head -20
echo "   ..."
echo ""

# 使用默认参数进行转换测试
echo "3. 使用默认参数将 Mermaid 图表转换为 PNG 图像："
echo "   命令：$SCRIPT_PATH $TEST_INPUT"
echo "   执行中..."
"$SCRIPT_PATH" "$TEST_INPUT"
echo "   完成。"
echo ""

# 检查输出文件是否存在
OUTPUT_FILE="./output/sample.png"
if [ -f "$OUTPUT_FILE" ]; then
    echo "成功：输出文件已创建：$OUTPUT_FILE"
    echo "文件大小：$(du -h "$OUTPUT_FILE" | cut -f1)"
else
    echo "警告：输出文件未找到：$OUTPUT_FILE"
fi
echo ""

# 测试指定输出格式和目录
echo "4. 将 Mermaid 图表转换为 SVG 格式并指定输出目录："
echo "   命令：$SCRIPT_PATH $TEST_INPUT svg ./custom_output"
echo "   执行中..."
"$SCRIPT_PATH" "$TEST_INPUT" svg ./custom_output
echo "   完成。"
echo ""

# 检查自定义输出文件
CUSTOM_OUTPUT_FILE="./custom_output/sample.svg"
if [ -f "$CUSTOM_OUTPUT_FILE" ]; then
    echo "成功：自定义输出文件已创建：$CUSTOM_OUTPUT_FILE"
    echo "文件大小：$(du -h "$CUSTOM_OUTPUT_FILE" | cut -f1)"
else
    echo "警告：自定义输出文件未找到：$CUSTOM_OUTPUT_FILE"
fi
echo ""

echo "=== 测试实例结束 ==="
echo ""
echo "要运行此测试实例，请执行以下命令："
echo "  chmod +x run_test_example.sh"
echo "  ./run_test_example.sh"