# Contributing to flutter-exam

Thanks for helping out. This page covers the day-to-day workflow so changes stay consistent and easy to review.

## Workflow

1. Open an issue (or pick one) describing the change. Small fixes can skip this.
2. Create a branch from `main`:
   - `feat/<short-name>` for features
   - `fix/<short-name>` for bug fixes
   - `docs/<short-name>` for documentation
   - `chore/<short-name>` for tooling and maintenance
3. Make focused commits. One logical change per commit.
4. Run the checks below before pushing.
5. Open a pull request against `main`. Fill in what changed, why, and how you tested it. Link the issue.
6. Address review comments with follow-up commits (no force-push once review has started).

## Commit messages

Use Conventional Commits:

```
feat: add CSV export for inventory table
fix: handle empty response from quote API
docs: describe environment variables
refactor: extract auth middleware
test: cover checkout webhook retry
chore: bump dependencies
```

Keep the subject line under 72 characters, imperative mood, no trailing period. Add a body when the "why" is not obvious.

## Checks to run

| Check | Command |
| ----- | ------- |
| Analyze | `flutter analyze` |
| Tests | `flutter test` |


## Pull request checklist

- [ ] Code builds and checks pass locally
- [ ] New behavior has tests or a clear reason it cannot be tested
- [ ] Docs updated (`README.md`, `docs/`) if setup, API, or behavior changed
- [ ] No secrets, tokens, or local paths committed
- [ ] Screenshots or a short recording for UI changes

## Reporting bugs

Include: what you did, what you expected, what happened, environment (OS, versions), and logs or a stack trace. A minimal reproduction goes a long way.

## Code of conduct

Be respectful and constructive. Assume good intent, review the code not the person, and keep discussions focused on the change.
