import type { NextConfig } from "next";
import type { Configuration, RuleSetRule } from "webpack";

const nextConfig: NextConfig = {
  webpack(config: Configuration): Configuration {
    config.module = config.module ?? {};
    
    config.module.rules = config.module.rules ?? [];

    config.module.rules.push({
      test: /\.svg$/,
      use: ["@svgr/webpack"],
    } as RuleSetRule);

    return config;
  },
};

export default nextConfig;
