import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  site: 'https://useakat.github.io',
  base: '/moshimo',
  integrations: [
    starlight({
      title: 'もしもプロジェクト Wiki',
      description: '科学的知見に基づく「もしも」の世界を描くプロジェクトのドキュメント',
      social: [
        { icon: 'github', label: 'GitHub', href: 'https://github.com/useakat/moshimo' },
      ],
      sidebar: [
        {
          label: 'はじめに',
          items: [
            { label: 'プロジェクト概要', link: '/' },
            { label: '運用ルール', link: '/rules/' },
            { label: '計画', link: '/plan/' },
            { label: 'ブランドガイド', link: '/brand/' },
            { label: '変更ログ', link: '/changelog/' },
          ],
        },
        {
          label: '報告書',
          collapsed: true,
          autogenerate: { directory: 'reports', collapsed: true },
        },
      ],
    }),
  ],
});
