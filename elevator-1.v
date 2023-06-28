/*
11 Floor Elevator Simulation in Verilog HDL
Written by Somer Hanna
COMPE-470
Fall-2021
Professor Ken Arnold
*/

`timescale 1ns / 1ps

module elevator
          #(parameter
          GROUND_FLOOR = 4'b0000,                       
          FLOOR_1 = 4'b0001,                            //value of every parameter is the number corresponding to the floor for readability
          FLOOR_2 = 4'b0010, 
          FLOOR_3 = 4'b0011, 
          FLOOR_4 = 4'b0100,
          FLOOR_5 = 4'b0101,
          FLOOR_6 = 4'b0110,
          FLOOR_7 = 4'b0111,
          FLOOR_8 = 4'b1000,
          FLOOR_9 = 4'b1001,
          FLOOR_10 =4'b1010)
          
(input clock, close_sensor, stop, output reg [1:0] weight_sensor, input [3:0] selection, output reg [3:0] floor_level, output reg [8:0] TV_channel, output reg down, up, door_open, input [3:0] passengers, output reg [3:0] speaker, output reg [1:0] weight_warn);

wire movement_sensor;

//clock controls the speed at which hardware is executed, in this case 10 ns period
//close_sensor closes the door after it hangs open on idle
//stop manually stops the elevator from it's traveling position
//weight_sensor detects if someone is inside the elevator
//selection is the floor being chosen by the testbench
//floor_level is the current floor
//TV_channel is the channel of the TV in the elevator
//down is an LED showcasing the elevator is traveling downwards
//up is an LED showcasing the elevator is traveling upwards
//door_open is the state where the elevator is idle
//passengers is the amount of people in the elevator, max of 8 people
//speaker issues audiable sound clip of the floor level for the hearing impaired
//weight_warn checks the weight inside the elevator and issues warning if it is found to be above 8 people

passenger first(.cap_1(weight_sensor), .warn_2(movement_sensor));           //module to test passenger weight and issue warning light if exceeds 800 lbs

/*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

always @(posedge clock)
begin

speaker = 'd0;                          //speaker is 0
TV_channel = 'd61;                      //channel is 61
floor_level <= 4'b0001;                 //start on floor 1
weight_sensor <= 0;                     //start with weight sensor o
weight_warn <= 0;                       //start with weight warn off

case(selection)                         //state machine is built on cases, with selection (button input) being tested against the current floor level

GROUND_FLOOR:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level
    

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if ((selection == floor_level) && (close_sensor == 0))
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd1;                                      //speaker announces "Ground Floor"
    door_open = 4'b0001;                                //door opens when elevator is idle
    floor_level <= GROUND_FLOOR;                        //keep elevator at current level
    

end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
        
     if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= GROUND_FLOOR;                        //if button is pressed for same floor, stay idle

end


FLOOR_1:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
    weight_sensor <= 1;                                 //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if ((selection == floor_level) && (close_sensor == 0))
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd2;                                      //speaker announces "Floor 1"
    door_open = 4'b0001;                                //door opens when elevator is idle
    floor_level <= FLOOR_1;                             //keep elevator at current level
    

end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= FLOOR_1;                             //if button is pressed for same floor, stay idle

end

FLOOR_2:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if ((selection == floor_level) && (close_sensor == 0))
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd3;                                      //speaker announces "Floor 2"
    door_open = 4'b0001;                                //door opens when elevator is idle
    floor_level <= FLOOR_2;                             //keep elevator at current level
    

end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= FLOOR_2;                             //if button is pressed for same floor, stay idle

end

FLOOR_3:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if ((selection == floor_level) && (close_sensor == 0))
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
    weight_warn <= 1;                                   //weight warn LED activates when weight is exceeded
    else
    weight_warn <= 0;                                   //weight warn LED off

    speaker = 'd4;                                      //speaker announces "Floor 3"
    door_open = 4'b0001;                                //door opens when elevator is idle
    
    floor_level <= FLOOR_3;                             //keep elevator at current level

    
end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= FLOOR_3;                             //if button is pressed for same floor, stay idle

end

FLOOR_4:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if ((selection == floor_level) && (close_sensor == 0))
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd5;                                      //speaker announces "Floor 4"
    door_open = 4'b0001;                                //door opens when elevator is idle
    floor_level <= FLOOR_4;                             //keep elevator at current level
    

end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                            //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= FLOOR_4;                             //if button is pressed for same floor, stay idle

end

FLOOR_5:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                            //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if ((selection == floor_level) && (close_sensor == 0))
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd6;                                      //speaker announces "Floor 5"
    door_open = 4'b0001;                                //door opens when elevator is idle
    floor_level <= FLOOR_5;                             //keep elevator at current level
    

end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= FLOOR_5;                             //if button is pressed for same floor, stay idle
end

FLOOR_6:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if ((selection == floor_level) && (close_sensor == 0))
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd7;                                      //speaker announces "Floor 6"
    door_open = 4'b0001;                                //door opens when elevator is idle
    floor_level <= FLOOR_6;                             //keep elevator at current level
    

end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                            //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                 //capacity of elevator is 8 passengers
        weight_warn <= 1;                                   //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= FLOOR_6;                             //if button is pressed for same floor, stay idle
end

FLOOR_7:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level
    TV_channel = 'd102;                                 //TV channel changed to 102

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if ((selection == floor_level) && (close_sensor == 0))
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd8;                                      //speaker announces "Floor 7"
    door_open = 4'b0001;                                //door opens when elevator is idle
    floor_level <= FLOOR_7;                             //keep elevator at current level
    
   
end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on

    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= FLOOR_7;                             //if button is pressed for same floor, stay idle

end

FLOOR_8:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if ((selection == floor_level) && (close_sensor == 0))
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd9;                                      //speaker announces "Floor 8"
    door_open = 4'b0001;                                //door opens when elevator is idle
    floor_level <= FLOOR_8;                             //keep elevator at current level
    

end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= FLOOR_8;                             //if button is pressed for same floor, stay idle

end

FLOOR_9:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if ((selection == floor_level) && (close_sensor == 0))
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd10;                                     //speaker announces "Floor 9"
    door_open = 4'b0001;                                //door opens when elevator is idle
    floor_level <= FLOOR_9;                             //keep elevator at current level
    

end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= FLOOR_9;                             //if button is pressed for same floor, stay idle

end

FLOOR_10:
begin

if (selection > floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling up
    down = 4'b0000;                                     //elevator LED down is off
    up = 4'b0001;                                       //elevator LED up is on
    floor_level <= floor_level +1;                      //increment floor level

if (selection == floor_level +1)
    up = 4'b0000;                                       //elevator LED up is off, floor is reached

end

else if (selection == floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd11;                                     //speaker announces "Floor 10"
    door_open = 4'b0001;                                //door opens when elevator is idle
    floor_level <= FLOOR_10;                            //keep elevator at current level
    

end

else if (selection < floor_level)
begin

    if(passengers == 0)                                 //check elevator for passengers and disable sensor when none are on
        weight_sensor <= 0;
    else
        weight_sensor <= 1;                             //if elevator occupied, sensor stays on
    
    if(passengers > 8)                                  //capacity of elevator is 8 passengers
        weight_warn <= 1;                               //weight warn LED activates when weight is exceeded
    else
        weight_warn <= 0;                               //weight warn LED off

    speaker = 'd0;                                      //speaker is off
    door_open = 4'b0000;                                //door is closed when traveling down
    down = 4'b0001;                                     //elevator LED down is on
    up = 4'b0000;                                       //elevator LED up is off
    floor_level <= floor_level -1;                      //decrement floor level
    
if (selection == floor_level -1)
    down = 4'b0000;                                     //elevator LED down is off, floor is reached
    
end

else if (selection == floor_level)
    floor_level <= FLOOR_10;                             //if button is pressed for same floor, stay idle

end

default: floor_level <= GROUND_FLOOR;                   //default floor goes to the ground floor

endcase

end

endmodule

module passenger(cap_1, warn_2);    //module is supposed to output warning based on the weight exceeding 800 lbs

    input [2:0] cap_1;              //input of weight
    output reg [1:0] warn_2;        //warning LED if passenger weight has exceeded 800 lbs
    
    initial begin
    
    if(cap_1 > 'd800)               //if weight capacity is greater than 800
        assign warn_2 = 2'b01;      //turn off LED warn
    
    end
    
endmodule