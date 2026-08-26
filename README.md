# game-configs

Server configuration files for self-hosted game servers, managed as a git repository and deployed to a dedicated Linux host.

## Layout

| Path | Description |
| --- | --- |
| `necesse/workshop.txt` | Steam Workshop item IDs for the Necesse dedicated server |
| `quakelive/workshop.txt` | Workshop item IDs (maps, models, misc) for Quake Live |
| `quakelive/mappool.txt` | FFA map rotation for the Quake Live server |

## Deployment

- `deploy_necesse.sh` — copies the Necesse workshop list to the server saves directory.
- `deploy_ql.sh` — copies the Quake Live workshop list and map pool to the server directory.
- `update.sh` — fetches and fast-forwards the repository (`git pull --rebase`).

## Usage

```sh
./update.sh
./deploy_necesse.sh
./deploy_ql.sh
```
