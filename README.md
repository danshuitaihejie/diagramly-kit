<div align="center">
    <img src="./media/logo_small.webp"/>
    <h1>🌱 Diagramly Kit</h1>
    <h3><em>Transform user intentions into visual diagrams automatically.</em></h3>
</div>

<p align="center">
    <strong>A toolkit to help transform user requirements and intentions directly into visual diagrams and system representations.</strong>
</p>

<p align="center">
    <a href="https://github.com/github/diagramly-kit/actions/workflows/release.yml"><img src="https://github.com/github/diagramly-kit/actions/workflows/release.yml/badge.svg" alt="Release"/></a>
    <a href="https://github.com/github/diagramly-kit/stargazers"><img src="https://img.shields.io/github/stars/github/diagramly-kit?style=social" alt="GitHub stars"/></a>
    <a href="https://github.com/github/diagramly-kit/blob/main/LICENSE"><img src="https://img.shields.io/github/license/github/diagramly-kit" alt="License"/></a>
    <a href="https://github.github.io/diagramly-kit/"><img src="https://img.shields.io/badge/docs-GitHub_Pages-blue" alt="Documentation"/></a>
</p>

---

## Table of Contents

- [🤔 What is User Intention to Diagram Generation?](#-what-is-user-intention-to-diagram-generation)
- [⚡ Get started](#-get-started)
- [📽️ Video Overview](#️-video-overview)
- [🤖 Supported AI Agents](#-supported-ai-agents)
- [🔧 Diagramly CLI Reference](#-diagramly-cli-reference)
- [📚 Core philosophy](#-core-philosophy)
- [🌟 Use cases](#-use-cases)
- [🎯 Goals](#-goals)
- [🔧 Prerequisites](#-prerequisites)
- [📖 Learn more](#-learn-more)
- [📋 Detailed process](#-detailed-process)
- [🔍 Troubleshooting](#-troubleshooting)
- [👥 Maintainers](#-maintainers)
- [💬 Support](#-support)
- [🙏 Acknowledgements](#-acknowledgements)
- [📄 License](#-license)

## 🤔 What is User Intention to Diagram Generation?

User Intention to Diagram Generation **flips the script** on traditional diagram creation. For decades, creating diagrams required manual work - users had to draw boxes, connect lines, and format layouts. User Intention to Diagram Generation changes this: **user requirements and intentions become visual representations**, automatically generating diagrams that match the user's intent rather than requiring manual creation.

## ⚡ Get started

### 1. Install Diagramly

Choose your preferred installation method:

#### Option 1: Persistent Installation (Recommended)

Install once and use everywhere:

```bash
uv tool install diagramly-cli --from git+https://github.com/github/diagramly-kit.git
```

Then use the tool directly:

```bash
diagramly init <PROJECT_NAME>
diagramly check
```

To upgrade diagramly run:

```bash
uv tool install diagramly-cli --force --from git+https://github.com/github/diagramly-kit.git
```

#### Option 2: One-time Usage

Run directly without installing:

```bash
uvx --from git+https://github.com/github/diagramly-kit.git diagramly init <PROJECT_NAME>
```

**Benefits of persistent installation:**

- Tool stays installed and available in PATH
- No need to create shell aliases
- Better tool management with `uv tool list`, `uv tool upgrade`, `uv tool uninstall`
- Cleaner shell configuration

### 2. Initialize your project

Use the **`diagramly init`** command to set up your diagram generation environment:

```bash
diagramly init my-diagram-project
```

### 3. Generate diagrams from your intentions

Use the **`/diagramlykit.diagram`** command to describe what you want to visualize. Focus on the **what** you want to see.

```bash
/diagramlykit.diagram Generate a system architecture diagram showing the relationship between user, web application, database, and external services. The web application should use React with a Node.js backend.
```

### 4. Generate other diagrams as needed

Use **`/diagramlykit.diagram`** with different types of diagrams:

```bash
/diagramlykit.diagram Create a UML class diagram for the user and order management system with classes User, Order, and Product.
/diagramlykit.diagram Generate a flowchart showing the user registration process from sign up to account activation.
```

For detailed step-by-step instructions, see our [comprehensive guide](./diagram-generation.md).

## 📽️ Video Overview

Want to see Diagramly Kit in action? Watch our [video overview](https://www.youtube.com/watch?v=a9eR1xsfvHg&pp=0gcJCckJAYcqIYzv)!

[![Diagramly Kit video header](/media/diagramly-kit-video-header.jpg)](https://www.youtube.com/watch?v=a9eR1xsfvHg&pp=0gcJCckJAYcqIYzv)

## 🤖 Supported AI Agents

| Agent                                                     | Support | Notes                                             |
|-----------------------------------------------------------|---------|---------------------------------------------------|
| [Claude Code](https://www.anthropic.com/claude-code)      | ✅ |                                                   |
| [GitHub Copilot](https://code.visualstudio.com/)          | ✅ |                                                   |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | ✅ |                                                   |
| [Cursor](https://cursor.sh/)                              | ✅ |                                                   |
| [Qwen Code](https://github.com/QwenLM/qwen-code)          | ✅ |                                                   |
| [opencode](https://opencode.ai/)                          | ✅ |                                                   |
| [Windsurf](https://windsurf.com/)                         | ✅ |                                                   |
| [Kilo Code](https://github.com/Kilo-Org/kilocode)         | ✅ |                                                   |
| [Auggie CLI](https://docs.augmentcode.com/cli/overview)   | ✅ |                                                   |
| [CodeBuddy](https://www.codebuddy.ai/)                    | ✅ |                                                   |
| [Roo Code](https://roocode.com/)                          | ✅ |                                                   |
| [Codex CLI](https://github.com/openai/codex)              | ✅ |                                                   |
| [Amazon Q Developer CLI](https://aws.amazon.com/developer/learning/q-developer-cli/) | ⚠️ | Amazon Q Developer CLI [does not support](https://github.com/aws/amazon-q-developer-cli/issues/3064) custom arguments for slash commands. |

## 🔧 Diagramly CLI Reference

The `diagramly` command supports the following options:

### Commands

| Command     | Description                                                    |
|-------------|----------------------------------------------------------------|
| `init`      | Initialize a new Diagramly project from the latest template      |
| `check`     | Check for installed tools (`git`, `claude`, `gemini`, `code`/`code-insiders`, `cursor-agent`, `windsurf`, `qwen`, `opencode`, `codex`) |

### `diagramly init` Arguments & Options

| Argument/Option        | Type     | Description                                                                  |
|------------------------|----------|------------------------------------------------------------------------------|
| `<project-name>`       | Argument | Name for your new project directory (optional if using `--here`, or use `.` for current directory) |
| `--ai`                 | Option   | AI assistant to use: `claude`, `gemini`, `copilot`, `cursor`, `qwen`, `opencode`, `codex`, `windsurf`, `kilocode`, `auggie`, `roo`, `codebuddy`, or `q` |
| `--script`             | Option   | Script variant to use: `sh` (bash/zsh) or `ps` (PowerShell)                 |
| `--ignore-agent-tools` | Flag     | Skip checks for AI agent tools like Claude Code                             |
| `--no-git`             | Flag     | Skip git repository initialization                                          |
| `--here`               | Flag     | Initialize project in the current directory instead of creating a new one   |
| `--force`              | Flag     | Force merge/overwrite when initializing in current directory (skip confirmation) |
| `--skip-tls`           | Flag     | Skip SSL/TLS verification (not recommended)                                 |
| `--debug`              | Flag     | Enable detailed debug output for troubleshooting                            |
| `--github-token`       | Option   | GitHub token for API requests (or set GH_TOKEN/GITHUB_TOKEN env variable)  |

### Examples

```bash
# Basic project initialization
diagramly init my-project

# Initialize with specific AI assistant
diagramly init my-project --ai claude

# Initialize with Cursor support
diagramly init my-project --ai cursor-agent

# Initialize with Windsurf support
diagramly init my-project --ai windsurf

# Initialize with PowerShell scripts (Windows/cross-platform)
diagramly init my-project --ai copilot --script ps

# Initialize in current directory
diagramly init . --ai copilot
# or use the --here flag
diagramly init --here --ai copilot

# Force merge into current (non-empty) directory without confirmation
diagramly init . --force --ai copilot
# or 
diagramly init --here --force --ai copilot

# Skip git initialization
diagramly init my-project --ai gemini --no-git

# Enable debug output for troubleshooting
diagramly init my-project --ai claude --debug

# Use GitHub token for API requests (helpful for corporate environments)
diagramly init my-project --ai claude --github-token ghp_your_token_here

# Check system requirements
diagramly check
```

### Available Slash Commands

After running `diagramly init`, your AI coding agent will have access to these slash commands for diagram generation:

#### Core Commands

Essential commands for the User Intention to Diagram Generation workflow:

| Command                  | Description                                                           |
|--------------------------|-----------------------------------------------------------------------|
| `/diagramlykit.diagram`       | Generate diagrams from user requirements (Mermaid, PlantUML, Graphviz, etc.) |
| `/diagramlykit.architecture`  | Generate system architecture diagrams based on your specifications    |
| `/diagramlykit.flow`          | Create flowcharts and process diagrams from your descriptions         |
| `/diagramlykit.uml`           | Generate UML diagrams including class, sequence, and activity diagrams |
| `/diagramlykit.visualize`     | Create data visualization diagrams from your data models             |

#### Optional Commands

Additional commands for enhanced diagram generation:

| Command              | Description                                                           |
|----------------------|-----------------------------------------------------------------------|
| `/diagramlykit.clarify`   | Clarify underspecified diagram requirements (recommended before complex diagrams) |
| `/diagramlykit.analyze`   | Analyze and validate diagram accuracy and completeness |
| `/diagramlykit.export`    | Export diagrams in various formats (PNG, SVG, PDF, etc.) |

### Environment Variables

| Variable         | Description                                                                                    |
|------------------|------------------------------------------------------------------------------------------------|
| `SPECIFY_FEATURE` | Override feature detection for non-Git repositories. Set to the feature directory name (e.g., `001-photo-albums`) to work on a specific feature when not using Git branches.<br/>**Must be set in the context of the agent you're working with prior to using `/diagramlykit.plan` or follow-up commands. |

## 📚 Core philosophy

User Intention to Diagram Generation is a structured process that emphasizes:

- **Intent-driven visualization** where user requirements define the "_what_" before the "_how_"
- **Rich diagram generation** using AI to transform natural language into visual representations
- **Multi-step refinement** rather than one-shot diagram creation from prompts
- **Heavy reliance** on advanced AI model capabilities for diagram interpretation and generation

## 🌟 Use cases

| Use Case | Focus | Key Activities |
|-------|-------|----------------|
| **System Architecture** | Visualize system components | <ul><li>Document system architecture</li><li>Generate component diagrams</li><li>Create deployment diagrams</li><li>Visualize service interactions</li></ul> |
| **Process Documentation** | Flow and procedure visualization | <ul><li>Create workflow diagrams</li><li>Document business processes</li><li>Generate sequence diagrams</li></ul> |
| **Data Modeling** | Data structure visualization | <ul><li>Create entity-relationship diagrams</li><li>Generate class diagrams from requirements</li><li>Visualize data flows</li></ul> |

## 🎯 Goals

Our goals focus on:

### Visualization simplicity

- Transform user requirements into visual diagrams automatically
- Support diverse diagram types (system architecture, flowcharts, UML, data models)

### User experience

- Make diagram creation accessible to non-technical users
- Generate high-quality diagrams from natural language descriptions

### AI capabilities

- Leverage advanced AI for diagram interpretation and generation
- Support iterative refinement of generated diagrams

## 🔧 Prerequisites

- **Linux/macOS** (or WSL2 on Windows)
- AI coding agent: [Claude Code](https://www.anthropic.com/claude-code), [GitHub Copilot](https://code.visualstudio.com/), [Gemini CLI](https://github.com/google-gemini/gemini-cli), [Cursor](https://cursor.sh/), [Qwen CLI](https://github.com/QwenLM/qwen-code), [opencode](https://opencode.ai/), [Codex CLI](https://github.com/openai/codex), [Windsurf](https://windsurf.com/), or [Amazon Q Developer CLI](https://aws.amazon.com/developer/learning/q-developer-cli/)
- [uv](https://docs.astral.sh/uv/) for package management
- [Python 3.11+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)

If you encounter issues with an agent, please open an issue so we can refine the integration.

## 📖 Learn more

- **[Complete User Intention to Diagram Generation Methodology](./diagram-generation.md)** - Deep dive into the full process
- **[Detailed Walkthrough](#-detailed-process)** - Step-by-step implementation guide

---

## 📋 Detailed process

<details>
<summary>Click to expand the detailed step-by-step walkthrough</summary>

You can use the Diagramly CLI to bootstrap your project, which will bring in the required artifacts in your environment. Run:

```bash
diagramly init <project_name>
```

Or initialize in the current directory:

```bash
diagramly init .
# or use the --here flag
diagramly init --here
# Skip confirmation when the directory already has files
diagramly init . --force
# or
diagramly init --here --force
```

![Diagramly CLI bootstrapping a new project in the terminal](./media/diagramly_cli.gif)

You will be prompted to select the AI agent you are using. You can also proactively specify it directly in the terminal:

```bash
diagramly init <project_name> --ai claude
diagramly init <project_name> --ai gemini
diagramly init <project_name> --ai copilot

# Or in current directory:
diagramly init . --ai claude
diagramly init . --ai codex

# or use --here flag
diagramly init --here --ai claude
diagramly init --here --ai codex

# Force merge into a non-empty current directory
diagramly init . --force --ai claude

# or
diagramly init --here --force --ai claude
```

The CLI will check if you have Claude Code, Gemini CLI, Cursor CLI, Qwen CLI, opencode, Codex CLI, or Amazon Q Developer CLI installed. If you do not, or you prefer to get the templates without checking for the right tools, use `--ignore-agent-tools` with your command:

```bash
diagramly init <project_name> --ai claude --ignore-agent-tools
```

### **STEP 1:** Initialize your diagram environment

Go to the project folder and run your AI agent. In our example, we're using `claude`.

![Bootstrapping Claude Code environment](./media/bootstrap-claude-code.gif)

You will know that things are configured correctly if you see the `/diagramlykit.diagram`, `/diagramlykit.architecture`, `/diagramlykit.flow`, `/diagramlykit.uml`, and `/diagramlykit.visualize` commands available.

The environment will be set up with the necessary templates and configurations for diagram generation.

### **STEP 2:** Generate your first diagram

With your environment established, you can now generate diagrams. Use the `/diagramlykit.diagram` command and then provide the description of what you want to visualize.

>[!IMPORTANT]
>Be as explicit as possible about _what_ you want to see in the diagram and _why_. **Do not focus on the diagram format at this point**.

An example prompt:

```text
Generate a system architecture diagram showing the relationship between users, web application, database, and external services. The web application should use React with a Node.js backend, and the database should be PostgreSQL. The external services include a payment gateway and email service.
```

After this prompt is entered, you should see your AI agent generate the appropriate diagram code, visualize it, and provide you with the diagram in multiple formats.

At this stage, your project folder contents should resemble the following:

```text
└── .diagramly
    ├── memory
    │	 └── constitution.md
    ├── scripts
    │	 ├── check-prerequisites.sh
    │	 ├── common.sh
    │	 ├── diagram-generation.sh
    │	 ├── architecture-diagram.sh
    │	 └── visualize.sh
    ├── diagrams
    │	 └── 001-architecture
    │	     ├── diagram.md
    │	     ├── diagram.mmd (Mermaid)
    │	     ├── diagram.puml (PlantUML)
    │	     └── diagram.png
    └── templates
        ├── diagram-template.md
        ├── architecture-template.md
        └── flow-template.md
```

### **STEP 3:** Refine your diagram (optional)

You can refine your diagram by providing additional details or requesting changes to the existing diagram.

Example refinement prompt:

```text
Make the database layer more detailed by showing the user, order, and product tables with their key fields.
```

Or to explore alternative visualizations:

```text
Show the same system architecture but in a component diagram format instead of deployment diagram.
```

### **STEP 4:** Generate specialized diagrams

Use specialized commands for different types of diagrams:

- `/diagramlykit.architecture` - for system architecture diagrams
- `/diagramlykit.flow` - for flowcharts and process diagrams
- `/diagramlykit.uml` - for UML class, sequence, and activity diagrams
- `/diagramlykit.visualize` - for data visualization diagrams

Examples:

```text
/diagramlykit.flow Create a flowchart showing the user registration process from sign up to account activation with decision points for email verification.
```

```text
/diagramlykit.uml Generate a class diagram for the e-commerce system with classes User, Product, Order, and Payment, showing their relationships.
```

### **STEP 5:** Export your diagrams

Use `/diagramlykit.export` to save your diagrams in different formats:

```text
/diagramlykit.export Export the current diagram as PNG, SVG, and PDF files.
```

This makes it easy to share your diagrams with stakeholders or include them in documentation.

</details>

---

## 🔍 Troubleshooting

### Git Credential Manager on Linux

If you're having issues with Git authentication on Linux, you can install Git Credential Manager:

```bash
#!/usr/bin/env bash
set -e
echo "Downloading Git Credential Manager v2.6.1..."
wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb
echo "Installing Git Credential Manager..."
sudo dpkg -i gcm-linux_amd64.2.6.1.deb
echo "Configuring Git to use GCM..."
git config --global credential.helper manager
echo "Cleaning up..."
rm gcm-linux_amd64.2.6.1.deb
```

## 👥 Maintainers

- Den Delimarsky ([@localden](https://github.com/localden))
- John Lam ([@jflam](https://github.com/jflam))

## 💬 Support

For support, please open a [GitHub issue](https://github.com/github/diagramly-kit/issues/new). We welcome bug reports, feature requests, and questions about using User Intention to Diagram Generation.

## 🙏 Acknowledgements

This project is heavily influenced by and based on the work and research of [John Lam](https://github.com/jflam).

## 📄 License

This project is licensed under the terms of the MIT open source license. Please refer to the [LICENSE](./LICENSE) file for the full terms.
