import { ToolDefinition } from "./index.js";
import * as pako from "pako";
import { z } from "zod";
import * as fs from "fs";
import * as path from "path";

// 支持的图表类型
const supportedDiagramTypes = [
  "mermaid",
  "zenuml",
  "plantuml",
  "drawio",
  "markmap",
  "graphviz",
] as const;

type DiagramType = (typeof supportedDiagramTypes)[number];

export const diagramDslToImageTool: ToolDefinition = {
  name: "diagram-dsl-to-image",
  description:
    "Convert diagram dsl to image, support mermaid, zenuml, plantuml, drawio, markmap, graphviz. Default png if not specified.",
  inputSchema: {
    diagramDsl: z.string(),
    diagramType: z.enum(supportedDiagramTypes).optional().describe("Sequence diagrams use zenuml by default"),
    saveRootPath: z
      .string()
      .describe(
        "current project root directory where .diagramly-ai folder is located"
      ),
    imageType: z.enum(["png"]).optional(),
  },
  handler: convertDiagramDslToImage,
};

async function convertDiagramDslToImage({
  diagramDsl,
  diagramType,
  saveRootPath,
  imageType,
}: {
  diagramDsl: string;
  diagramType: DiagramType;
  saveRootPath?: string;
  imageType?: "png";
}) {
  const startTime = Date.now();
  try {
    console.log(
      `[CODE-TO-IMAGE] Starting conversion for ${diagramType} diagram: ${diagramDsl.substring(
        0,
        100
      )}${diagramDsl.length > 100 ? "..." : ""}`
    );

    // 验证图表类型
    if (!supportedDiagramTypes.includes(diagramType)) {
      throw new Error(
        `Unsupported diagram type: ${diagramType}. Supported types are: ${supportedDiagramTypes.join(
          ", "
        )}`
      );
    }

    console.log(
      `[CODE-TO-IMAGE] Diagram type validation passed: ${diagramType}`
    );

    // 使用改进的编码函数
    const encodedValue = encodeDiagramSource(diagramDsl);
    console.log(
      `[CODE-TO-IMAGE] Encoded diagram source length: ${encodedValue.length}`
    );

    // if imageType cannot be found, use png by default
    imageType = imageType || "png";

    console.log(`[CODE-TO-IMAGE] Image type set to: ${imageType}`);

    // 创建完整的 Kroki URL
    let baseUrl = "https://kroki.io";
    //baseUrl = "http://localhost:8000";
    const krokiUrl = `${baseUrl}/${diagramType}/${imageType}/${encodedValue}`;
    console.log(
      `[CODE-TO-IMAGE] Generated Kroki URL: ${krokiUrl.substring(0, 80)}...`
    );
    console.log(`[CODE-TO-IMAGE] Making request to Kroki service...`);

    // 使用 fetch 从 Kroki 获取图像数据，添加重试机制
    const fetchStartTime = Date.now();
    let response: Response | null = null;
    let retries = 3;
    let lastError: any;

    while (retries > 0) {
      try {
        response = await fetch(krokiUrl);
        if (response.ok) {
          break;
        }
        console.warn(
          `[CODE-TO-IMAGE] Kroki request failed with status: ${
            response.status
          }, retries left: ${retries - 1}`
        );
        retries--;
        if (retries > 0) {
          await new Promise((resolve) => setTimeout(resolve, 1000)); // 等待 1 秒后重试
        }
      } catch (fetchError) {
        console.error(`[CODE-TO-IMAGE] Kroki request error: ${fetchError}`);
        lastError = fetchError;
        retries--;
        if (retries > 0) {
          await new Promise((resolve) => setTimeout(resolve, 1000)); // 等待 1 秒后重试
        } else {
          throw new Error(
            `Failed to fetch image from Kroki after retries: ${fetchError}`
          );
        }
      }
    }

    // 检查 response 是否已成功获取
    if (!response) {
      throw new Error(
        `Failed to fetch image from Kroki after all retries. Last error: ${lastError}`
      );
    }

    if (!response.ok) {
      const errorBody = await response
        .text()
        .catch(() => "Unable to read error body");
      console.error(
        `[CODE-TO-IMAGE] Kroki error: ${response.status} ${response.statusText}, body: ${errorBody}`
      );
      throw new Error(
        `Failed to fetch image from Kroki: ${response.status} ${response.statusText}`
      );
    }

    const fetchTime = Date.now() - fetchStartTime;
    console.log(
      `[CODE-TO-IMAGE] Kroki request completed in ${fetchTime}ms with status: ${response.status}`
    );

    console.log(`[CODE-TO-IMAGE] Processing image response...`);
    const imageArrayBuffer = await response.arrayBuffer();
    const imageBytes = new Uint8Array(imageArrayBuffer);
    console.log(
      `[CODE-TO-IMAGE] Image data processed, byte length: ${imageBytes.length}`
    );
    // 生成文件名
    const timestamp = new Date().toISOString().replace(/[:.]/g, "-");
    const fileName = `${diagramType}-diagram-${timestamp}.${imageType}`;
    const rootPath = saveRootPath || process.cwd();
    const dotDiagramlyAiDir = path.join(rootPath, ".diagramly-ai");
    if (!fs.existsSync(dotDiagramlyAiDir)) {
      fs.mkdirSync(dotDiagramlyAiDir, { recursive: true });
    }
    const filePath = path.join(dotDiagramlyAiDir, fileName);
    fs.writeFileSync(filePath, imageBytes);

    const totalTime = Date.now() - startTime;
    console.log(
      `[CODE-TO-IMAGE] Conversion completed successfully in ${totalTime}ms, image size: ${imageBytes.length} bytes`
    );

    // 将图像字节转换为 Base64
    const imageBase64 = uint8ArrayToBase64(imageBytes);

    // 确定 MIME 类型
    const mimeType = "image/png";
    const relativeFilePath = path.relative(rootPath, filePath);
    return {
      content: [
        {
          type: "text",
          text: `success save image file to ${filePath},you can copy this image markdown code to text if you need. \n\n markdown code: \`\`\`markdown\n![image](${relativeFilePath})\n\`\`\` `,
        },
        {
          type: "image",
          data: imageBase64,
          mimeType: mimeType,
        },
      ],
    };
  } catch (error) {
    const totalTime = Date.now() - startTime;
    const errorMessage = error instanceof Error ? error.message : String(error);
    console.error(
      `[CODE-TO-IMAGE] Conversion failed after ${totalTime}ms: ${errorMessage}`
    );
    throw new Error(`Failed to convert image: ${errorMessage}`);
  }
}

// 辅助函数：将 Uint8Array 转换为 Base64 字符串
function uint8ArrayToBase64(bytes: Uint8Array): string {
  let binary = "";
  for (let i = 0; i < bytes.length; i++) {
    binary += String.fromCharCode(bytes[i]);
  }
  return btoa(binary);
}

// 辅助函数：将字符串编码为 URL 安全的 Base64
function encodeDiagramSource(source: string): string {
  // 将字符串转换为 Uint8Array
  const data = new TextEncoder().encode(source);

  // 使用 pako 进行 deflate 压缩
  const compressed = pako.deflate(data, { level: 9 });

  // 转换为 Base64 并使 URL 安全
  let base64 = btoa(String.fromCharCode(...compressed));
  base64 = base64.replace(/\+/g, "-").replace(/\//g, "_").replace(/=/g, "");

  return base64;
}
