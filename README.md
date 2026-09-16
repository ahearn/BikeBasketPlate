# Bike Basket Adapter Plate

A parametric OpenSCAD replacement for the basket-side plate of a quick-release
bike basket mount — the part that screws to the basket and clips onto the
bracket bolted to the bike.

![Isometric view](images/iso.png)

## What this fits

Modelled from the plate on a [Bontrager Interchange Handlebar
Basket](https://www.trekbikes.com/us/en_US/equipment/bike-accessories/bike-baskets/bontrager-interchange-handlebar-basket/p/25614/),
part of Bontrager's Interchange quick-release system. The bike-side bracket is
moulded with Japanese and German patent numbers, a Sunny Wheel Industrial
licence notice, and a 5 kg load rating — so other baskets built on the same
licensed mount likely share this geometry, whatever the badge on them says.

This model replaces **only the basket-side plate**. The bike-side bracket, with
its spring-loaded release lever, is unchanged and must still be in working
order.

It was reverse-engineered with calipers from a single broken plate, and
Bontrager has shipped several basket revisions. **Check the key dimensions
below against your own part before printing.**

## How it mounts

Four countersunk screws hold the plate to the basket. To mount the basket, the
plate drops onto the bike-side bracket: the bracket's tongue slides into the
slot formed between the overhanging wings and the plate floor, guided by the
central channel. The bracket's spring lever rides up the ramped latch in that
channel and drops behind it, locking the basket on.

To release, reach through the scoop in the top wall and press the lever on the
bike-side bracket.

![Top view](images/top.png)

## Key dimensions

All heights are absolute, measured from the flat underside of the part.

| Feature | Value |
|---|---|
| Overall | 106 × 77.7 mm |
| Main surface (screw-hole floor) | 11 mm |
| Channel floor | 7.4 mm |
| Perimeter wall / wing tops | 17 mm |
| Central channel width | 32 mm |
| Channel edge to side wall | 31 mm each side |
| Screw holes | 10.1 mm counterbore, 5.4 mm shaft, through |
| Screw hole centres | 46.1 mm across × 44.9 mm down |
| Latch | 8.8 mm ramp + 3.4 mm flat, top flush at 11 mm |
| Latch ramp start | 45.5 mm from the bottom edge |
| Wings | 21.6 mm long, 5.8 mm overhang, 2 mm thick |

The original plate measured 105 mm wide. This model is 106 mm: the side walls
are pushed out 0.5 mm each because a test print gripped the bracket too
tightly. Set `wall_relief = 0` to return to the measured original.

![Half section through the channel](images/section.png)

## Building

Requires [OpenSCAD](https://openscad.org/). A pre-built `basket_adapter_plate.stl`
is included; to regenerate it after changing parameters:

```
openscad -o basket_adapter_plate.stl basket_adapter_plate.scad
```

Every dimension is a named parameter at the top of `basket_adapter_plate.scad`.
Derived values are computed from the measured ones, so changing the channel
width or wall relief moves the wings, slots and screw bosses to match rather
than leaving them stranded.

Parameters marked `not measured` in the source are estimates from photographs —
the corner radius, the top wall width, and the finger scoop, none of which
affect how the part latches.

## Printing

Print flat on the underside, which is the largest flat face and puts every
functional surface in a sensible orientation.

- **Supports:** the wings cantilever 5.8 mm inward over a 4 mm gap and want
  support underneath. Nothing else does.
- **Bridging:** the slots through the top wall bridge 12 mm across their tops
  and print fine unsupported.
- **Material:** print in something with reasonable toughness. The original is
  injection-moulded and the plate carries the full load of the basket; PLA will
  work for a test fit but PETG, ABS or ASA is a better choice for actual riding.
- The mount is rated for 5 kg. A printed part is not guaranteed to match the
  original's strength — load it conservatively and check it periodically.

## Status

Printed and test-fitted. The current revision corrects the side wall spacing
and relieves the wing pinch found on the first print.

## License

MIT — see [LICENSE](LICENSE).
