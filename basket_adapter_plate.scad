// Basket adapter plate — bolts to the basket (4 screws), clips onto the
// bike-mounted bracket. Center channel carries a door-catch style latch bump;
// hook tabs on the side rims engage the bracket.
//
// All Z heights are absolute, measured from the flat underside of the part.

// ---- Overall plate ----
plate_w_nominal = 105;   // as measured on the original
wall_relief     = 1.0;   // side walls pushed out for fit; wings follow them
plate_w  = plate_w_nominal + 2 * wall_relief;
plate_h  = 77.7;
corner_r = 6;      // not measured

// ---- Z datums (underside = 0) ----
main_surface_z  = 11;    // flat area around the screw holes
channel_floor_z = 7.4;   // recessed groove floor
rim_z           = 17;    // top of raised perimeter wall
latch_top_z     = 11;    // flush with main surface
tab_top_z       = 17;    // flush with rim

// ---- Center channel (open through the bottom edge) ----
channel_w = 32;

// ---- Perimeter rim (top, left, right only — bottom edge is open) ----
channel_to_wall = 30.5 + wall_relief;  // measured 30.5, plus the fit relief
rim_w_side = plate_w / 2 - channel_w / 2 - channel_to_wall;
rim_w_top  = 10;         // not measured

// ---- Latch bump: ramp faces the bottom edge so the lever rides up it ----
latch_ramp_run = 8.8;   // slope run along the channel
latch_flat_run = 3.4;   // flat top run along the channel
latch_w        = channel_w;
latch_bottom_from_edge = 45.5;  // ramp start, measured from the plate's bottom edge

// ---- Screw holes (countersunk, through) ----
cbore_d     = 10.1;
cbore_depth = 5.8;
shaft_d     = 5.4;
screw_h_gap = 36;      // edge-to-edge
screw_v_gap = 34.8;    // edge-to-edge
screw_h_pitch = screw_h_gap + cbore_d;  // gaps were measured between counterbore rims
screw_v_pitch = screw_v_gap + cbore_d;

// ---- Hook wings: overhang inward off the side rims, forming a slot with the
//      main surface that the bike bracket's tongue slides into ----
tab_len       = 21.6;  // along the side edge, starting at the top edge
tab_overhang  = 5.8;   // inward past the rim's inner face
tab_thickness = 2;

// ---- Finger scoop: dish in the top rim above the channel, so a finger can
//      reach the bike-side release button. Cosmetic, approximated as a sphere.
scoop_width     = 40;  // across at rim level
scoop_depth     = 6;   // how far below the rim top the sphere bottoms out
scoop_edge_wall = 2;   // wall kept between the scoop and the channel opening

// ---- Rectangular slots through the top perimeter wall, one each side of the
//      channel, sitting on the recessed floor.
slot_w   = 12;
slot_h   = 4;
slot_gap = 8;   // channel edge to the slot's near edge

$fn = 60;

module rounded_rect(w, h, r) {
    hull()
        for (x = [-1, 1], y = [-1, 1])
            translate([x * (w / 2 - r), y * (h / 2 - r)])
                circle(r = r);
}

module body() {
    linear_extrude(height = main_surface_z)
        rounded_rect(plate_w, plate_h, corner_r);
}

module rim() {
    wall_h = rim_z - main_surface_z;
    translate([0, 0, main_surface_z])
        linear_extrude(height = wall_h)
            difference() {
                rounded_rect(plate_w, plate_h, corner_r);
                // void shifted down so the rim covers top/left/right but not bottom
                translate([0, -rim_w_top])
                    square([plate_w - 2 * rim_w_side, plate_h], center = true);
            }
}

module channel_cut() {
    depth = main_surface_z - channel_floor_z;
    translate([-channel_w / 2, -plate_h / 2 - 1, channel_floor_z])
        cube([channel_w, plate_h + 1 - rim_w_top, rim_z - channel_floor_z + 1]);
}

module latch() {
    rise = latch_top_z - channel_floor_z;
    y0 = -plate_h / 2 + latch_bottom_from_edge;
    translate([0, y0, channel_floor_z])
        rotate([90, 0, 90])
            linear_extrude(height = latch_w, center = true)
                polygon([[0, 0],
                         [latch_ramp_run, rise],
                         [latch_ramp_run + latch_flat_run, rise],
                         [latch_ramp_run + latch_flat_run, 0]]);
}

module finger_scoop() {
    // sphere sized so it cuts scoop_width across at rim_z and bottoms out
    // scoop_depth below it
    r = (pow(scoop_width / 2, 2) + pow(scoop_depth, 2)) / (2 * scoop_depth);
    // pushed out past the top edge so a scoop_edge_wall-thick rib survives
    // between the scoop and the channel opening
    y = plate_h / 2 - rim_w_top + scoop_edge_wall + scoop_width / 2;
    translate([0, y, rim_z + r - scoop_depth])
        sphere(r = r, $fn = 120);
}

module wall_slots() {
    z0 = main_surface_z;
    for (side = [-1, 1]) {
        x0 = (side > 0) ? channel_w / 2 + slot_gap
                        : -channel_w / 2 - slot_gap - slot_w;
        translate([x0, plate_h / 2 - rim_w_top - 1, z0])
            cube([slot_w, rim_w_top + 2, slot_h]);
    }
}

module screw_hole() {
    translate([0, 0, main_surface_z - cbore_depth])
        cylinder(d = cbore_d, h = cbore_depth + 1);
    translate([0, 0, -1])
        cylinder(d = shaft_d, h = main_surface_z + 2);
}

module screw_holes() {
    for (x = [-1, 1], y = [-1, 1])
        translate([x * screw_h_pitch / 2, y * screw_v_pitch / 2, 0])
            screw_hole();
}

module hook_tab(side) {
    inner_face = plate_w / 2 - rim_w_side;
    x0 = (side > 0) ? inner_face - tab_overhang : -inner_face;
    translate([x0, plate_h / 2 - tab_len, tab_top_z - tab_thickness])
        cube([tab_overhang, tab_len, tab_thickness]);
}

module basket_adapter_plate() {
    union() {
        difference() {
            union() {
                body();
                rim();
                hook_tab(1);
                hook_tab(-1);
            }
            channel_cut();
            screw_holes();
            finger_scoop();
            wall_slots();
        }
        latch();  // added after the cut, since it lives inside the channel
    }
}

basket_adapter_plate();
