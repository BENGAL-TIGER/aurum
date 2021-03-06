dyn.load(paste("CoolProp", .Platform$dynlib.ext, sep=""))
library(methods) # See http://stackoverflow.com/a/19468533
source("CoolProp.R")
cacheMetaData(1)
writeLines(paste('**************** INFORMATION ***************'))
writeLines(paste('This example was auto-generated by the language-agnostic dev/scripts/example_generator.py script written by Ian Bell'))
writeLines(paste('CoolProp version:', ' ', get_global_param_string('version')))
writeLines(paste('CoolProp gitrevision:', ' ', get_global_param_string('gitrevision')))
writeLines(paste('CoolProp Fluids:', ' ', get_global_param_string('FluidsList')))
# See http://www.coolprop.org/coolprop/HighLevelAPI.html#table-of-string-inputs-to-propssi-function for a list of inputs to high-level interface
writeLines(paste('*********** HIGH LEVEL INTERFACE *****************'))
writeLines(paste('Critical temperature of water:', ' ', Props1SI('Water', 'Tcrit'), ' ', 'K'))
writeLines(paste('Boiling temperature of water at 101325 Pa:', ' ', PropsSI('T', 'P', 101325, 'Q', 0, 'Water'), ' ', 'K'))
writeLines(paste('Phase of water at 101325 Pa and 300 K:', ' ', PhaseSI('P', 101325, 'T', 300, 'Water')))
writeLines(paste('c_p of water at 101325 Pa and 300 K:', ' ', PropsSI('C', 'P', 101325, 'T', 300, 'Water'), ' ', 'J/kg/K'))
writeLines(paste('c_p of water (using derivatives) at 101325 Pa and 300 K:', ' ', PropsSI('d(H)/d(T)|P', 'P', 101325, 'T', 300, 'Water'), ' ', 'J/kg/K'))
writeLines(paste('*********** HUMID AIR PROPERTIES *****************'))
writeLines(paste('Humidity ratio of 50% rel. hum. air at 300 K, 101325 Pa:', ' ', HAPropsSI('W', 'T', 300, 'P', 101325, 'R', 0.5), ' ', 'kg_w/kg_da'))
writeLines(paste('Relative humidity from last calculation:', ' ', HAPropsSI('R', 'T', 300, 'P', 101325, 'W', HAPropsSI('W', 'T', 300, 'P', 101325, 'R', 0.5)), ' ', '(fractional)'))
writeLines(paste('*********** INCOMPRESSIBLE FLUID AND BRINES *****************'))
writeLines(paste('Density of 50% (mass) ethylene glycol/water at 300 K, 101325 Pa:', ' ', PropsSI('D', 'T', 300, 'P', 101325, 'INCOMP::MEG-50%'), ' ', 'kg/m^3'))
writeLines(paste('Viscosity of Therminol D12 at 350 K, 101325 Pa:', ' ', PropsSI('V', 'T', 350, 'P', 101325, 'INCOMP::TD12'), ' ', 'Pa-s'))
# If you don't have REFPROP installed, disable the following lines
writeLines(paste('*********** REFPROP *****************'))
writeLines(paste('REFPROP version:', ' ', get_global_param_string('REFPROP_version')))
writeLines(paste('Critical temperature of water:', ' ', Props1SI('REFPROP::Water', 'Tcrit'), ' ', 'K'))
writeLines(paste('Boiling temperature of water at 101325 Pa:', ' ', PropsSI('T', 'P', 101325, 'Q', 0, 'REFPROP::Water'), ' ', 'K'))
writeLines(paste('c_p of water at 101325 Pa and 300 K:', ' ', PropsSI('C', 'P', 101325, 'T', 300, 'REFPROP::Water'), ' ', 'J/kg/K'))
writeLines(paste('*********** TABULAR BACKENDS *****************'))
TAB = AbstractState_factory('BICUBIC&HEOS', 'R245fa')
TAB$update("PT_INPUTS", 101325, 300)
writeLines(paste('Mass density of refrigerant R245fa at 300 K, 101325 Pa:', ' ', TAB$rhomass(), ' ', 'kg/m^3'))
writeLines(paste('*********** SATURATION DERIVATIVES (LOW-LEVEL INTERFACE) ***************'))
AS_SAT = AbstractState_factory('HEOS', 'R245fa')
AS_SAT$update("PQ_INPUTS", 101325, 0)
writeLines(paste('First saturation derivative:', ' ', AS_SAT$first_saturation_deriv("iP", "iT"), ' ', 'Pa/K'))
writeLines(paste('*********** LOW-LEVEL INTERFACE *****************'))
AS = AbstractState_factory('HEOS', 'Water&Ethanol')
z = c(0.5, 0.5)
AS$set_mole_fractions(z)
AS$update("PQ_INPUTS", 101325, 1)
writeLines(paste('Normal boiling point temperature of water and ethanol:', ' ', AS$T(), ' ', 'K'))
# If you don't have REFPROP installed, disable the following block
writeLines(paste('*********** LOW-LEVEL INTERFACE (REFPROP) *****************'))
AS2 = AbstractState_factory('REFPROP', 'Methane&Ethane')
z2 = c(0.2, 0.8)
AS2$set_mole_fractions(z2)
AS2$update("QT_INPUTS", 1, 120)
writeLines(paste('Vapor molar density:', ' ', AS2$keyed_output("iDmolar"), ' ', 'mol/m^3'))