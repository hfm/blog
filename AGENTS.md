# Repository Guidelines

## Project Structure & Module Organization
This repository contains the source for an Astro-based blog. Main articles are stored under `content/post/`, while topic-specific series may use their own section such as `content/nginx/`. Static assets and images live under `static/`. Astro application code lives under `src/`. Writing tone and article style guidance are documented in `WRITING.md`.

## Build, Test, and Development Commands
Use `npm install` to install dependencies. Use `npm run build` to generate the site into `dist/`. Use `npm run dev` for local development. Deployment is handled by Netlify using `netlify.toml`.

## Coding Style & Naming Conventions
Keep Markdown and configuration changes small and readable. Follow the existing content layout: blog posts belong in `content/post/` and use lowercase, hyphenated filenames such as `content/post/my-example-post.md`. Preserve current indentation style in each file. Avoid adding excessive comments. When editing prose, review `WRITING.md` first and match the repository’s established tone.

## Testing Guidelines
There is no separate automated test suite in this repository. Validation is build-based: run `npm run build` and confirm Astro completes without errors. For content changes, verify that permalinks, front matter, and referenced asset paths resolve correctly in the generated `dist/` output.

## Commit & Pull Request Guidelines
Recent commit history shows very short, imperative subjects such as `Fix broken`, `badge`, and `rm`. Prefer concise commit titles under 50 characters that describe the actual change clearly, for example `Add post about Hugo config`. In pull requests, include a short summary, list affected paths, link related issues when applicable, and attach screenshots only for visible style or layout changes.

## Agent-Specific Notes
Respond to repository collaborators in Japanese with a polite `ですます` tone. When making code or content edits, avoid over-commenting and keep changes aligned with the existing repository structure and workflow.
