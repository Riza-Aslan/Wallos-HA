import json
import urllib.request
import os
import sys
from datetime import datetime

SUPPORT_HEADER = """# Changelog

---

❤️ **Support this project:** If you find this add-on useful, please consider supporting its development:
- [GitHub Sponsors](https://github.com/sponsors/Riza-Aslan)
- [PayPal](https://www.paypal.com/paypalme/rizaaslan)

---
"""

def fetch_releases(repo):
    url = f"https://api.github.com/repos/{repo}/releases?per_page=100"
    headers = {"User-Agent": "Mozilla/5.0"}

    token = os.environ.get("GITHUB_TOKEN")
    if token:
        headers["Authorization"] = f"token {token}"

    req = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.urlopen(req) as response:
            return json.loads(response.read().decode())
    except Exception as e:
        print(f"Error fetching {repo}: {e}")
        return None

wallos_releases = fetch_releases("ellite/Wallos")
ha_releases = fetch_releases("Riza-Aslan/Wallos-HA")

if wallos_releases is None or ha_releases is None:
    print("Failed to fetch releases from one or both repositories. Aborting to prevent overwriting.")
    sys.exit(1)

releases_by_tag = {}

def clean_body(body, tag):
    if not body:
        return ""
    lines = body.split('\n')
    if lines and tag in lines[0] and lines[0].startswith('## '):
        lines = lines[1:]

    while lines and not lines[0].strip():
        lines = lines[1:]

    return '\n'.join(lines).strip()

def process_releases(releases, source):
    for r in releases:
        tag = r.get("tag_name", "").lstrip("v")
        if not tag: continue

        pub_date_str = r.get("published_at")
        if not pub_date_str: continue
        pub_date = datetime.strptime(pub_date_str, "%Y-%m-%dT%H:%M:%SZ")

        if tag not in releases_by_tag:
            releases_by_tag[tag] = {"date": pub_date, "wallos": None, "ha": None}

        if pub_date > releases_by_tag[tag]["date"]:
            releases_by_tag[tag]["date"] = pub_date

        releases_by_tag[tag][source] = clean_body(r.get("body", ""), tag)

process_releases(wallos_releases, "wallos")
process_releases(ha_releases, "ha")

sorted_tags = sorted(releases_by_tag.keys(), key=lambda t: releases_by_tag[t]["date"], reverse=True)

with open("wallos/CHANGELOG.md", "w", encoding="utf-8") as f:
    f.write(SUPPORT_HEADER)

    for tag in sorted_tags:
        date_str = releases_by_tag[tag]["date"].strftime("%Y-%m-%d")

        ha_body = releases_by_tag[tag]["ha"]
        wallos_body = releases_by_tag[tag]["wallos"]

        if not ha_body and not wallos_body:
            continue

        f.write(f"\n## {tag} ({date_str})\n")

        if ha_body and wallos_body:
            f.write("### Wallos-HA\n")
            f.write(ha_body + "\n\n")
            f.write("### Wallos (Upstream)\n")
            f.write(wallos_body + "\n")
        elif ha_body:
            f.write(ha_body + "\n")
        elif wallos_body:
            f.write(wallos_body + "\n")

print("CHANGELOG.md generated successfully.")
