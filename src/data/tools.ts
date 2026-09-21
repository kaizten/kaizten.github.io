import { getSection, titleFromSlug } from "./sections";

export type ToolSubpage = {
  slug: string;
  title: string;
};

export type Tool = {
  slug: string;
  title: string;
  icon: string;
  description: string;
  repositoryUrl: string;
  subpages: ToolSubpage[];
};

const toolMetadata: Record<string, { icon: string; description: string; subpages?: ToolSubpage[] }> = {
  "dataset-diff": { icon: "DIFF", description: "Compare datasets and highlight changes between versions." },
  "dockerfile-with-entrypoint": { icon: "DOCK", description: "Create Dockerfiles with predictable entrypoint behavior." },
  "file-server": { icon: "FILE", description: "Serve local files through a lightweight HTTP endpoint." },
  "github-issue-manager": {
    icon: "GH",
    description: "Organize and track GitHub issues from a focused workflow.",
    subpages: [
      { slug: "issues_app", title: "Issues App" },
      { slug: "issues_full-stack", title: "Issues Full-stack" },
      { slug: "issues_full-stack_existing-project", title: "Issues Full-stack Existing Project" },
      { slug: "issues_java-component", title: "Issues Java Component" },
      { slug: "issues_practicas-empresa", title: "Issues Practicas Empresa" },
      {
        slug: "issues_ull-grado-matematicas_modelos-de-optimizacion",
        title: "Issues Ull Grado Matematicas Modelos De Optimizacion",
      },
      {
        slug: "issues_ull-grado-matematicas_visualizacion-de-datos",
        title: "Issues Ull Grado Matematicas Visualizacion De Datos",
      },
      { slug: "issues_python-component", title: "Issues Python Component" },
    ],
  },
  "grafana-json-rest-plugin": { icon: "GRAF", description: "Connect Grafana dashboards to JSON REST data sources." },
  "json-validator": { icon: "JSON", description: "Validate JSON payloads and catch malformed structures." },
  "kaizten-control-center": { icon: "CTRL", description: "Coordinate Kaizten services from a central control surface." },
  "kaizten-copilot-extension": { icon: "AI", description: "Extend editor workflows with Kaizten Copilot support." },
  "kaizten-request-tool": { icon: "REQ", description: "Build, send, and inspect structured service requests." },
  "kaizten-task-lite": { icon: "TASK", description: "Manage lightweight task workflows for Kaizten projects." },
  "kaizten-signature-sheets-generator": { icon: "SIGN", description: "Generate signature sheets for operational documents." },
  "openapi-code-generator": { icon: "API", description: "Generate code artifacts from OpenAPI specifications." },
  "openapi-viewer": { icon: "VIEW", description: "Browse OpenAPI definitions in a readable interface." },
  "sheriff": { 
    icon: "QA", 
    description: "Review project conventions and enforce quality checks.",
    subpages: [
      { slug: "description", title: "Description" }
    ]
  },
  "tabular-analyzer": { icon: "TAB", description: "Inspect tabular data and summarize its structure." },
  "tabular-merge": { icon: "MERG", description: "Combine compatible tabular files into one dataset." },
  "tabular-sampler": { icon: "SAMP", description: "Extract representative samples from tabular data." },
  "tabular-splitter": { icon: "SPLT", description: "Split tabular files into smaller focused outputs." },
  "tabular-to-json": { icon: "CONV", description: "Convert tabular data into JSON documents." },
  "test-simulation": { icon: "SIM", description: "Run simulation-oriented checks for test scenarios." },
  "uri-content-to-output": { icon: "URI", description: "Fetch URI content and write it to an output target." },
  "websocket-client": { icon: "WS", description: "Connect to WebSocket endpoints and inspect messages." },
  "yaml-validator": { icon: "YAML", description: "Validate YAML documents and surface syntax issues." },
};

const defaultToolSubpages: ToolSubpage[] = [
  { slug: "usage", title: "Usage" },
  { slug: "examples", title: "Examples" },
];

const toolsSection = getSection("tools");

export const tools: Tool[] = (toolsSection?.pages ?? []).map((slug) => {
  const metadata = toolMetadata[slug] ?? {
    icon: "TOOL",
    description: "Open this tool page for details.",
  };

  return {
    slug,
    title: titleFromSlug(slug),
    icon: metadata.icon,
    description: metadata.description,
    repositoryUrl: `https://github.com/kaizten/${slug}`,
    subpages: metadata.subpages ?? defaultToolSubpages,
  };
});

export function getTool(slug: string): Tool | undefined {
  return tools.find((tool) => tool.slug === slug);
}
