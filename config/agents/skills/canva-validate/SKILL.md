---
name: canva-validate
description: Runs Canva monorepo validation commands - linting, typechecking, tests, and dependency fixes. Use when asked to lint, typecheck, test, or validate code in the Canva monorepo.
---

# Canva Validation Commands

Validation and quality check commands for the Canva monorepo.

## Commands

| Command | Description |
|---------|-------------|
| `pnpm fin` | Runs a11y storybook tests, jest tests, taz linting, and typechecking |
| `pnpm fin --only types` | Runs TypeScript typechecking only |
| `pnpm test` | Runs all unit tests (run from `~/work/canva/web`) |
| `taz check` | Runs all linters and formatters |
| `taz check --fix` | Fixes all linting and formatting issues |
| `pnpm lint:deps:fix` | Fixes dependency/import issues and regenerates tsconfig.json files |
| `pnpm lint:ts:types:changed` | Checks types only on changed files |

## Usage

Run commands from the Canva monorepo root (`~/work/canva`).

### Typecheck Only
```bash
pnpm fin --only types
```

### Lint and Fix
```bash
taz check --fix
```

### Run Specific Tests
```bash
cd ~/work/canva/web
pnpm test path/to/test.spec.ts
```
