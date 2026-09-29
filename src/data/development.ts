import { titleFromSlug } from "./sections";

export type DevelopmentPage = {
  slug: string;
  title: string;
  path: string;
};

export type DevelopmentTopic = {
  slug: string;
  title: string;
  pages: DevelopmentPage[];
};

export type DevelopmentTocNode = {
  slug: string;
  title: string;
  path: string;
  href?: string;
  children: DevelopmentTocNode[];
};

const markdownPages = import.meta.glob("../content/development/**/*.md", { eager: true });
const contentFiles = import.meta.glob<string>("../content/development/**/*", {
  eager: true,
  import: "default",
  query: "?url",
});

const topicTitleMetadata: Record<string, string> = {
  "stack-of-technologies": "Stack Of Technologies",
};

const pageTitleMetadata: Record<string, string> = {
  "discarded-technologies": "Discarded Technologies",
  "stack-of-technologies": "Stack Of Technologies",
};

const contentPaths = Object.keys(markdownPages)
  .map((path) => path.match(/\/development\/(.+)\.md$/)?.[1])
  .filter((path): path is string => Boolean(path))
  .sort();

const contentFilePaths = Object.entries(contentFiles)
  .map(([path, url]) => {
    const contentPath = path.match(/\/development\/(.+)$/)?.[1];

    return contentPath
      ? {
          path: contentPath,
          url,
        }
      : undefined;
  })
  .filter((entry): entry is { path: string; url: string } => Boolean(entry))
  .sort((first, second) => first.path.localeCompare(second.path));

function titleForSlug(slug: string): string {
  return pageTitleMetadata[slug] ?? topicTitleMetadata[slug] ?? titleFromSlug(slug.replaceAll("_", "-"));
}

function titleForFile(filename: string): string {
  return filename.endsWith(".md")
    ? titleForSlug(filename.replace(/\.md$/, ""))
    : filename;
}

const topicsBySlug = contentPaths.reduce<Record<string, DevelopmentPage[]>>((topics, contentPath) => {
  const [topic, ...pageParts] = contentPath.split("/");

  if (!topic || pageParts.length === 0) {
    return topics;
  }

  const pageSlug = pageParts.at(-1);

  if (!pageSlug) {
    return topics;
  }

  topics[topic] ??= [];
  topics[topic].push({
    slug: pageParts.join("/"),
    title: titleForSlug(pageSlug),
    path: contentPath,
  });
  return topics;
}, {});

export const developmentRootPages: DevelopmentPage[] = contentPaths
  .filter((contentPath) => !contentPath.includes("/"))
  .map((contentPath) => ({
    slug: contentPath,
    title: titleForSlug(contentPath),
    path: contentPath,
  }))
  .sort((first, second) => first.title.localeCompare(second.title));

export const developmentTopics: DevelopmentTopic[] = Object.entries(topicsBySlug)
  .map(([slug, pages]) => ({
    slug,
    title: titleForSlug(slug),
    pages: pages.sort((first, second) => first.path.localeCompare(second.path)),
  }))
  .sort((first, second) => first.title.localeCompare(second.title));

export const developmentToc: DevelopmentTocNode[] = [];

for (const file of contentFilePaths) {
  const parts = file.path.split("/");
  let siblings = developmentToc;
  let currentPath = "";

  parts.forEach((part, index) => {
    currentPath = currentPath ? `${currentPath}/${part}` : part;
    let node = siblings.find((entry) => entry.slug === part);

    if (!node) {
      const isPage = index === parts.length - 1;
      const isMarkdown = part.endsWith(".md");
      node = {
        slug: part,
        title: isPage ? titleForFile(part) : titleForSlug(part),
        path: currentPath,
        href: isPage && isMarkdown
          ? `development/${currentPath.replace(/\.md$/, "")}/`
          : isPage
            ? file.url
            : `development/${currentPath}/`,
        children: [],
      };
      siblings.push(node);
      siblings.sort((first, second) => first.title.localeCompare(second.title));
    }

    siblings = node.children;
  });
}

export function getDevelopmentTopic(slug: string): DevelopmentTopic | undefined {
  return developmentTopics.find((topic) => topic.slug === slug);
}
