# Repository Guidelines

## Project Structure & Module Organization
This repository contains the source for a Hugo-based blog. Site configuration lives in `config.toml`, and build automation lives in `Makefile`. Main articles are stored under `content/post/`, while topic-specific series may use their own section such as `content/nginx/`. Static assets, generated CSS, and images live under `static/`. SCSS sources are kept in `scss/`. Writing tone and article style guidance are documented in `WRITING.md`.

## Build, Test, and Development Commands
Use `make content` to build the site into `public/`, compile SCSS, and gzip `public/sitemap.xml`. Use `make scss` to rebuild `static/css/style.css` from `scss/` via Compass only. Use `make clean` to remove the generated `public/` directory. Use `hugo -v` directly when you want a quick local build without the full Make target. Deployment is handled by `make deploy`; `make deployn` performs a dry run with `rsync`.

## Coding Style & Naming Conventions
Keep Markdown and configuration changes small and readable. Follow the existing content layout: blog posts belong in `content/post/` and use lowercase, hyphenated filenames such as `content/post/my-example-post.md`. Preserve current indentation style in each file; `config.toml` uses two-space indentation in nested tables. Avoid adding excessive comments. When editing prose, review `WRITING.md` first and match the repository’s established tone.

## Testing Guidelines
There is no separate automated test suite in this repository. Validation is build-based: run `make content` and confirm Hugo completes without errors. For content changes, verify that permalinks, front matter, and referenced asset paths resolve correctly in the generated `public/` output. For styling changes, run `make scss` and inspect the generated CSS diff before building the full site.

## Commit & Pull Request Guidelines
Recent commit history shows very short, imperative subjects such as `Fix broken`, `badge`, and `rm`. Prefer concise commit titles under 50 characters that describe the actual change clearly, for example `Add post about Hugo config`. In pull requests, include a short summary, list affected paths, link related issues when applicable, and attach screenshots only for visible style or layout changes.

## Agent-Specific Notes
Respond to repository collaborators in Japanese with a polite `ですます` tone. When making code or content edits, avoid over-commenting and keep changes aligned with the existing repository structure and workflow.
