import { titleFromSlug } from "./sections";

export type InternshipPage = {
  slug: string;
  title: string;
};

export type InternshipInstitution = {
  slug: string;
  title: string;
  icon: string;
  description: string;
  websiteUrl: string;
  pages: InternshipPage[];
};

const markdownPages = import.meta.glob("../content/internship/*/*.md", { eager: true });

const institutionMetadata: Record<
  string,
  { title: string; icon: string; description: string; websiteUrl: string }
> = {
  ull: {
    title: "Universidad de La Laguna",
    icon: "ULL",
    description: "Internship documentation and onboarding material for ULL students.",
    websiteUrl: "https://www.ull.es",
  },
  ulpgc: {
    title: "Universidad de Las Palmas de Gran Canaria",
    icon: "ULPGC",
    description: "Internship documentation and setup guides for ULPGC students.",
    websiteUrl: "https://www.ulpgc.es",
  },
  unir: {
    title: "Universidad Internacional de La Rioja",
    icon: "UNIR",
    description: "Internship documentation, reports, and infrastructure material for UNIR students.",
    websiteUrl: "https://www.unir.es",
  },
};

const institutionOrder = ["ull", "ulpgc", "unir"];

const pageTitleMetadata: Record<string, string> = {
  "informacion-informes": "Informacion Informes",
  infrastructure: "Infrastructure",
  issues_app: "Issues App",
  "issues_full-stack": "Issues Full-stack",
  "issues_full-stack_existing-project": "Issues Full-stack Existing Project",
  "particion-ubuntu": "Particion Ubuntu",
};

const institutionsBySlug = Object.keys(markdownPages).reduce<Record<string, Set<string>>>(
  (institutions, path) => {
    const match = path.match(/\/internship\/([^/]+)\/([^/]+)\.md$/);

    if (!match) {
      return institutions;
    }

    const [, institution, page] = match;
    institutions[institution] ??= new Set();
    institutions[institution].add(page);
    return institutions;
  },
  {},
);

export const internships: InternshipInstitution[] = Object.entries(institutionsBySlug)
  .map(([slug, pageSlugs]) => {
    const metadata = institutionMetadata[slug] ?? {
      title: titleFromSlug(slug),
      icon: slug.slice(0, 5).toUpperCase(),
      description: "Open this institution page for internship documentation.",
      websiteUrl: "",
    };

    return {
      slug,
      ...metadata,
      pages: Array.from(pageSlugs)
        .sort()
        .map((pageSlug) => ({
          slug: pageSlug,
          title: pageTitleMetadata[pageSlug] ?? titleFromSlug(pageSlug.replaceAll("_", "-")),
        })),
    };
  })
  .sort((first, second) => {
    const firstIndex = institutionOrder.indexOf(first.slug);
    const secondIndex = institutionOrder.indexOf(second.slug);

    if (firstIndex !== -1 || secondIndex !== -1) {
      return (firstIndex === -1 ? Number.MAX_SAFE_INTEGER : firstIndex)
        - (secondIndex === -1 ? Number.MAX_SAFE_INTEGER : secondIndex);
    }

    return first.title.localeCompare(second.title);
  });

export function getInternshipInstitution(slug: string): InternshipInstitution | undefined {
  return internships.find((institution) => institution.slug === slug);
}
