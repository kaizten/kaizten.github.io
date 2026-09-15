export type Section = {
  slug: string;
  label: string;
  showInMenu: boolean;
  pages: string[];
};

export const sections: Section[] = [
  {
    slug: "tools",
    label: "Tools",
    showInMenu: true,
    pages: [
      "dataset-diff",
      "dockerfile-with-entrypoint",
      "file-server",
      "github-issue-manager",
      "grafana-json-rest-plugin",
      "json-validator",
      "kaizten-control-center",
      "kaizten-copilot-extension",
      "kaizten-request-tool",
      "kaizten-task-lite",
      "kaizten-signature-sheets-generator",
      "openapi-code-generator",
      "openapi-viewer",
      "sheriff",
      "tabular-analyzer",
      "tabular-merge",
      "tabular-sampler",
      "tabular-splitter",
      "tabular-to-json",
      "test-simulation",
      "uri-content-to-output",
      "websocket-client",
      "yaml-validator",
    ],
  },
  {
    slug: "development",
    label: "Development",
    showInMenu: true,
    pages: [
      "apis",
      "guides",
      "releases"
    ],
  },
  {
    slug: "products",
    label: "Products",
    showInMenu: true,
    pages: [
      "agriculture-manager",
      "aidel",
      "entomology-manager",
      "itinerary-planner",
      "kaizten-task",
      "kalyptia",
      "kentaro",
      "pit-manager",
      "portalis",
      "scenario-editor",
      "simulation-modeler"
    ],
  },
  {
    slug: "partners",
    label: "Partners",
    showInMenu: true,
    pages: [
      "sagulpa",
      "la-gaviota"
    ],
  },
  {
    slug: "internship",
    label: "Internship",
    showInMenu: true,
    pages: [
      "projects",
      "requirements",
      "topics"
    ],
  },
  {
    slug: "teaching",
    label: "Teaching",
    showInMenu: true,
    pages: [
      "courses",
      "materials",
      "sessions"
    ],
  },
  {
    slug: "problems",
    label: "Problems",
    showInMenu: false,
    pages: [
      "datasets",
      "cases",
      "models"
    ],
  },
  {
    slug: "Company identity",
    label: "Company Identity",
    showInMenu: true,
    pages: [
      "projects",
      "requirements",
      "topics"
    ],
  },
];

export function getSection(slug: string): Section | undefined {
  return sections.find((section) => section.slug === slug);
}

export function titleFromSlug(slug: string): string {
  return slug
    .split("-")
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join(" ");
}
