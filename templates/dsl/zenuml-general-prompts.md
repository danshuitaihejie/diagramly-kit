/**
 * ZenUML General Prompts
 */
import {
	type DiagramPromptConfig,
	PromptTemplate,
} from "../value-objects/prompt-config";

/**
 * ZenUML General 新建图表 Prompt
 */
export const ZENUML_GENERAL_NEW_PROMPT = `
ZenUML is a code to diagram language with a DSL defined for creating sequence diagrams. 
 
Rule and syntax with example below: 
 
----------------------------------
// Async Message from Name1 to Name2 
Name1 -> Name2:messageText 
 
// Sync Message from Name1 to Name2, no Spaces in messageText 
Name1 -> Name2.messageText(){ 
  // interactions between Sync Messages with activation bar 
} 
 
// Return Message use @return keyword, from Name2 to Name1 
@return Name2->Name1: messageText 
 
// If, use if(condition) with {}, optional use else {} 
if(condition){ 
  // scope of a activation bar 
  // any interactions between 
} 
 
// Loop, for repeated tasks, use loop(condition) keyword with {} 
loop(condition) { 
  // in scope interactions 
} 
// optional 
else { 
  // in scope else interactions 
} 
 
// Optional use opt keyword with {}, no (conditon) here 
opt{ 
  // in scope interactions 
} 
 
// parallel interactions, use par keyword with {} 
par{ 
  // in scope interactions 
} 
 
// coloring, add (StandardCSSColorName) in comment line before any message 
e.g: 
// (red) some comment 
"Name1" -> "Name2":messageText 
----------------------------------
 
Please you read the user input story, model the process and  create the sequence diagram in it with ZenUML language follow below rules. If you are given a ZenUML DSL, see where you can improve it.
 
- a solid line with a [solid arrowhead] means Sync Message 
- a solid line with a [lined arrowhead] means Sync Message 
- [a dashed line with a lined arrowhead] means Return Message, use @return 
- read very carefully regarding the differences between types of messages, this is the key of diagraming 
- if unknown scope keyword, always use opt 
- replace all [-->] or [->>] or [<-] with [->] 
- No spaces in any message names
==============================
Pay extra attention to the message type: sync or async.
Key distinction:
- Async (->:) = no quotes around description
- Sync (->) = quotes required around description if there are spaces (e.g. "two words"); no quotes on singleWord or singleWord().

==============================
Participant name rules:
- Double quotes are required for participant names with spaces or any other special chars.
Wrong:
Client->DNS Server.resolveHostname()
DNS Server->Client: ipAddress
Right:
Client->"DNS Server".resolveHostname()
"DNS Server"->Client: ipAddress

==============================
Message nesting in Sync message
Message nesting is extremely import for this DSL. Carefully think about whether a message is a nested message of another one.
Example:
A->B.method() {
  B->C.nestedMethod()
}

**IMPORTANT: Return/Reply Messages in Nested Context**
Use the \`return\` keyword ONLY when the reply message is sending back to the source of the container message. This avoids unnecessarily explicit participant naming for direct reply messages.

Use \`return\` pattern when replying to the caller:
Bad example: 
A->B.method() {
  B->A: result
}

Good example: 
A->B.method() {
  return result 
}

DO NOT use \`return\` when sending to a different participant:
A->B.method() {
  B->C: result
}

Preferred way for messages to different participants:
A->B.method() {
  // use @return only when it is semantically a return/reply message
  @return C: result
}

Rule: Only use \`return\` for direct replies to the calling participant within nested message blocks.

==============================
Quote for message rules:
- Async messages (source -> target: description): Remove quotes from description
- Sync messages (A->B."description with spaces or special chars"): Keep quotes around description
- Sync messages (A->B.singleWord() or A->B.singleWord ): No quotes around single-word

Examples:
✓ A->B: Detects diagram type from text (async)
✓ A->B."description with quotes" (sync)
✓ A->B.singleWordMethod() (sync)

✗ A->B: "Detects diagram type from text" (async with incorrect quotes)
✗ A->B.description without quotes (sync missing quotes)
✗ A->B."noDoubleQuotesNeeded"() (sync with unnecessary quotes)

=============================
Message length rules
If message is longer than 20 chars, reduce it to less than 20 chars and add details to comments

Right:
// HTML contains pre class="mermaid" with zenuml content
User -> "HTML Document": HTML with zenuml DSL

Wrong:
User -> "HTML Document": HTML contains pre class="mermaid" with zenuml content

==============================
if's condition rules
We must use a single word or quoted string or an expression like 'a > b'. 
Right examples: 
✓ if (a > b) if (a == 0) 
✓ if ("some condition is satisfied")

Wrong example: 
✗ if(valid and approved)
`;

/**
 * ZenUML General 修改图表 Prompt
 */
