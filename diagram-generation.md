# User Intention to Diagram Generation (UIDG)

## The Power Inversion

For decades, creating diagrams required manual work. Users served diagrams—they drew boxes, connected lines, and formatted layouts. We wrote requirements to guide development, created specifications to inform implementation, drew diagrams to visualize architecture. But creating those diagrams required manual effort. Diagramming was tedious. Everything else was, at best, instructions for manual execution. The diagramming process was the source of truth, and as it moved forward, diagrams rarely kept pace with evolving requirements. As the need for visual communication evolved, it was difficult to have an updated visual representation without manually rebuilding the diagram.

User Intention to Diagram Generation (UIDG) inverts this power structure. User intentions don't serve diagrams—diagrams serve user intentions. The description of what users want to visualize isn't a guide for manual diagramming; it's the source that generates diagrams. Natural language descriptions aren't documents that inform manual drawing; they're precise definitions that produce visual representations. This isn't an incremental improvement to how we create diagrams. It's a fundamental rethinking of what drives diagram creation.

The gap between user intentions and visual representation has plagued documentation and communication since its inception. We've tried to bridge it with better drawing tools, more detailed templates, and stricter processes. These approaches fail because they accept the manual work as inevitable. They try to make it easier but never eliminate it. UIDG eliminates the gap by making user intentions and their concrete diagram representations born from the description automatically executable. When user intentions and descriptions generate diagrams, there is no gap—only transformation.

This transformation is now possible because AI can understand and implement complex requirements, and create detailed visual representations. But raw AI generation without structure produces chaos. UIDG provides that structure through user intentions and subsequent diagram generation that is precise, complete, and unambiguous enough to generate proper diagrams. The user intention becomes the primary artifact. Diagrams become its expression in a particular visual format and representation.

In this new world, creating documentation means expressing intentions. The intent of the user is expressed in natural language ("**intent-driven visualization**"), design assets, core principles and other guidelines. The **lingua franca** of diagramming moves to a higher level, and manual drawing is the last-mile approach.

