//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// Licence as published by the Free Software Foundation; either
// version 2.1 of the Licence, or (at your option) any later version.
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public Licence for more details.
//
// You should have received a copy of the GNU Lesser General Public
// Licence along with this library; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
//
// Contact details:
// mark.clift@synchrotron.org.au
// 800 Blackburn Road, Clayton, Victoria 3168, Australia.
//

#ifndef GalilCSAxis_H
#define GalilCSAxis_H

#include "asynMotorController.h"
#include "asynMotorAxis.h"

class GalilCSAxis : public asynMotorAxis
{
public:

  GalilCSAxis(class GalilController *pC, 	//The GalilController
		char axisname);			//The coordinate system axis name I-P

  //These are the methods that are new to this class
  //Store settings, and implement defaults
  asynStatus setDefaults(void);
  //Construct axes list from provided equation
  asynStatus obtainAxisList(char axis, char *equation, char *axes);
  //Substitute transform equation in place of motor name
  asynStatus substituteTransforms(char axis, char *equation);
  //Bring variables Q-X in range A-P for use with sCalcperform
  asynStatus substituteVariables(char axis, char *equation, char *axes, char *vars, char *subs);
  //Parse a kinematic transform equation and store results in GalilCSAxis instance
  asynStatus parseTransform(char axis, char *equation, char *axes, char *vars, char *subs);
  //Store kinematics when user changes them
  asynStatus parseTransforms(void);
  //Calculate an expression with the given arguments
  asynStatus doCalc(const char *expr, double args[], double *result);
  //Get motor readbacks for kinematic transform, and pack into mrargs (motor readback args)
  asynStatus packReadbackArgs(char *axes, double mrargs[]);
  //Peform forward kinematic transform using real axis readback data, and store results in GalilCSAxis
  int forwardTransform(void);
  //Peform reverse kinematic transform using coordinate system axis readback data, and new position from user
  //for this coordinate system axis, then calculate real motor positions
  int reverseTransform(double nposition, double nmotor_positions[]);
  //Selects a free coordinate system S or T and returns coordsys number, or -1 if none free
  int selectFreeCoordinateSystem(void);

  /* These are the methods we override from the base class */
  asynStatus move(double position, int relative, double min_velocity, double max_velocity, double acceleration);
  asynStatus moveVelocity(double min_velocity, double max_velocity, double acceleration);
  //asynStatus home(double min_velocity, double max_velocity, double acceleration, int forwards);
  asynStatus stop(double acceleration);
  asynStatus poll(bool *moving);

  //asynStatus setHighLimit(double highLimit);
  //asynStatus setLowLimit(double lowLimit);

  ~GalilCSAxis();

private:
  GalilController *pC_;      		/**< Pointer to the asynMotorController to which this axis belongs.
                                	*   Abbreviated because it is used very frequently */
  char axisName_;			//The axis letter I-P
  bool axisReady_;			//Have motor record fields been pushed into driver
  bool lastaxisReady_;			//Show CS axis as moving until after axis ready so initial setpoint in mr matches the readback
  char *fwdaxes_;			//List of CS motors whose transforms should be treated as forward transforms
  char *forward_;			//forward kinematic transform used to calculate the coordinate system (cs) motor position
  char *fwdvars_;			//Forward kinematic variables List of Q-Z
  char *fwdsubs_;			//Forward kinematic substitutes List of A-P
  char *revaxes_;			//List of real motors axis whose transforms should be treated as reverse transforms
  char **reverse_;			//Reverse transforms to calculate each axis position in the coordinate system
  char **revvars_;			//Reverse kinematic variables List of Q-Z
  char **revsubs_;			//Reverse kinematic substitutes List of A-P
  int coordsys_;			//The coordinate system S or T that we started when moving
  bool stop_onlimit_;			//Is a real motor in the cs axis stopping on a limit
  bool move_started_;			//Has a move been initiated from this cs axis
  bool kinematic_error_reported_;	//Kinematic error has been reported to user
  int last_done_;			//Done status stored from previous poll cycle
  double motor_position_;		//aux encoder or step count register
  double encoder_position_;		//main encoder register
  double last_motor_position_;		//aux encoder or step count register stored from previous poll
  int direction_;			//Direction of cs axis
 
friend class GalilController;
};

#endif   // GalilCSAxis_H