export const ZENUML_GENERAL_MODIFY_PROMPT = `
You are helping to modify an existing ZenUML diagram. ZenUML is a code to diagram language with a DSL defined for creating sequence diagrams. 
 
ZenUML is a code to diagram language with a DSL defined for creating sequence diagrams. 
 
Rule and syntax with example below: 
 
----------------------------------
// Async Message from Name1 to Name2 
Name1 -> Name2:messageText 
 
// Sync Message from Name1 to Name2, no Spaces in messageText 
Name1 -> Name2.messageText(){ 
  // interactions between Sync Messages with activation bar 
} 
 
// Return Message use @return keyword, from Name2 to Name1 
@return Name2->Name1: messageText 
 
// If, use if(condition) with {}, optional use else {} 
if(condition){ 
  // scope of a activation bar 
  // any interactions between 
} 
 
// Loop, for repeated tasks, use loop(condition) keyword with {} 
loop(condition) { 
  // in scope interactions 
} 
// optional 
else { 
  // in scope else interactions 
} 
 
// Optional use opt keyword with {}, no (conditon) here 
opt{ 
  // in scope interactions 
} 
 
// parallel interactions, use par keyword with {} 
par{ 
  // in scope interactions 
} 
 
// coloring, add (StandardCSSColorName) in comment line before any message 
e.g: 
// (red) some comment 
"Name1" -> "Name2":messageText 
----------------------------------
 
Please you read the user input story, model the process and  create the sequence diagram in it with ZenUML language follow below rules. If you are given a ZenUML DSL, see where you can improve it.
 
- a solid line with a [solid arrowhead] means Sync Message 
- a solid line with a [lined arrowhead] means Sync Message 
- [a dashed line with a lined arrowhead] means Return Message, use @return 
- read very carefully regarding the differences between types of messages, this is the key of diagraming 
- if unknown scope keyword, always use opt 
- replace all [-->] or [->>] or [<-] with [->] 
- No spaces in any message names
==============================
Pay extra attention to the message type: sync or async.
Key distinction:
- Async (->:) = no quotes around description
- Sync (->) = quotes required around description if there are spaces (e.g. "two words"); no quotes on singleWord or singleWord().

==============================
Participant name rules:
- Double quotes are required for participant names with spaces or any other special chars.
Wrong:
Client->DNS Server.resolveHostname()
DNS Server->Client: ipAddress
Right:
Client->"DNS Server".resolveHostname()
"DNS Server"->Client: ipAddress

==============================
Message nesting in Sync message
Message nesting is extremely import for this DSL. Carefully think about whether a message is a nested message of another one.
Example:
A->B.method() {
  B->C.nestedMethod()
}

**IMPORTANT: Return/Reply Messages in Nested Context**
Use the \`return\` keyword ONLY when the reply message is sending back to the source of the container message. This avoids unnecessarily explicit participant naming for direct reply messages.

Use \`return\` pattern when replying to the caller:
Bad example: 
A->B.method() {
  B->A: result
}

Good example: 
A->B.method() {
  return result 
}

DO NOT use \`return\` when sending to a different participant:
A->B.method() {
  B->C: result
}

Preferred way for messages to different participants:
A->B.method() {
  // use @return only when it is semantically a return/reply message
  @return C: result
}

Rule: Only use \`return\` for direct replies to the calling participant within nested message blocks.

==============================
Quote for message rules:
- Async messages (source -> target: description): Remove quotes from description
- Sync messages (A->B."description with spaces or special chars"): Keep quotes around description
- Sync messages (A->B.singleWord() or A->B.singleWord ): No quotes around single-word

Examples:
✓ A->B: Detects diagram type from text (async)
✓ A->B."description with quotes" (sync)
✓ A->B.singleWordMethod() (sync)

✗ A->B: "Detects diagram type from text" (async with incorrect quotes)
✗ A->B.description without quotes (sync missing quotes)
✗ A->B."noDoubleQuotesNeeded"() (sync with unnecessary quotes)

=============================
Message length rules
If message is longer than 20 chars, reduce it to less than 20 chars and add details to comments

Right:
// HTML contains pre class="mermaid" with zenuml content
User -> "HTML Document": HTML with zenuml DSL

Wrong:
User -> "HTML Document": HTML contains pre class="mermaid" with zenuml content

==============================
if's condition rules
We must use a single word or quoted string or an expression like 'a > b'. 
Right examples: 
✓ if (a > b) if (a == 0) 
✓ if ("some condition is satisfied")

Wrong example: 
✗ if(valid and approved)

Current diagram:
\`\`\` 
{CURRENT_CODE}
\`\`\` 

Modification request:
{COMMAND}

Please update the ZenUML DSL according to the request while maintaining the existing structure and style where appropriate.
`;

/**
 * ZenUML General Prompt 配置
 */
export const ZENUML_GENERAL_CONFIG: DiagramPromptConfig = {
	languageKey: "LANG_ZENUML",
	subTypeKey: "GENERAL",
	prompts: {
		[PromptTemplate.NEW]: ZENUML_GENERAL_NEW_PROMPT,
		[PromptTemplate.MODIFY]: ZENUML_GENERAL_MODIFY_PROMPT,
	},
};
