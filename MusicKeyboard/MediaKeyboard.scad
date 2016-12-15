$fn = 40;

wallT = 2;
clearance = 0.2;

boardW = 49;
boardD = 26;
boardH = 1.6;

switchW = 6.1;
switchD = switchW;
switchBodyH = 3.1;
switchOD = 3.4;
switchHeadH = 6;
switchZ = wallT+boardH+10;
switchNumber = 5; // Play/Pause  Mute  Next  Vol+  Vol-  WindowsLock

boxD = boardD+2*(wallT+clearance)+2*wallT;
boxH = switchZ+boardH+switchHeadH+switchBodyH+1;


capW = 10;
echo("capW: ", capW);
capD = boardD+2*wallT-clearance;
capH = switchHeadH;


boxW = 2*(wallT+clearance)+(capW+clearance)*switchNumber+clearance;

usbD = 11+1;
usbH = 8+1;

buttonSize = 6;
buttonH = 1;

echo("boxW: ", boxW);
echo("boxH: ", boxH);

module cap() {
  difference() {
    // Add - Cap
    cube([capW, capD, capH]);
    // Remove - Switch
    translate([capW/2-clearance, capD/2-clearance, -1])
      cylinder(r=switchOD/2+clearance, h=capH);
  }
}


module board() {
  color("Purple")
    cube([boardW, boardD, boardH]);
}
module switch() {
  union() {
    color("lightgrey")
      cube([switchW, switchD, switchBodyH]);
    color("darkgrey") translate([switchW/2, switchD/2, switchBodyH])
      cylinder(r=switchOD/2, h=switchHeadH);
  }
}


module mediaKeyboardBox() {
  difference() {
    // ADD - Box
    cube([boxW, boxD, boxH]);
    // Remove - Switch part
    translate([wallT, wallT, wallT+switchZ-boardH])
      cube([boxW-wallT*2, boxD-wallT*2, boxH]);
    // Remove - board part
    translate([wallT, wallT*2, wallT])
      cube([boardW+2*clearance, boxD-wallT*4, boxH]);
    // Remove USB
    translate([-1, wallT*2+0.01, wallT])
      cube([wallT+2, usbD, usbH]);
  }
}

module capPlayPause() {
  union() {
    cap();
    translate([(capW-buttonSize)/2, capD/2-buttonSize/2, capH])
      color("white") linear_extrude(buttonH, center=false)
        resize([buttonSize, buttonSize, 0])
          import("PlayPause.dxf", center=false, convexity=5);
  }
}
module capNext() {
  union() {
    cap();
    translate([(capW-buttonSize)/2, capD/2-buttonSize/2, capH])
      color("white") linear_extrude(buttonH, center=false)
        resize([buttonSize, buttonSize, 0])
          import("Next.dxf", center=false, convexity=5);
  }
}
module capVolumeDown() {
  union() {
    cap();
    translate([(capW-buttonSize)/2, capD/2-buttonSize/2, capH])
      color("white") linear_extrude(buttonH, center=false)
        resize([buttonSize, buttonSize, 0])
          import("VolumeDown.dxf", center=false, convexity=5);
  }
}
module capMute() {
  union() {
    cap();
    translate([(capW-buttonSize)/2, capD/2-buttonSize/2, capH])
      color("white") linear_extrude(buttonH, center=false)
        resize([buttonSize, buttonSize, 0])
          import("Mute.dxf", center=false, convexity=5);
  }
}
module capVolumeUp() {
  union() {
    cap();
    translate([(capW-buttonSize)/2, capD/2-buttonSize/2, capH])
      color("white") linear_extrude(buttonH, center=false)
        resize([buttonSize, buttonSize, 0])
          import("VolumeUp.dxf", center=false, convexity=5);
  }
}


!mediaKeyboardBox();
translate([wallT+clearance, wallT*2+clearance, wallT+clearance])
  board();
for ( i = [1 : 1 : switchNumber] ) {
  translate([wallT+clearance+(capW-switchW)/2+(i-1)*(capW+clearance),
              (boxD-switchD)/2,
              switchZ
            ])
    switch();
  %translate([wallT+clearance+(i-1)*(capW+clearance),
                (boxD-capD)/2,
                 switchZ+switchHeadH+switchBodyH+boardH-capH+1])
    if (i == 1)      { capPlayPause(); }
    else if (i == 2) { capNext(); }
    else if (i == 3) { capVolumeDown(); }
    else if (i == 4) { capMute(); }
    else if (i == 5) { capVolumeUp(); }
}
