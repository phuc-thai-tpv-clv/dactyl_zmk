# Dactyl Manuform ZMK Project

Project starter for a split keyboard inspired by the Dactyl Manuform.

- Firmware: ZMK
- Controller: nice!nano
- Layout target: split, 6x6 matrix per half starter
- Case workflow: OpenSCAD parametric starter

## Repository Layout

- `config/`: ZMK configuration repo content
- `config/boards/shields/dactyl_manuform/`: custom shield definition
- `case/scad/`: parametric OpenSCAD starter for a Dactyl-style shell
- `docs/`: design notes and hardware mapping checklist

## What Is Included

- Custom ZMK shield scaffold for `dactyl_manuform`
- Split keymap starter with layers for base, lower, raise, adjust
- Pin mapping placeholders for `nice!nano`
- Parametric OpenSCAD file to begin shaping a Dactyl-style case
- Build matrix for left and right halves

## Important Assumptions

This starter intentionally makes a few safe assumptions so we can get the project moving:

1. Each half uses one `nice!nano`
2. The initial matrix is modeled as `6 rows x 6 columns` per half
3. The matrix wiring and final thumb cluster geometry still need to be matched to your real hardware
4. The OpenSCAD model is a starter blockout, not a finished ergonomic shell

## Next Things To Customize

1. Update the GPIO pins in `config/boards/shields/dactyl_manuform/dactyl_manuform_{left,right}.overlay`
2. Refine the matrix transform if your physical switch order differs from the starter
3. Adjust the keymap in `config/dactyl_manuform.keymap`
4. Evolve the case in `case/scad/dactyl_manuform_case.scad`

## Build With ZMK GitHub Actions

This repo is prepared like a normal ZMK config repo.

1. Create a new GitHub repository and push this project
2. Fork `zmkfirmware/zmk` if you want to customize firmware deeply, otherwise use upstream in `config/west.yml`
3. Enable GitHub Actions
4. Run the workflow and download firmware artifacts for:
   - `dactyl_manuform_left nice_nano_v2`
   - `dactyl_manuform_right nice_nano_v2`

## Local Build Outline

Typical local build flow after cloning ZMK dependencies:

```bash
west init -l config
west update
west zephyr-export
west build -s zmk/app -b nice_nano_v2 -- -DSHIELD=dactyl_manuform_left
west build -p -d build/right -s zmk/app -b nice_nano_v2 -- -DSHIELD=dactyl_manuform_right
```

## Flash Outline

1. Put one `nice!nano` into bootloader mode
2. Copy the generated UF2 for the matching side
3. Repeat for the other half
4. Pair and test the key matrix

## Recommended Hardware Notes

- Add reset access in the case design
- Reserve internal space for battery and power switch
- Leave clearance for USB-C and antenna orientation
- Keep the battery away from sharp printed edges

