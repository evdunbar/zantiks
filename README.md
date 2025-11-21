# Zantiks MWP Scripts

## Info

These assay and asset generation scripts were originally created for the Zantiks MWP machine used by the Crowder Lab at the University of Alabama at Birmingham. If you are a part of the Crowder Lab, more information can be found in the "Zantiks Assays Explained" presentation in the Google Drive. These types of assays are currently supported:

1. 1-hour Distance
2. Developmental Delay
3. Light/Dark Preference
4. Light/Dark Transition
5. Mirror Biting
6. Sleep
7. Social Preference
8. Startle Response
9. Y-Maze

## Editing

If you are not editing these scripts through the Zantiks web interface and would like syntax highlighting, [tree-sitter-zanscript](https://github.com/elladunbar/tree-sitter-zanscript) is available.

## Data Output

### 1-hour Distance

- bin size: 3600 s
- number of bins: 1
- records: arena and zone distance

### Developmental Delay

- bin size: 1 s
- number of bins: 3600
- records: arena mean square difference

### Light/Dark Preference

- bin size: 60 s
- number of bins: 30
- records: arena and zone distance and time

### Light/Dark Transition

- bin size: 600 s (1 full transition)
- number of bins: 6 (3 light, 3 dark)
- records: arena and zone distance

### Mirror Biting

- bin size: 60 s
- number of bins: 60
- records: arena and zone count, distance, and time

### Sleep

- bin size: 1 s
- number of bins: 75900
- records: arena and zone distance

### Social Preference

- bin size: 1 s
- number of bins: 1800
- records: arena and zone time

### Startle Response

- bin size: 1 s
- number of bins: 8
- records: arena distance

### Y-Maze

- bin size: 60 s
- number of bins: 60
- records: arena and zone count, distance, and time
