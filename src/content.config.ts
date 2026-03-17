import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const sharedSchema = z.object({
  title: z.string(),
  date: z.coerce.date(),
  tags: z.array(z.string()).optional().default([]),
  cover: z.string().optional(),
  draft: z.boolean().optional().default(false),
});

const post = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './content/post' }),
  schema: sharedSchema,
});

const nginx = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './content/nginx' }),
  schema: sharedSchema,
});

export const collections = { post, nginx };