Debugging means refining user intentions and descriptions that generate incorrect diagrams. Refactoring means restructuring for clarity. The entire visualization workflow reorganizes around user intentions as the central source of truth, with diagrams as the continuously regenerated output. Updating documentation with new requirements or creating a new visualization because we are creative beings, means revisiting the intention and creating new diagrams. This process is therefore a 0 -> 1, (1', ..), 2, 3, N.

The user focuses in on their creativity, experimentation, their critical thinking.

## The UIDG Workflow in Practice

The workflow begins with an idea—often vague and incomplete. Through iterative dialogue with AI, this idea becomes a comprehensive description. The AI asks clarifying questions, identifies visualization gaps, and helps define precise diagram requirements. What might take hours of drawing and formatting in traditional diagramming happens in minutes of focused intention expression. This transforms the traditional documentation process—requirements and design become continuous activities rather than discrete phases.

When a stakeholder updates requirements, diagrams automatically regenerate to reflect changes. When a designer discovers a better visualization approach, the description updates to reflect new possibilities.

Throughout this intention process, AI agents gather critical context. They investigate diagram best practices, layout optimization, and visual clarity considerations. Domain constraints are discovered and applied automatically—your company's visualization standards, diagram types, and presentation requirements seamlessly integrate into every generation.

From the user's description, AI generates diagrams that map requirements to visual representations. Every diagram choice has documented rationale. Every layout decision traces back to specific requirements. Throughout this process, consistency validation continuously improves quality. AI analyzes diagrams for clarity, readability, and accuracy—not as a one-time gate, but as an ongoing refinement.

Diagram generation begins as soon as user intentions and their descriptions are stable enough, but they do not have to be "complete." Early generations might be exploratory—testing whether the visualization makes sense in practice. Domain concepts become architecture diagrams. User flows become process diagrams. System interactions become UML diagrams. This merges documentation and visualization through intention—diagrams aren't created after requirements, they're part of the description that generates both understanding and visualization.

The feedback loop extends beyond initial creation. Review feedback and iteration don't just trigger manual updates—they regenerate diagrams based on refined intentions. Complex layouts become new clarity requirements. Visual inconsistencies become constraints that affect all future generations. This iterative dance between intention, description, and visual representation is where true understanding emerges and where the traditional documentation process transforms into a continuous evolution.

## Why UIDG Matters Now

Three trends make UIDG not just possible but necessary:

First, AI capabilities have reached a threshold where natural language descriptions can reliably generate meaningful diagrams. This isn't about replacing designers—it's about amplifying their effectiveness by automating the mechanical translation from intention to visualization. It can amplify exploration and creativity, support "start-over" easily, and support addition, subtraction, and critical thinking.

Second, documentation complexity continues to grow exponentially. Modern systems involve complex architectures, intricate workflows, and detailed relationships. Keeping all these pieces visually represented through manual processes becomes increasingly difficult. UIDG provides systematic alignment through intention-driven generation. Frameworks may evolve to provide AI-first support, not human-first support, or architect around reusable components.

Third, the pace of change accelerates. Requirements change far more rapidly today than ever before. Pivoting is no longer exceptional—it's expected. Modern product development demands rapid iteration based on user feedback, market conditions, and competitive pressures. Traditional diagramming treats these changes as disruptions. Each pivot requires manually updating documentation, diagrams, and visual representations. The result is either slow, careful updates that limit velocity, or fast, reckless changes that result in outdated diagrams.

UIDG can support what-if/simulation experiments: "If we need to re-visualize or change the system architecture to promote a business need to add more services, how would we diagram and experiment for that?"

UIDG transforms requirement changes from obstacles into normal workflow. When user intentions drive diagram generation, pivots become systematic regenerations rather than manual reworks. Change a core requirement in the description, and affected diagrams update automatically. Modify a process flow, and corresponding architecture diagrams regenerate. This isn't just about initial development—it's about maintaining documentation velocity through inevitable changes.

## Core Principles

**Intentions as the Lingua Franca**: The user intention becomes the primary artifact. Diagrams become its expression in a particular visual format and representation. Maintaining documentation means evolving intentions.

**Executable Descriptions**: Descriptions must be precise, complete, and unambiguous enough to generate meaningful diagrams. This eliminates the gap between intent and visualization.

**Continuous Refinement**: Consistency validation happens continuously, not as a one-time gate. AI analyzes diagrams for clarity, readability, and accuracy as an ongoing process.

**AI-Driven Context**: AI agents gather critical context throughout the intention process, investigating visualization options, layout implications, and domain-specific standards.

**Bidirectional Feedback**: Review feedback informs intention evolution. Comments, suggestions, and requirements become inputs for intention refinement.

**Format Exploration**: Generate multiple diagram approaches from the same intention to explore different optimization targets—clarity, readability, audience, purpose.

## Implementation Approaches

Today, practicing UIDG requires assembling existing tools and maintaining discipline throughout the process. The methodology can be practiced with:

- AI assistants for iterative diagram description development
- AI agents for gathering visual context and best practices
- Diagram generation tools for translating descriptions to visual formats (Mermaid, PlantUML, Graphviz, etc.)
- Version control systems adapted for diagram-first workflows
- Consistency checking through AI analysis of diagram quality

The key is treating user intentions as the source of truth, with diagrams as the generated output that serves the intention rather than the other way around.

## Streamlining UIDG with Commands

The UIDG methodology is significantly enhanced through powerful commands that automate the intention → visualization → formatting workflow:

### The `/diagramlykit.diagram` Command

This command transforms a simple description (the user-prompt) into a complete, structured diagram with automatic format selection:

1. **Automatic Format Detection**: Scans your description to determine the best diagram type (flowchart, architecture, UML, etc.)
2. **Quality Enhancement**: Applies best practices for layout, colors, and readability
3. **Template-Based Generation**: Generates appropriate diagram code based on your requirements
4. **Multi-Format Export**: Creates the diagram in multiple formats (Mermaid, PlantUML, PNG, SVG)

### The `/diagramlykit.architecture` Command

For system architecture diagrams, this command creates comprehensive visual representations:

1. **Architecture Analysis**: Reads and understands system requirements and component relationships
2. **Best Practice Compliance**: Ensures alignment with architectural diagram standards
3. **Component Translation**: Converts system requirements into visual component representations
4. **Detailed Documentation**: Generates supporting details for components, connections, and interactions
5. **Layout Optimization**: Produces well-organized diagrams with clear hierarchies

### The `/diagramlykit.flow` Command

After a process description is provided, this command analyzes the flow and generates a process diagram:

1. **Inputs**: Reads your process description (required) and, if present, system requirements and constraints
2. **Flow Derivation**: Converts processes, decisions, and scenarios into visual flow elements
3. **Optimization**: Suggests improvements to process flows and decision points
4. **Output**: Generates flowcharts in multiple formats, ready for review and iteration

### Example: Diagramming a Chat Feature

Here's how these commands transform the traditional diagramming workflow:

**Traditional Approach:**

```text
1. Draw system components manually (1-2 hours)
2. Connect relationships manually (30-60 minutes)
3. Format and style the diagram (30-60 minutes)
4. Iterate based on feedback (multiple hours)
Total: ~3-5 hours of manual work
```

**UIDG with Commands Approach:**

```bash
# Step 1: Generate the architecture diagram (2 minutes)
/diagramlykit.diagram Real-time chat system with message history and user presence. The system includes a WebSocket server, PostgreSQL database, Redis cache, and load balancer.

# This automatically:
# - Detects this is an architecture diagram
# - Generates appropriate component layout
# - Creates the diagram in Mermaid format
# - Exports as PNG and SVG

# Step 2: Generate user flow diagram (2 minutes)
/diagramlykit.flow Create a flowchart showing how a user sends a message from their client to the WebSocket server, which stores in PostgreSQL and broadcasts to other users.

# Step 3: Generate data model diagram (2 minutes)
/diagramlykit.uml Generate a class diagram for Message, User, and ChatRoom classes with their relationships.

# This automatically creates:
# - diagrams/001-chat-system/
# - diagrams/001-chat-system/architecture.mmd
# - diagrams/001-chat-system/flow.mmd
# - diagrams/001-chat-system/classes.mmd
# - diagrams/001-chat-system/architecture.png
# - diagrams/001-chat-system/flow.png
# - diagrams/001-chat-system/classes.png
```

In 6 minutes, you have:

- A complete system architecture diagram with components and relationships
- A detailed user flow diagram with process steps
- A class diagram for data models and relationships
- All diagrams properly formatted and exported in visual formats

### The Power of Structured Automation

These commands don't just save time—they enforce consistency and quality:

1. **No Forgotten Details**: Templates ensure every aspect is considered, from visual hierarchy to best practices
2. **Traceable Decisions**: Every diagram choice links back to specific requirements
3. **Living Documentation**: Diagrams stay in sync with requirements because they generate from them
4. **Rapid Iteration**: Change requirements and regenerate diagrams in minutes, not hours

The commands embody UIDG principles by treating user intentions as executable artifacts rather than static descriptions. They transform the diagramming process from a tedious task into the driving force of documentation.

### Template-Driven Quality: How Structure Constrains LLMs for Better Outcomes

The true power of these commands lies not just in automation, but in how the templates guide LLM behavior toward higher-quality diagrams. The templates act as sophisticated prompts that constrain the LLM's output in productive ways:

#### 1. **Preventing Premature Visualization Details**

The diagram specification template explicitly instructs:

```text
- ✅ Focus on WHAT components exist and WHY they're connected
- ❌ Avoid HOW to layout (no specific positioning, colors, fonts)
```

This constraint forces the LLM to maintain proper abstraction levels. When an LLM might naturally jump to "position component at x,y coordinates," the template keeps it focused on "these components need to communicate." This separation ensures diagrams remain focused on meaning rather than appearance.

#### 2. **Forcing Explicit Clarification Markers**

Both templates mandate the use of `[NEEDS CLARIFICATION]` markers:

```text
When creating this diagram from a user description:
1. **Mark all ambiguities**: Use [NEEDS CLARIFICATION: specific question]
2. **Don't guess**: If the description doesn't specify something, mark it
```

This prevents the common LLM behavior of making plausible but potentially incorrect assumptions. Instead of guessing that "user connects to system" means direct connection, the LLM must mark it as `[NEEDS CLARIFICATION: connection type not specified - direct, through API, via gateway?]`.

#### 3. **Structured Thinking Through Checklists**

The templates include comprehensive checklists that act as "unit tests" for the diagram:

```markdown
### Diagram Completeness
- [ ] No [NEEDS CLARIFICATION] markers remain
- [ ] Components are clearly labeled
- [ ] Relationships have clear meaning
- [ ] Diagram serves its intended purpose
```

These checklists force the LLM to self-review its output systematically, catching gaps that might otherwise slip through. It's like giving the LLM a quality assurance framework.

#### 4. **Best Practice Compliance Through Gates**

The diagram template enforces visualization principles through quality gates:

```markdown
### Quality Gates
#### Clarity Gate
- [ ] No more than 7 main components?
- [ ] Clear visual hierarchy?
#### Best Practice Gate
- [ ] Following domain conventions?
- [ ] Appropriate diagram type for purpose?
```

These gates prevent over-complicated diagrams by making the LLM explicitly justify complexity. If a gate fails, the LLM must document why in the "Complexity Tracking" section, creating accountability for visualization decisions.

#### 5. **Hierarchical Detail Management**

The templates enforce proper information architecture:

```text
**IMPORTANT**: This diagram description should remain high-level and readable.
Any detailed attributes, complex relationships, or extensive sub-components
must be placed in the appropriate `details/` file
```

This prevents the common problem of diagrams becoming cluttered and unreadable. The LLM learns to maintain appropriate detail levels, extracting complexity to separate files while keeping the main diagram focused.

#### 6. **Format-First Thinking**

The implementation template enforces appropriate format selection:

```text
### Diagram Type Selection
1. Choose `flowchart` for process flows and workflows
2. Choose `architecture` for system components and relationships
3. Choose `uml` for class models and object interactions
4. Choose `sequence` for communication flows between components
```

This ordering constraint ensures the LLM thinks about the appropriate visualization format before generating details, leading to more semantically appropriate diagrams.

#### 7. **Preventing Overly Complex Diagrams**

Templates explicitly discourage unnecessary complexity:

```text
- [ ] No speculative or "might be needed" components
- [ ] All elements have clear purpose and meaning
```

This stops the LLM from adding "nice to have" components that make diagrams cluttered. Every component must trace back to a concrete requirement with clear purpose.

### The Compound Effect

These constraints work together to produce diagrams that are:

- **Complete**: Checklists ensure nothing important is forgotten
- **Clear**: Forced clarification markers highlight ambiguities
- **Appropriate**: Format-first thinking baked into the process
- **Maintainable**: Proper abstraction levels and information hierarchy
- **Meaningful**: Clear purpose with concrete requirements

The templates transform the LLM from a creative artist into a disciplined diagram engineer, channeling its capabilities toward producing consistently high-quality, executable diagrams that truly serve communication needs.

## The Constitutional Foundation: Enforcing Visualization Discipline

At the heart of UIDG lies a constitution—a set of immutable principles that govern how user intentions become diagrams. The constitution (`memory/constitution.md`) acts as the visualization DNA of the system, ensuring that every generated diagram maintains consistency, clarity, and quality.

### The Seven Articles of Visualization

The constitution defines seven articles that shape every aspect of the diagram generation process:

#### Article I: User-First Principle

Every diagram must begin with user needs—no exceptions. This forces purposeful design from the start:

```text
Every diagram in Diagramly MUST begin its existence with clear user purpose.
No diagram shall be generated without first establishing who will view it
and what they need to understand from it.
```

This principle ensures that diagrams serve communication needs rather than existing as abstract visualizations. When the LLM generates a diagram, it must consider the audience and purpose first.

#### Article II: Clarity Mandate

Every diagram must be immediately comprehensible:

```text
All diagrams MUST:
- Convey their purpose within 5 seconds of viewing
- Use consistent symbols and representations
- Include necessary labels and legends
```

This enforces communication over complexity. The LLM cannot create visually complex diagrams without clear justification.

#### Article III: Evolution-First Principle

The most transformative article—diagrams must be easily modifiable:

```text
This is NON-NEGOTIABLE: All diagrams MUST be easily regenerated from source intentions.
No diagram shall exist without its generation source being available and clear:
1. Original user description preserved
2. Generation commands documented
3. Source format available for modification
```

This completely inverts traditional diagramming. Instead of creating a visual and losing the source, UIDG preserves the source intention for easy iteration.

#### Articles IV & V: Simplicity and Clarity

These paired articles combat over-complication:

```text
Section 4.3: Minimal Component Count
- Maximum 7 main components in primary view
- Additional components require separate detailed view

Section 5.1: Purpose Clarity
- Single, clear purpose per diagram
- No mixed visualization types
```

When an LLM might naturally create complex, multi-purpose diagrams, these articles force it to justify every element. The diagram template's "Quality Gates" directly enforce these principles.

#### Article VII: Audience-First Visualization

Prioritizes real-world understanding over technical accuracy:

```text
Diagrams MUST consider the audience first:
- Use familiar symbols and metaphors
- Avoid jargon unless audience expects it
- Include context for technical elements
```

This ensures generated diagrams work for their intended audience, not just for technical completeness.

### Constitutional Enforcement Through Templates

The diagram template operationalizes these articles through concrete checkpoints:

```markdown
### Quality Gates
#### Clarity Gate (Article II)
- [ ] Understood in 5 seconds?

#### User Purpose Gate (Article I)
- [ ] Clear audience identified?
- [ ] Clear purpose stated?

#### Evolution Gate (Article III)
- [ ] Source description preserved?
- [ ] Easy to modify?
```

These gates act as quality checks for visualization principles. The LLM cannot proceed without either passing the gates or documenting justified exceptions in the "Complexity Tracking" section.

### The Power of Immutable Principles

The constitution's power lies in its immutability. While implementation details can evolve, the core principles remain constant. This provides:

1. **Consistency Across Time**: Diagrams generated today follow the same principles as diagrams generated next year
2. **Consistency Across LLMs**: Different AI models produce visually compatible diagrams
3. **Visualization Integrity**: Every diagram reinforces rather than undermines the communication purpose
4. **Quality Guarantes**: Clarity-first, user-first, and simplicity principles ensure communicative diagrams

### Constitutional Evolution

While principles are immutable, their application can evolve:

```text
Section 4.2: Amendment Process
Modifications to this constitution require:
- Explicit documentation of the rationale for change
- Review and approval by project maintainers
- Backwards compatibility assessment
```

This allows the methodology to learn and improve while maintaining stability. The constitution shows its own evolution with dated amendments, demonstrating how principles can be refined based on real-world experience.

### Beyond Rules: A Visualization Philosophy

The constitution isn't just a rulebook—it's a philosophy that shapes how LLMs think about diagram generation:

- **Communication Over Complexity**: Everything must be understandable by the target audience
- **Simplicity Over Cleverness**: Start simple, add complexity only when proven necessary for communication
- **Evolution Over Permanence**: Diagrams must be easily modifiable and regenerable
- **Purpose Over Decoration**: Every element must serve a clear communication need

By embedding these principles into the intention and generation process, UIDG ensures that generated diagrams aren't just visual—they're communicative, clear, and purposeful. The constitution transforms AI from a diagram generator into a communication partner that respects and reinforces visualization design principles.

## The Transformation

This isn't about replacing designers or automating creativity. It's about amplifying human capability by automating mechanical translation. It's about creating a tight feedback loop where user intentions, AI understanding, and visual representation evolve together, each iteration bringing deeper understanding and better alignment between intent and visualization.

Documentation and communication needs better tools for maintaining alignment between user intentions and visual representation. UIDG provides the methodology for achieving this alignment through executable intentions that generate diagrams rather than merely describing them.
