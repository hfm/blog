import rss from '@astrojs/rss';
import { SITE_DESCRIPTION, SITE_TITLE } from '../consts';
import { entryPath, getAllPublishedEntries } from '../lib/posts';

export async function GET(context) {
  const entries = await getAllPublishedEntries();

  return rss({
    title: SITE_TITLE,
    description: SITE_DESCRIPTION,
    site: context.site,
    items: entries.map((entry) => ({
      title: entry.data.title,
      pubDate: entry.data.date,
      description: entry.body.slice(0, 140),
      link: entryPath(entry),
    })),
  });
}
