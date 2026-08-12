# CV — Le Ba Anh Duc

Personal CV as a static, self-hosted web page. No build step, no dependencies, no
framework: three files and a stylesheet. Prints to a clean A4 PDF straight from the
browser.

**Live:** https://anhduc2k.github.io/cv-le-ba-anh-duc/

---

## Run it

Open `index.html` in a browser. That's the whole workflow.

If you prefer a local server (needed only if you later add `fetch`-based content):

```bash
python3 -m http.server 8000
# http://localhost:8000
```

## Export a PDF

Click **Save as PDF** in the page, or press `Cmd/Ctrl + P`. Print styles force A4 with
11×13 mm margins, always render the light palette regardless of the on-screen theme,
hide the toolbar, and prevent page breaks in the middle of a role.

---

## Structure

```
.
├── index.html            # all content lives here
├── assets/
│   ├── styles.css        # design tokens, layout, print rules
│   └── photo.svg         # portrait placeholder — replace with your own
├── .github/workflows/
│   └── deploy.yml        # publishes to GitHub Pages on push to main
└── .nojekyll             # serve files as-is, skip Jekyll processing
```

## Customising

**Content** — edit `index.html` directly. Sections are plain semantic HTML; a role is
an `<article class="job">` containing one `<div class="stream">` per product or
workstream.

**Portrait** — drop a 3:4 image into `assets/` and point the `<img class="portrait">`
`src` at it. Minimum 300×400 px.

**Colours and type** — every value is a custom property on `:root` in
`assets/styles.css`. Change `--accent` and the whole page follows. Dark mode
redefines the same tokens in two places (`prefers-color-scheme` and
`[data-theme="dark"]`), so components never reference a raw colour.

---

## Deploy

### GitHub Pages via Actions (included)

Push to `main`, then in **Settings → Pages** set **Source** to **GitHub Actions**. The
workflow in `.github/workflows/deploy.yml` uploads the repository root and deploys it.

### GitHub Pages from a branch (simpler)

**Settings → Pages → Source: Deploy from a branch**, pick `main` and `/ (root)`. Delete
`.github/workflows/deploy.yml` if you go this route.

### Anywhere else

It is a static directory. Netlify, Vercel, Cloudflare Pages and any web server will
serve it without configuration.

---

## Browser support

Modern evergreen browsers. Uses `aspect-ratio`, CSS custom properties, `text-wrap:
balance` and `break-inside` — all with graceful fallbacks where unsupported.

## Licence

Code is free to reuse as a template. The CV content, photo and personal details are not.
