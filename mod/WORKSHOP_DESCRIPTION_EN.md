# World Size Adjuster

Choose independent size targets for Surface and Caves when creating a new Don't Starve Together world.

Features:
- Standard DST mod configuration menu
- Surface and Caves configured independently
- Targets from 100 to 1000
- Server-side only; clients do not need to install it
- Does not crop finished maps or remove required content
- Clear generation and final-grid logging

Technical note: current DST exposes named world-size presets, not arbitrary exact tile dimensions. Every menu entry shows the native `min_size` it really applies. A requested 200×200 therefore uses the safe native `medium` preset (min_size 400); it is not falsely advertised as an exact 200×200 grid. Targets above the native range use `huge` (min_size 450). See the included README for details and verification steps.
