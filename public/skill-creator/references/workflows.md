# Workflow Design Patterns

This document provides patterns for designing multi-step workflows in skills.

## Sequential Workflows

For processes that follow a fixed order:

```markdown
## Process

1. **Step 1: Name**
   - Action details
   - Validation criteria
   - Next: Proceed to Step 2

2. **Step 2: Name**
   - Action details
   - Validation criteria
   - Next: Proceed to Step 3

3. **Step 3: Name**
   - Final action
   - Completion criteria
```

## Conditional Workflows

For processes with decision points:

```markdown
## Decision Tree

**Question**: [What needs to be determined?]

- **If [Condition A]**:
  - Action path A
  - Validation for A
  
- **If [Condition B]**:
  - Action path B
  - Validation for B
  
- **If neither**:
  - Fallback action
  - Escalation path
```

## Loop Patterns

For iterative processes:

```markdown
## Iterative Process

**Repeat until** [completion condition]:

1. **Iteration start**
   - Check current state
   
2. **Action**
   - Perform operation
   
3. **Validation**
   - Check if complete
   - If not complete, loop back
```

## Error Handling

Always include error handling:

```markdown
## Error Handling

- **If [Error Condition 1]**:
  - Recovery action
  - Alternative path
  
- **If [Error Condition 2]**:
  - User notification
  - Rollback steps
  
- **Unexpected errors**:
  - Stop and report
  - Do not proceed
```

## State Management

For complex multi-step processes:

```markdown
## State Tracking

Track these variables:
- `current_step`: Where we are in the process
- `validation_passed`: Whether current step is valid
- `retry_count`: Number of retry attempts
- `error_log`: Any issues encountered

**State transitions**:
1. Initialize → Step 1
2. Step 1 complete → Validate → Step 2
3. Validation fails → Retry or Error
4. All steps complete → Success
```
