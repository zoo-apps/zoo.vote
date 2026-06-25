# Zoo Vote — Vite SPA build, served static via hanzoai/spa.
#
# vite build -> dist/ (SPA). Runtime serves it on :3000 via
# ghcr.io/hanzoai/spa (the canonical Zoo/Hanzo static server, same as
# zooai/computer + zooai/exchange). The wrangler page-function build mode
# (vite build --mode page-function) is for Cloudflare Pages Functions and
# is NOT used in the k8s deploy.
#
# base MUST be '/' (root domain zoo.vote), so GITHUB_ACTIONS must be UNSET
# at build time — vite.config.mts rewrites base to '/zoo.vote/' when it is
# set, and that prefix is only correct for the github.io project-pages URL.

# ─── Build stage ─────────────────────────────────────────────────────
FROM node:24-alpine AS build
RUN apk add --no-cache git python3 make g++
WORKDIR /app

# Manifest first for layer caching (repo ships package-lock.json, npm).
# `npm install` (not `ci`): the committed lock is stale — it pins
# @luxdao/contracts@1.0.1 while package.json now wants @2.0.0 — so `npm ci`'s
# strict-sync check refuses. install resolves from package.json and updates.
# --legacy-peer-deps: @torchauth/vite-plugin-wrangler-spa@2 declares a too-tight
# peer range wrangler@^3.49.0, but the app pins (and runs on) wrangler@^4.
COPY package.json package-lock.json* ./
RUN npm install --no-audit --no-fund --legacy-peer-deps

# Source + SPA build. .git is not in the build context, so the git hash
# is injected explicitly instead of via `git rev-parse`.
COPY . .
ARG GIT_HASH=docker
RUN NODE_OPTIONS=--max-old-space-size=8192 VITE_APP_GIT_HASH="${GIT_HASH}" \
    npx vite build

# ─── Runtime: static SPA via hanzoai/spa (serves /public on :3000) ────
FROM ghcr.io/hanzoai/spa:1.2.0
COPY --from=build /app/dist /public
