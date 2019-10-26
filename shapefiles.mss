#necountries {
  [zoom >= 1][zoom < 4] {
    line-width: 0.2;
    [zoom >= 2] {
      line-width: 0.3;
    }
    [zoom >= 3] {
      line-width: 0.4;
    }
    line-color: @admin-boundaries;
  }
}

#ocean-lz,
#ocean,
#ocean-z0,
#ocean-z1,
#ocean-z2,
#ocean-z3,
#ocean-z4,
#ocean-z5,
#ocean-z6 {
  polygon-fill: @ocean-color;
}

#lakes-z0,
#lakes-z1,
#lakes-z2,
#lakes-z3,
#lakes-z4,
#lakes-z5,
#lakes-z6 {
  polygon-fill: @water-color;
}

#rivers-z0,
#rivers-z2,
#rivers-z3,
#rivers-z4,
#rivers-z5,
#rivers-z6 {
  polygon-fill: @river-color;
}

#icesheet-poly {
  [zoom >= 5] {
    polygon-fill: @glacier;
  }
}

#icesheet-outlines {
  [zoom >= 5] {
    [ice_edge = 'ice_ocean'],
    [ice_edge = 'ice_land'] {
      line-width: 0.375;
      line-color: @glacier-line;
      [zoom >= 8] {
        line-width: 0.5;
      }
      [zoom >= 10] {
        line-dasharray: 4,2;
        line-width: 0.75;
      }
    }
  }
}
