import { getSection, titleFromSlug } from "./sections";

export type ProductSubpage = {
  slug: string;
  title: string;
};

export type Product = {
  slug: string;
  title: string;
  icon: string;
  description: string;
  repositoryUrl: string;
  subpages: ProductSubpage[];
};

const productMetadata: Record<string, { icon: string; description: string; subpages?: ProductSubpage[] }> = {
  "agriculture-manager": {
    icon: "AG",
    description: "Support agricultural planning, monitoring, and operational decisions.",
  },
  aidel: {
    icon: "AI",
    description: "Apply intelligent assistance to data-driven analysis workflows.",
  },
  "entomology-manager": {
    icon: "ENTO",
    description: "Manage entomology data, observations, and related field operations.",
  },
  "itinerary-planner": {
    icon: "PLAN",
    description: "Design and organize itineraries with structured planning support.",
  },
  "kaizten-task": {
    icon: "TASK",
    description: "Coordinate tasks, priorities, and execution across Kaizten projects.",
    subpages: [
      { slug: "introduction", title: "Introduction" },
      { slug: "jwt", title: "JWT" },
      { slug: "operations", title: "Operations" },
      { slug: "register-and-execute-operations", title: "Register and Execute Operations" }
    ],
  },
  kalyptia: {
    icon: "KAL",
    description: "Explore specialized analytics capabilities for Kaizten workflows.",
  },
  kentaro: {
    icon: "KEN",
    description: "Support optimization and decision-making scenarios.",
  },
  "pit-manager": {
    icon: "PIT",
    description: "Manage pit operations with structured planning and control tools.",
  },
  portalis: {
    icon: "PORT",
    description: "Provide portal-style access to Kaizten information and services.",
  },
  "scenario-editor": {
    icon: "SCEN",
    description: "Create, adjust, and inspect scenarios for analysis workflows.",
  },
  "simulation-modeler": {
    icon: "SIM",
    description: "Build and manage simulation models for operational experiments.",
  },
};

const defaultProductSubpages: ProductSubpage[] = [
  { slug: "features", title: "Features" },
  { slug: "use-cases", title: "Use Cases" },
];

const productsSection = getSection("products");

export const products: Product[] = (productsSection?.pages ?? []).map((slug) => {
  const metadata = productMetadata[slug] ?? {
    icon: "PROD",
    description: "Open this product page for details.",
  };

  return {
    slug,
    title: titleFromSlug(slug),
    icon: metadata.icon,
    description: metadata.description,
    repositoryUrl: `https://github.com/kaizten/${slug}`,
    subpages: metadata.subpages ?? defaultProductSubpages,
  };
});

export function getProduct(slug: string): Product | undefined {
  return products.find((product) => product.slug === slug);
}
