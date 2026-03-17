import { getCollection, type CollectionEntry } from 'astro:content';

type Entry = CollectionEntry<'post'> | CollectionEntry<'nginx'>;

export function formatDate(date: Date) {
  return new Intl.DateTimeFormat('en-US', {
    day: 'numeric',
    month: 'short',
    year: 'numeric',
    timeZone: 'Asia/Tokyo',
  }).format(date);
}

export function sortByDateDesc<T extends Entry>(entries: T[]) {
  return entries.toSorted((a, b) => b.data.date.getTime() - a.data.date.getTime());
}

export function entryPath(entry: Entry) {
  if (entry.collection === 'nginx') {
    return `/nginx/${entry.id}/`;
  }

  const year = entry.data.date.getFullYear();
  const month = String(entry.data.date.getMonth() + 1).padStart(2, '0');
  const day = String(entry.data.date.getDate()).padStart(2, '0');
  return `/${year}/${month}/${day}/${entry.id}/`;
}

export function entrySlugParts(entry: Entry) {
  return entryPath(entry).split('/').filter(Boolean);
}

export function buildTagMap(entries: Entry[]) {
  const tags = new Map<string, Entry[]>();

  for (const entry of entries) {
    for (const tag of entry.data.tags ?? []) {
      const current = tags.get(tag) ?? [];
      current.push(entry);
      tags.set(tag, current);
    }
  }

  return new Map(
    [...tags.entries()]
      .map(([tag, taggedEntries]) => [tag, sortByDateDesc(taggedEntries)])
      .sort((a, b) => a[0].localeCompare(b[0], 'ja')),
  );
}

export function buildYearMap<T extends Entry>(entries: T[]) {
  const years = new Map<number, T[]>();

  for (const entry of entries) {
    const year = entry.data.date.getFullYear();
    const current = years.get(year) ?? [];
    current.push(entry);
    years.set(year, current);
  }

  return new Map(
    [...years.entries()]
      .map(([year, yearEntries]) => [year, sortByDateDesc(yearEntries)])
      .sort((a, b) => b[0] - a[0]),
  );
}

export async function getPublishedPosts() {
  return sortByDateDesc(await getCollection('post', ({ data }) => !data.draft));
}

export async function getPublishedNginxPosts() {
  return sortByDateDesc(await getCollection('nginx', ({ data }) => !data.draft));
}

export async function getAllPublishedEntries() {
  return sortByDateDesc([
    ...(await getPublishedPosts()),
    ...(await getPublishedNginxPosts()),
  ]);
}
