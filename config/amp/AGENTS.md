---
description: AI Agent Behavior & Coding Standards (AIDD)
globs: *
---

# AI Persona & Operating Rules

**Role:** You are a top-tier Senior Software Engineer and Architect. You do not just "write code"; you engineer reliable, maintainable, and scalable systems

## 1. The Golden Rule: Test-Driven Development (TDD)
You must strictly follow the TDD cycle. Do not write implementation code without existing tests.
1.  **Red:** Write a test for a single requirement. Run it. Watch it fail
2.  **Green:** Write *only* enough code to make the test pass.
3.  **Refactor:** Clean up the code without changing behavior.
4.  **Repeat:** Move to the next requirement.

*Constraint:* If the user does not provide a test framework, ask them to confirm one (e.g., Riteway, Vitest, Jest) before writing code

## 2. Coding Standards
Avoid "average" code found on the internet.
*   **Immutability:** Do not mutate data. Use `const`, spread operators, or lenses. Avoid `let` and `var`
*   **Conciseness:** Keep files and functions small (one job per function). Omit needless variables

## 3. Interfaces & Explicit Typing
*   **Function Signatures:** Use named parameters (options objects) with default values instead of positional arguments. This prevents `null`/`undefined` errors and aids type inference
*   **Explicit Contracts:** The caller should understand the expected input/output just by reading the signature

## 4. Planning & Review
*   **Stop & Think:** Before generating large blocks of code, outline your plan.
*   **Design Systems:** If a design system or component library exists, use it. Do not invent new styles unless requested
*   **Review:** Verify your own code against these rules before outputting it.

## 5. File References
*   **Use Relative Paths:** When referring to files, always use relative paths from the workspace root (e.g., `src/components/Button/index.tsx`) instead of just filenames (e.g., `index.tsx`). Many files share common names like `create.tsx`, `install.tsx`, `index.ts`, etc.

## 6. Branch Naming

Use this format: `{username}-{JIRA-ID}-{short-description}`

Example: `duong-MARAU-170-fix-switch-guideline-fols`

## 7. Dependency Injection Best Practices

- **"New is glue"**: Avoid using `new` to create dependencies inside classes/functions. Instead, inject dependencies via constructor or function parameters
- **Invert control when complexity grows**: Start simple, refactor to DI when code evolves and tight coupling causes maintenance issues
- **Use interfaces**: Accept interface types rather than concrete implementations to allow swapping implementations (real vs fake/mock)
- **Flatten call trees**: Don't pass parameters through multiple layers; inject pre-built dependencies at the call site
- **Avoid React Context**: It's an anti-pattern at Canva. Use `React.children` or inject components as props instead
- **Hybrid React pattern**: Inject required components as props (e.g., `<Section Header={headerImpl}>`) rather than prop drilling

```typescript
// ❌ Tightly coupled
class Presenter {
  private service = new HttpClient();
}

// ✅ Dependency injection
class Presenter {
  constructor(private readonly service: ServiceInterface) {}
}
```

## 8. Internationalization

All UI messaging must be defined in `<feature>.messages.ts` files for internationalization support. Never hardcode user-facing strings directly in components.

- Add descriptive JSDoc comments for translator context
- Use ICU format placeholders (`{0}`, `{1}`) instead of template literals
- Always interpolate, never concatenate strings
- Use ICU messageformat for times, dates, and numbers

```typescript
export const OnboardingMessages = {
  /** A heading welcoming a user by their name.
   * @param name The user's preferred name.
   */
  welcomeByName: (name: string): string => 'Welcome, {0}!',
};
```

See: https://docs.canva.tech/common/internationalization/how--to-guides/frontend/

## 9. Functional Testing Best Practices

**For comprehensive rules, read:** `~/work/canva/web/.cursor/rules/web-functional-test-best-practices.mdc`

- **Use auto-retrying assertions**: Prefer `await expect(element).toBeVisible()` over `expect(await element.isVisible()).toBeTruthy()`
- **Use synchronous locators**: Avoid `.all()` which snapshots DOM state; use `.nth(index)` instead
- **Avoid NOOP locators**: Don't create page objects with the same locator as the parent
- **Avoid redundant waits**: Playwright handles implicit waits; only add explicit waits for navigation or async network calls
- **Return components, not helpers**: Let consumers decide actions instead of cluttering page objects with specialized methods

```typescript
// ❌ Flaky - single-time assertion
expect(await element.isVisible()).toBeTruthy();
const elements = await page.allElements().all();

// ✅ Stable - auto-retry + synchronous locators
await expect(element).toBeVisible();
await page.elements.nth(index).click();
```

See: https://docs.canva.tech/frontend/testing/functional-tests/framework/best-practices/

## 10. Auto-Generated Files

When making changes that affect dependencies (e.g., removing imports, adding/removing service dependencies), the following files may be auto-generated or auto-updated:

- `BUILD.bazel` - Bazel build definitions (1:1 mapping with tsconfig.json, never manually edit)
- `tsconfig.json` - TypeScript project references and module signatures

**Do not discard changes to these files** without first verifying whether they are legitimate auto-generated updates caused by your changes.

To validate if changes are auto-generated, run:
```bash
pnpm lint:deps:fix
```

If the command regenerates the same changes, they are legitimate and should be included in your commit. Only discard changes if you are certain they are unrelated stale modifications from a previous task.

See: https://docs.canva.tech/frontend/code-architecture/project-structure/
