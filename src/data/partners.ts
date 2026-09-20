import { titleFromSlug } from "./sections";

export type PartnerPage = {
  slug: string;
  title: string;
  href?: string;
};

export type Partner = {
  slug: string;
  title: string;
  icon: string;
  description: string;
  pages: PartnerPage[];
};

const markdownPages = import.meta.glob("../content/partners/*/*.md", { eager: true });

const partnerMetadata: Record<
  string,
  { title: string; icon: string; description: string; pages?: PartnerPage[] }
> = {
  "la-gaviota": {
    title: "La Gaviota",
    icon: "LG",
    description: "Partner material and operational documentation for La Gaviota.",
    pages: [
      {
        slug: "docker-compose",
        title: "Docker Compose",
        href: "docker-compose.yml",
      },
    ],
  },
  sagulpa: {
    title: "Sagulpa",
    icon: "SAG",
    description: "Partner material and mobility simulation documentation for Sagulpa.",
  },
};

const partnerOrder = [
  "sagulpa", 
  "la-gaviota"
];

const pageTitleMetadata: Record<string, string> = {
  "production-planning": "Production Planning",
  "simulacion-en-movilidad": "Simulacion En Movilidad",
};

const partnersBySlug = Object.keys(markdownPages).reduce<Record<string, Set<string>>>((partners, path) => {
  const match = path.match(/\/partners\/([^/]+)\/([^/]+)\.md$/);

  if (!match) {
    return partners;
  }

  const [, partner, page] = match;
  partners[partner] ??= new Set();
  partners[partner].add(page);
  return partners;
}, {});

export const partners: Partner[] = Object.entries(partnersBySlug)
  .map(([slug, pageSlugs]) => {
    const metadata = partnerMetadata[slug] ?? {
      title: titleFromSlug(slug),
      icon: slug.slice(0, 5).toUpperCase(),
      description: "Open this partner page for documentation.",
    };

    return {
      slug,
      ...metadata,
      pages: [
        ...Array.from(pageSlugs)
          .sort()
          .map((pageSlug) => ({
            slug: pageSlug,
            title: pageTitleMetadata[pageSlug] ?? titleFromSlug(pageSlug.replaceAll("_", "-")),
          })),
        ...(metadata.pages ?? []),
      ],
    };
  })
  .sort((first, second) => {
    const firstIndex = partnerOrder.indexOf(first.slug);
    const secondIndex = partnerOrder.indexOf(second.slug);

    if (firstIndex !== -1 || secondIndex !== -1) {
      return (firstIndex === -1 ? Number.MAX_SAFE_INTEGER : firstIndex)
        - (secondIndex === -1 ? Number.MAX_SAFE_INTEGER : secondIndex);
    }

    return first.title.localeCompare(second.title);
  });

export function getPartner(slug: string): Partner | undefined {
  return partners.find((partner) => partner.slug === slug);
}
