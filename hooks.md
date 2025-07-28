# Hook Implementation and Testing in OpenCode

## Changes Made

1. **Shell Command Fix**:

   - Edited `packages/opencode/src/cli/cmd/run.ts` to execute hook commands using `/bin/sh -c`.
   - This enabled proper interpretation of shell operators like `&&` and `>>`.

2. **Binary Building**:

   - Used Bun's `bun build --compile` to build a standalone binary named `opencode-test`.
   - Ensured the binary executed and respected the hooks feature.

3. **Warning Suppression**:
   - Observed a warning about wildcard sideEffects from the `zod-openapi` dependency.
   - Edited `bunfig.toml` to suppress the warning by adding a `[bundle]` section and setting `logLevel = "error"`.

## Process

### Building the Binary

1. Clone [my fork of opencode](https://github.com/jgaines/opencode).
2. Check out the branch `hooks`.
3. Navigate to the project directory.
4. Ensure you have Bun version 1.2.14 or later installed.
5. Run `bun install` to install all dependencies.
6. Execute the following command to create the binary:
   ```bash
   bun build --compile --outfile=opencode-test packages/opencode/src/index.ts
   ```

**Note**: The build process takes approximately 200-250ms and produces a ~106MB executable. The binary will be created as `opencode-test` in the current directory and is fully functional for testing hooks.

### Testing the Hooks

1. Execute the binary `opencode-test`.
2. Verify that hooks set by `OPENCODE_PROMPT_ENTERED` and `OPENCODE_PROMPT_DONE` fire correctly.
3. Ensure the shell commands including operators `&&` and `>>` are executed properly.

### Suppressing Warnings

1. Edit the root `bunfig.toml`.
2. Add `[bundle]` section with `logLevel = "error"` to suppress wildcard sideEffects warnings from dependencies.

### Notes

- Hooks were verified to work both in the source code execution and the compiled binary.
- The binary, `opencode-test`, has a file size of around 106MB.
- Consider keeping the binary unless file storage is a concern.

This documentation aids future developers in understanding the current configuration and setup process within OpenCode.
