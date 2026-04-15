/*
  Dactyl-style case starter.
  This is a blockout to help you iterate geometry quickly in OpenSCAD.
  It is not a finished Manuform shell yet.
*/

$fn = 48;

wall = 2.4;
plate_thickness = 1.8;
key_spacing = 19.0;
rows = 5;
cols = 6;
thumb_keys = 6;
column_curve = 7;
palm_tilt = 18;
column_splay = 4;
body_height = 22;

module switch_cutout() {
    cube([14, 14, plate_thickness + 2], center = true);
}

module key_well() {
    for (c = [0 : cols - 1]) {
        for (r = [0 : rows - 1]) {
            translate([c * key_spacing, 0, -r * key_spacing])
            rotate([r * column_curve, 0, c * column_splay])
            translate([0, 0, body_height])
            difference() {
                cube([18, 18, plate_thickness], center = true);
                switch_cutout();
            }
        }
    }
}

module thumb_cluster() {
    for (i = [0 : thumb_keys - 1]) {
        translate([i * 18 - 18, -38 - i * 2, -16 + i * 3])
        rotate([10 + i * 3, 0, -12 + i * 4])
        difference() {
            cube([18, 18, plate_thickness], center = true);
            switch_cutout();
        }
    }
}

module shell_envelope() {
    hull() {
        translate([0, 0, 0]) sphere(r = 16);
        translate([key_spacing * (cols - 1), 0, -key_spacing * (rows - 1)]) sphere(r = 16);
        translate([key_spacing * 0.5, -58, -34]) sphere(r = 18);
        translate([key_spacing * (cols - 0.5), -18, 10]) sphere(r = 20);
    }
}

module hollow_shell() {
    difference() {
        shell_envelope();
        translate([0, 0, -wall])
        scale([0.88, 0.88, 0.88])
        shell_envelope();
    }
}

module controller_pocket() {
    translate([30, 10, -18])
    cube([38, 18, 8], center = true);
}

module battery_pocket() {
    translate([58, -4, -20])
    cube([42, 22, 8], center = true);
}

module left_half() {
    rotate([0, palm_tilt, 0])
    difference() {
        union() {
            hollow_shell();
            key_well();
            thumb_cluster();
        }
        controller_pocket();
        battery_pocket();
    }
}

left_half();
