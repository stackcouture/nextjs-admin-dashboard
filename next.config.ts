import { NextConfig } from 'next';
import { Configuration, RuleSetRule } from 'webpack';

const nextConfig: NextConfig = {
  reactStrictMode: true,
  webpack(config: Configuration): Configuration {
    config.module = config.module ?? {};
    config.module.rules = config.module.rules ?? [];

    config.module.rules.push({
      test: /\.svg$/,
      use: ['@svgr/webpack'],
    } as RuleSetRule);

    return config;
  },
};

export default nextConfig;
