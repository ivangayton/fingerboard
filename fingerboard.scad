// Parameters

scale_length = 650; //mm, Strat standard, Les Paul is 628
frets = 24;
board_thickness = 6; //mm, at thickest point after radiusing
nut_width = 42; //mm, Strat standard
fret24_width = 52; //NOT CORRECT, FIX WITH FORMULA
spacing_increment = 0.1; //mm, precise value would be 0.1016 but that's dumb
//each space differs from the next by exactly .004" or about 0.1mm
//to create even inter-string distances with different gauges
spacing_bridge = 52 - spacing_increment * 5; //E to E; Strat, vintage is 56
spacing_nut = 34.5 - spacing_increment * 5; //E to E; more or less Strat default

radius_nut = 184.15; //mm, equivalent to 7.25 inches
radius_24fret = 355.6; //mm equivalent to 14 inches

// String gauge
// Most common electric guitar gauge 10/13/17/26/36/46 thousandths
string1 = 0.254; //mm
string2 = 0.3308;
string3 = 0.4318;
string4 = 0.6604;
string5 = 0.9144;
string6 = 1.1684;

stringh = 2; //mm above fretboard at nut



module board(){
    translate([0, -fret24_width/2, -board_thickness]){
        cube([scale_length, fret24_width, board_thickness]);
    }
}

module strings(){
    //string6
    hull(){
        dispn6 = -(spacing_nut/6*2.5 + spacing_increment * 5);
        nh6 = stringh - (radius_nut - sqrt(pow(radius_nut, 2) - pow(dispn6, 2)));
        translate([0, dispn6, nh6]){
            sphere(d = string6, $fn = 36);
        }
        translate([scale_length, -(spacing_bridge/6*2.5 + spacing_increment * 5), stringh]){
            sphere(d = string6, $fn = 36);
        }
    }
    //string5
    hull(){
        dispn5 = -(spacing_nut/6*1.5 + spacing_increment * 4);
        nh5 = stringh - (radius_nut - sqrt(pow(radius_nut, 2) - pow(dispn5, 2)));
        translate([0, dispn5, nh5]){
            sphere(d = string5, $fn = 36);
        }
        translate([scale_length, -(spacing_bridge/6*1.5 + spacing_increment * 4), stringh]){
            sphere(d = string5, $fn = 36);
        }
    }
    //string4
    hull(){
        dispn4 = -(spacing_nut/6*0.5 + spacing_increment * 3);
        nh4 = stringh - (radius_nut - sqrt(pow(radius_nut, 2) - pow(dispn4, 2)));
        translate([0, dispn4, stringh]){
            sphere(d = string4, $fn = 36);
        }
        translate([scale_length, -(spacing_bridge/6*0.5 + spacing_increment * 3), stringh]){
            sphere(d = string4, $fn = 36);
        }
    }
    //string3
    hull(){
        dispn3 = spacing_nut/6*0.5 - spacing_increment * 2;
        nh3 = stringh - (radius_nut - sqrt(pow(radius_nut, 2) - pow(dispn3, 2)));
        translate([0, dispn3, nh3]){
            sphere(d = string3, $fn = 36);
        }
        translate([scale_length, spacing_bridge/6*0.5 - spacing_increment * 2, stringh]){
            sphere(d = string3, $fn = 36);
        }
    }
    //string2
    hull(){
        dispn2 = spacing_nut/6*1.5 - spacing_increment;
        nh2 = stringh - (radius_nut - sqrt(pow(radius_nut, 2) - pow(dispn2, 2)));
        translate([0, dispn2, nh2]){
            sphere(d = string2, $fn = 36);
        }
        translate([scale_length, spacing_bridge/6*1.5 - spacing_increment, stringh]){
            sphere(d = string2, $fn = 36);
        }
    }
    //string1
    hull(){
        dispn1 = spacing_nut/6*2.5;
        nh1 = stringh - (radius_nut - sqrt(pow(radius_nut, 2) - pow(dispn1, 2)));
        translate([0, dispn1, nh1]){
            sphere(d = string1, $fn = 36);
        }
        translate([scale_length, spacing_bridge/6*2.5, stringh]){
            sphere(d = string1, $fn = 36);
        }
    }
}

module radius_guides(){
    translate([0, 0, stringh - radius_nut])
    rotate([0, 90, 0])
    difference(){
        cylinder(r = radius_nut, h = 5, $fn = 512);
        translate([0,0,-1]) cylinder(r = radius_nut -0.1, h= 12, $fn = 512);
    }
    translate([scale_length * 0.75, 0, stringh - radius_24fret])
    rotate([0, 90, 0])
    difference(){
        cylinder(r = radius_24fret, h = 5, $fn = 512);
        translate([0,0,-1]) cylinder(r = radius_24fret -0.1, h= 12, $fn = 512);
    }
}

color("red") translate ([0, spacing_increment * 2.5, 0]) strings();
//board();
radius_guides();


