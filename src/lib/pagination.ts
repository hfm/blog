export const POSTS_PER_PAGE = 20;

export function paginateEntries<T>(entries: T[], perPage = POSTS_PER_PAGE) {
  const totalPages = Math.max(1, Math.ceil(entries.length / perPage));

  return Array.from({ length: totalPages }, (_, index) => {
    const currentPage = index + 1;
    const start = index * perPage;
    const end = start + perPage;

    return {
      currentPage,
      totalPages,
      entries: entries.slice(start, end),
    };
  });
}
