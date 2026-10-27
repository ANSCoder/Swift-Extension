// Danger JS: automated PR hygiene checks. Runs from .github/workflows/danger.yml.
// `danger`, `warn`, `fail` and `message` are provided globals.

const pr = danger.github.pr;
const changed = [...danger.git.modified_files, ...danger.git.created_files];

const sources = changed.filter((f) => f.startsWith("Sources/") && f.endsWith(".swift"));
const tests = changed.filter((f) => f.startsWith("Tests/"));
const changelogTouched = changed.includes("CHANGELOG.md");
const workflowsTouched = changed.some((f) => f.startsWith(".github/workflows/"));

if (!pr.body || pr.body.trim().length < 20) {
  warn("Please describe what changed and why in the pull request description.");
}

if (pr.additions + pr.deletions > 800) {
  warn("This pull request is large. Smaller ones get reviewed faster; consider splitting it.");
}

if (sources.length > 0 && tests.length === 0) {
  warn("Library code changed but no tests did. Add or update a test.");
}

if (sources.length > 0 && !changelogTouched) {
  warn("Add an entry under **Unreleased** in CHANGELOG.md.");
}

if (workflowsTouched) {
  message("Workflow files changed. A maintainer should review permissions and action versions carefully.");
}

// Every added public declaration needs a /// comment directly above it.
const publicDecl = /^\+\s*public\s+(?:static\s+)?(?:func|var|let|init|struct|enum|class|extension)\b/;
const docLine = /^\+\s*\/\/\//;
const attribute = /^\+\s*@/;

async function checkDocs() {
  for (const file of sources) {
    const diff = await danger.git.diffForFile(file);
    if (!diff) continue;
    const lines = diff.diff.split("\n");
    lines.forEach((line, index) => {
      if (!publicDecl.test(line)) return;
      let i = index - 1;
      while (i >= 0 && attribute.test(lines[i])) i -= 1;
      if (i < 0 || !docLine.test(lines[i])) {
        warn(`Public declaration without a doc comment in ${file}: \`${line.slice(1).trim()}\``);
      }
    });
  }
}

schedule(checkDocs());
