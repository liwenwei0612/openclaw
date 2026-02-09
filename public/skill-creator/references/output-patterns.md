# Output Patterns

Patterns for designing skill outputs and quality standards.

## Template Patterns

### Basic Template

```markdown
## Output Format

```
[Section 1: Header]
- Item 1
- Item 2

[Section 2: Details]
Description here...

[Section 3: Summary]
Key points...
```
```

### Variable Substitution

```markdown
## Template with Variables

Use these placeholders:
- `{{NAME}}` - User or project name
- `{{DATE}}` - Current date
- `{{STATUS}}` - Status indicator
- `{{DETAILS}}` - Variable content

**Example**:
```
Project: {{NAME}}
Created: {{DATE}}
Status: {{STATUS}}

{{DETAILS}}
```
```

## Quality Checklists

### Code Quality

```markdown
## Code Review Checklist

Before completing, verify:
- [ ] Code follows style guidelines
- [ ] No hardcoded values (use constants/config)
- [ ] Error handling is present
- [ ] Comments explain "why", not "what"
- [ ] Tests are included (if applicable)
- [ ] No sensitive data in code
```

### Document Quality

```markdown
## Document Review Checklist

Before completing, verify:
- [ ] Title is clear and descriptive
- [ ] Sections are logically organized
- [ ] All claims have supporting evidence
- [ ] Links are working
- [ ] Formatting is consistent
- [ ] No placeholder text remains
```

## Example Patterns

### Good Example Structure

```markdown
## Example: [Scenario Name]

**Context**: Brief setup
**Input**: What was provided
**Process**: Key steps taken
**Output**: What was produced
**Result**: Outcome achieved
```

### Multiple Examples

```markdown
## Examples

### Simple Case
For straightforward situations...
[Example here]

### Complex Case
For edge cases or complex scenarios...
[Example here]

### Error Case
For handling failures...
[Example here]
```

## Validation Patterns

### Input Validation

```markdown
## Input Requirements

**Required fields**:
- Field 1: Description and format
- Field 2: Description and format

**Optional fields**:
- Field 3: Description and default value

**Validation rules**:
1. Rule 1 and error message
2. Rule 2 and error message
```

### Output Validation

```markdown
## Output Standards

**Must include**:
- Element 1 with criteria
- Element 2 with criteria

**Must not include**:
- Prohibited item 1
- Prohibited item 2

**Quality metrics**:
- Metric 1: Target value
- Metric 2: Target value
```
