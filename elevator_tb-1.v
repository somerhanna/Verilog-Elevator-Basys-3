/*
11 Floor Elevator Simulation in Verilog HDL
Written by Somer Hanna
COMPE-470
Fall-2021
Professor Ken Arnold
*/

`timescale 1ns / 1ps

module elevator_tb();

reg clock, stop;                                        //clock & stop are either 0 or 1
reg [3:0] selection;                                    //selection is 2^4 spaces, due to 11 floors. weight_sensor detects 800 lbs
wire [1:0] weight_sensor;                               //weight_sensor detects 800 lbs (unfinished)
reg [3:0] passengers;                                   //maximum capacity is 8 passengers
wire [8:0] TV_channel;                                  //TV with 2^9 channels
wire [3:0] floor_level;                                 //11 floors
wire [3:0] speaker;                                    //speaker has 11 lines corresponding to each floor
wire down, up;                                          //sensors showcasing the direction the elevator is travelling
wire [1:0] weight_warn;                                 //sensor indicating that the elevator has reached a maximum capacity of 8 occupants
reg close_sensor;                                       //closes the door when the elevator is still

/*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

elevator DUT(.clock(clock), .stop(stop), .selection(selection), .weight_warn(weight_warn), .speaker(speaker), .TV_channel(TV_channel), .passengers(passengers), .floor_level(floor_level), .down(down), .up(up), .door_open(door_open), .close_sensor(close_sensor), .weight_sensor(weight_sensor));

initial begin

    clock = 0;                              //clock initialization
    close_sensor = 0;                       //manually close elevator door
    passengers = 0;                         //0 passengers
    
forever #5 clock =~ clock;                  //looping clock at 5 ns, evaluated at posedge in module

end

initial begin
#5                                          //wait 5 ns (same for all #x)
    stop = 4'b0000;                         
    selection = 4'b0100;                    //button pressed for floor 4
#40
    selection = 4'b0010;                    //button pressed for floor 2
#30
    selection = 4'b0100;                    //button pressed for floor 4
#20
    passengers = 'd1;
#40
    selection = 4'b0111;                    //button pressed for floor 7
#30 passengers = 'd3;                       //3 passengers board
#50
    selection = 4'b0000;                    //button pressed for ground floor
#30
    selection = 4'b1010;                    //button pressed for floor 10
#50
    selection = 4'b0110;                    //button pressed for floor 6                      
#30
    selection = 4'b1000;                    //button pressed for floor 8
#20 passengers = 'd0;                       //0 passengers
#50
    selection = 4'b0011;                    //button pressed for floor 3
#30
    selection = 4'b0110;                    //button pressed for floor 6
    #10 passengers = 'd9;                   //9 passengers enter (capacity is 8) weight warn will turn on LED
    stop = 4'b0001;                         //button to stop elevator movement
#60
#10 passengers = 'd0;                       //0 passengers
    stop = 4'b0000;                         //button pressed for ground floor
    selection = 4'b0000;
#60
    selection = 4'b0101;                    //button pressed for floor 5
#50
    selection = 4'b0110;                    //button pressed for floor 6
#30
    selection = 4'b1000;                    //button pressed for floor 8
#50
    selection = 4'b0011;                    //button pressed for floor 3
#60
    selection = 4'b0110;                    //button pressed for floor 6
    passengers = 'd2;                       //2 passengers board
#40
    selection = 4'b0000;                    //button pressed for ground floor
#10
    close_sensor = 4'b0001;                 //manual door button close
    selection = 4'b1010;                    //button pressed for floor 10
#50
    stop = 4'b0001;                         //button to stop elevator on
    close_sensor = 4'b0000;                 //release manual door button
#25
    stop = 4'b0000;                         //release emergency stop
#50
    passengers = 'd0;                       //zero passengers
    selection = 4'b0100;                    //button pressed for floor 4
#30
    selection = 4'b1001;                    //button pressed for floor 9
#50
    selection = 4'b0100;                    //button pressed for floor 4
#60
    selection = 4'b0000;                    //button pressed for ground floor
    
$stop;

end

endmodule
