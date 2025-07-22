'# MWS Version: Version 2020.0 - Sep 25 2019 - ACIS 29.0.1 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 5.7 fmax = 5.72
'# created = '[VERSION]2020.0|29.0.1|20190925[/VERSION]


'@ use template: Eigenmode_10.cfg

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "H"
    .TemperatureUnit  "Celsius"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "F"
End With
ThermalSolver.AmbientTemperature "0"
'----------------------------------------------------------------------------
With MStaticSolver
     .IgnorePECMaterial "True"
     .Method "Hexahedral Mesh"
End With
With Background
     .Type "pec"
End With
With Mesh
     .MeshType "Tetrahedral"
     .SetCreator "High Frequency"
End With
With MeshSettings
     .SetMeshType "Tet"
     .Set "Version", 1%
     .Set "SrfMeshGradation", "1.5"
     .Set "UseSameSrfAndVolMeshGradation", "1"
     .Set "VolMeshGradation", "1.5"
     .Set "CurvatureOrderPolicy", "fixedorder"
     .Set "CurvatureOrder", "2"
End With
'More accurate HEX Mesh Settings although TET is default
With Mesh
     .LinesPerWavelength "15"
     .MinimumStepNumber "15"
     .PointAccEnhancement "50"
End With
With MeshSettings
     .SetMeshType "Hex"
     .Set "StepsPerWaveNear", "15"
     .Set "StepsPerBoxNear", "20"
     .Set "RatioLimitGeometry", "50"
     .Set "EquilibrateOn", "1"
     .Set "Equilibrate", "1.5"
End With
PICSolver.Global "LongitudinalEmittance", "True"
Solver.AdaptivePortMeshing "False"
'----------------------------------------------------------------------------
With MeshSettings
     .SetMeshType "Tet"
     .Set "Version", 1%
End With
With Mesh
     .MeshType "Tetrahedral"
End With
'set the solver type
ChangeSolverType("HF Eigenmode")
'----------------------------------------------------------------------------

'@ new component: component1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Component.New "component1"

'@ define cylinder: component1:solid1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "c1" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ switch working plane

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Plot.DrawWorkplane "false"

'@ define material: material1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Reset 
     .Name "material1"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Celsius"
     .Epsilon "9.64"
     .Mu "1"
     .Sigma "0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "1", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define cylinder: component1:solid2

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "material1" 
     .OuterRadius "b1" 
     .InnerRadius "a1" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define material: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Reset 
     .Name "MgO"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Celsius"
     .Epsilon "9.64"
     .Mu "1"
     .Sigma "0"
     .TanD "0.000006"
     .TanDFreq "5"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define frequency range

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solver.FrequencyRange "0.0", "6"

'@ define material colour: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Name "MgO"
     .Folder ""
     .Colour "0", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ delete material: material1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Material.Delete "material1"

'@ define cylinder: component1:solid2

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "b1" 
     .InnerRadius "a1" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define material colour: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Name "MgO"
     .Folder ""
     .Colour "0.501961", "0", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ change material and color: component1:solid2 to: Vacuum

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.SetUseIndividualColor "component1:solid2", 1
Solid.ChangeIndividualColor "component1:solid2", "128", "0", "255"

'@ define cylinder: component1:solid3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "MgO" 
     .OuterRadius "c1" 
     .InnerRadius "r" 
     .Axis "z" 
     .Zrange "L1/2-D/2", "L1/2+D/2" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ boolean add shapes: component1:solid2, component1:solid3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Add "component1:solid2", "component1:solid3"

'@ paste structure data: 1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With SAT 
     .Reset 
     .FileName "*1.cby" 
     .SubProjectScaleFactor "0.001" 
     .ImportToActiveCoordinateSystem "True" 
     .ScaleToUnit "True" 
     .Curves "False" 
     .Read 
End With

'@ boolean subtract shapes: component1:solid1, component1:solid2_1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Subtract "component1:solid1", "component1:solid2_1"

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "periodic"
     .Zmax "periodic"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "0.0"
     .PeriodicUseConstantAngles "False"
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "10" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.7" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "periodic"
     .Zmax "periodic"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "180"
     .PeriodicUseConstantAngles "False"
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "20" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.4" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ change material: component1:solid2 to: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.ChangeMaterial "component1:solid2", "MgO"

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "5" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.7" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ delete shape: component1:solid1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Delete "component1:solid1"

'@ define cylinder: component1:solid3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "c1" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ paste structure data: 2

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With SAT 
     .Reset 
     .FileName "*2.cby" 
     .SubProjectScaleFactor "0.001" 
     .ImportToActiveCoordinateSystem "True" 
     .ScaleToUnit "True" 
     .Curves "False" 
     .Read 
End With

'@ boolean subtract shapes: component1:solid3, component1:solid2_1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Subtract "component1:solid3", "component1:solid2_1"

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "20" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.6" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define frequency range

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solver.FrequencyRange "5", "10"

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "5" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "6.2" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ delete shape: component1:solid3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Delete "component1:solid3"

'@ define cylinder: component1:solid3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "a1" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ paste structure data: 3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With SAT 
     .Reset 
     .FileName "*3.cby" 
     .SubProjectScaleFactor "0.001" 
     .ImportToActiveCoordinateSystem "True" 
     .ScaleToUnit "True" 
     .Curves "False" 
     .Read 
End With

'@ boolean subtract shapes: component1:solid3, component1:solid2_1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Subtract "component1:solid3", "component1:solid2_1"

'@ define cylinder: component1:solid4

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid4" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "c1" 
     .InnerRadius "b1" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ paste structure data: 4

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With SAT 
     .Reset 
     .FileName "*4.cby" 
     .SubProjectScaleFactor "0.001" 
     .ImportToActiveCoordinateSystem "True" 
     .ScaleToUnit "True" 
     .Curves "False" 
     .Read 
End With

'@ boolean subtract shapes: component1:solid4, component1:solid2_1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Subtract "component1:solid4", "component1:solid2_1"

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "10" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.65" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ delete shape: component1:solid4

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Delete "component1:solid4"

'@ define cylinder: component1:solid4

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid4" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "c1" 
     .InnerRadius "b1" 
     .Axis "z" 
     .Zrange "0", "L1/2-D/2" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:solid5

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid5" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "c1" 
     .InnerRadius "b1" 
     .Axis "z" 
     .Zrange "L1/2+D/2", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "3" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.7" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ delete shape: component1:solid3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Delete "component1:solid3"

'@ define cylinder: component1:solid6

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid6" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "a1" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ paste structure data: 5

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With SAT 
     .Reset 
     .FileName "*5.cby" 
     .SubProjectScaleFactor "0.001" 
     .ImportToActiveCoordinateSystem "True" 
     .ScaleToUnit "True" 
     .Curves "False" 
     .Read 
End With

'@ boolean subtract shapes: component1:solid6, component1:solid2_1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Subtract "component1:solid6", "component1:solid2_1"

'@ clear picks

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Pick.ClearAllPicks

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "20" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.7" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.52" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "a1", "True" 
  .SetParameterInit "23.3" 
  .SetParameterMin "20.97" 
  .SetParameterMax "25.63" 
  .SetParameterAnchors "5" 
  .SelectParameter "b1", "False" 
  .SetParameterInit "27.42" 
  .SetParameterMin "24.678" 
  .SetParameterMax "30.162" 
  .SetParameterAnchors "5" 
  .SelectParameter "c1", "True" 
  .SetParameterInit "43" 
  .SetParameterMin "38.7" 
  .SetParameterMax "47.3" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.24" 
  .SetParameterMin "3.816" 
  .SetParameterMax "4.664" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0.0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0.0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0.0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "None" 
  .SetOptionMoveMesh "False" 
End With

'@ add optimizer goals: 1D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .AddGoal "1D Result" 
  .SetGoalOperator "move max" 
  .SetGoalTarget "0.0" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "1.0" 
  .SetGoalNormNew "MaxDiff" 
  .SetGoalTemplateBased1DResultName "Shunt Impedance (Pertubation) beta=1 (Multiple Modes)" 
  .SetGoalRange "0", "1" 
  .SetGoalRangeType "total" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0.0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0.0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0.0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "None" 
  .SetOptionMoveMesh "False" 
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.7" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.52" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "a1", "True" 
  .SetParameterInit "23.3" 
  .SetParameterMin "20.97" 
  .SetParameterMax "26.24" 
  .SetParameterAnchors "5" 
  .SelectParameter "b1", "False" 
  .SetParameterInit "27.42" 
  .SetParameterMin "24.678" 
  .SetParameterMax "30.162" 
  .SetParameterAnchors "5" 
  .SelectParameter "c1", "True" 
  .SetParameterInit "43" 
  .SetParameterMin "36.8" 
  .SetParameterMax "47.3" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.24" 
  .SetParameterMin "3.816" 
  .SetParameterMax "4.664" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0.0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0.0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0.0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "None" 
  .SetOptionMoveMesh "False" 
End With

'@ set optimizer goals 1D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "0", "True" 
  .SetGoalOperator "move max" 
  .SetGoalTarget "0.0" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "1.0" 
  .SetGoalNormNew "MaxDiff" 
  .SetGoalTemplateBased1DResultName "Shunt Impedance (Pertubation) beta=1 (Multiple Modes)" 
  .SetGoalRange "5.71", "5.72" 
  .SetGoalRangeType "range" 
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.71" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.52" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "a1", "True" 
  .SetParameterInit "23.3" 
  .SetParameterMin "20.97" 
  .SetParameterMax "26.24" 
  .SetParameterAnchors "5" 
  .SelectParameter "b1", "True" 
  .SetParameterInit "27.42" 
  .SetParameterMin "24.678" 
  .SetParameterMax "30.162" 
  .SetParameterAnchors "5" 
  .SelectParameter "c1", "True" 
  .SetParameterInit "43" 
  .SetParameterMin "36.8" 
  .SetParameterMax "47.3" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.24" 
  .SetParameterMin "3.816" 
  .SetParameterMax "4.664" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "None" 
  .SetOptionMoveMesh "False" 
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "10" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.71" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ delete shape: component1:solid6

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Delete "component1:solid6"

'@ define cylinder: component1:solid6

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid6" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "r" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:solid7

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid7" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "a1" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "L1/2-D/2" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:solid8

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid8" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "a1" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "L1/2+D/2", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ boolean add shapes: component1:solid6, component1:solid7

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Add "component1:solid6", "component1:solid7"

'@ boolean add shapes: component1:solid6, component1:solid8

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Add "component1:solid6", "component1:solid8"

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.7" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "periodic"
     .Zmax "periodic"
     .Xsymmetry "magnetic"
     .Ysymmetry "magnetic"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "180"
     .PeriodicUseConstantAngles "False"
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.52" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.46" 
  .SetParameterMin "0.387" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.84" 
  .SetParameterMin "0.72" 
  .SetParameterMax "0.88" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.24" 
  .SetParameterMin "3.816" 
  .SetParameterMax "4.664" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "1.4" 
  .SetParameterMin "1.08" 
  .SetParameterMax "1.4" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "None" 
  .SetOptionMoveMesh "False" 
End With

'@ set optimizer goals 1D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "0", "True" 
  .SetGoalOperator "move max" 
  .SetGoalTarget "0.0" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "1.0" 
  .SetGoalNormNew "MaxDiff" 
  .SetGoalTemplateBased1DResultName "Shunt Impedance (Pertubation) beta=1 (Multiple Modes)" 
  .SetGoalRange "0", "1" 
  .SetGoalRangeType "total" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "None" 
  .SetOptionMoveMesh "False" 
End With

'@ delete all optimizer goals

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Optimizer.DeleteAllGoals

'@ add optimizer goals: 0D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .AddGoal "0D Result" 
  .SetGoalOperator ">" 
  .SetGoalTarget "2E+07" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "1.0" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Shunt Impedance (Pertubation) beta=1 (Mode 1)" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "None" 
  .SetOptionMoveMesh "False" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.52" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.47232666666667" 
  .SetParameterMin "0.387" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.82026666666667" 
  .SetParameterMin "0.72" 
  .SetParameterMax "0.88" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.24" 
  .SetParameterMin "3.816" 
  .SetParameterMax "4.664" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "1.3968" 
  .SetParameterMin "1.08" 
  .SetParameterMax "1.4" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Nelder_Mead_Simplex" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "None" 
  .SetOptionMoveMesh "False" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.52" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.41992799186652" 
  .SetParameterMin "0.387" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.83553612465231" 
  .SetParameterMin "0.72" 
  .SetParameterMax "0.88" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.24" 
  .SetParameterMin "3.816" 
  .SetParameterMax "4.664" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "1.191052412103" 
  .SetParameterMin "1.08" 
  .SetParameterMax "1.4" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "CMAES" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.52" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.41992799186652" 
  .SetParameterMin "0.387" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.83553612465231" 
  .SetParameterMin "0.72" 
  .SetParameterMax "0.88" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.24" 
  .SetParameterMin "3.816" 
  .SetParameterMax "4.664" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "1.191052412103" 
  .SetParameterMin "1.08" 
  .SetParameterMax "1.4" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Particle_Swarm" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ define material: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Reset 
     .Name "MgO"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Celsius"
     .Epsilon "10.15"
     .Mu "1"
     .Sigma "0.0"
     .TanD "7.5E-6"
     .TanDFreq "5.7"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.501961", "0", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ clear picks

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Pick.ClearAllPicks

'@ define material: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Reset 
     .Name "MgO"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Celsius"
     .Epsilon "10.15"
     .Mu "1"
     .Sigma "0.0"
     .TanD "7.516E-6"
     .TanDFreq "5.712"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "True"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.501961", "0", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.65" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "periodic"
     .Zmax "periodic"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "180"
     .PeriodicUseConstantAngles "False"
End With

'@ delete shapes

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Delete "component1:solid2" 
Solid.Delete "component1:solid4" 
Solid.Delete "component1:solid5" 
Solid.Delete "component1:solid6"

'@ define cylinder: component1:solid1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "c1" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "electric"
     .Zmax "electric"
     .Xsymmetry "magnetic"
     .Ysymmetry "magnetic"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "5" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "0" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define cylinder: component1:solid2

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "b1" 
     .InnerRadius "a1" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ change material: component1:solid2 to: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.ChangeMaterial "component1:solid2", "MgO"

'@ boolean insert shapes: component1:solid1, component1:solid2

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Insert "component1:solid1", "component1:solid2"

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "5" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.5" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define cylinder: component1:solid3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "MgO" 
     .OuterRadius "c1" 
     .InnerRadius "r" 
     .Axis "z" 
     .Zrange "0", "D/2" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ transform: translate component1:solid3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid3" 
     .Vector "0", "0", "L1-D/2" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "True" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ boolean add shapes: component1:solid2, component1:solid3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Add "component1:solid2", "component1:solid3"

'@ boolean insert shapes: component1:solid1, component1:solid2

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Insert "component1:solid1", "component1:solid2"

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "periodic"
     .Zmax "periodic"
     .Xsymmetry "magnetic"
     .Ysymmetry "magnetic"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "180"
     .PeriodicUseConstantAngles "False"
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "5" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.6" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define material: M18

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Reset 
     .Name "M18"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Celsius"
     .Epsilon "25"
     .Mu "1"
     .Sigma "0"
     .TanD "2.85E-5"
     .TanDFreq "5.7"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ change material: component1:solid2 to: M18

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.ChangeMaterial "component1:solid2", "M18"

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "5" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.1" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ pick edge

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Pick.PickEdgeFromId "component1:solid2", "8", "8"

'@ blend edges of: component1:solid2

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.BlendEdge "1"

'@ pick edge

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Pick.PickEdgeFromId "component1:solid2", "2", "2"

'@ blend edges of: component1:solid2

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.BlendEdge "1"

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "10" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.1" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ change material: component1:solid2 to: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.ChangeMaterial "component1:solid2", "MgO"

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.6" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "periodic"
     .Zmax "periodic"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "180"
     .PeriodicUseConstantAngles "False"
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "3" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.62" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "periodic"
     .Zmax "periodic"
     .Xsymmetry "magnetic"
     .Ysymmetry "magnetic"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "180"
     .PeriodicUseConstantAngles "False"
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.65" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ delete shape: component1:solid1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Delete "component1:solid1"

'@ define cylinder: component1:solid3

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "MgO" 
     .OuterRadius "c1" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "L1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ change material: component1:solid3 to: Vacuum

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.ChangeMaterial "component1:solid3", "Vacuum"

'@ boolean insert shapes: component1:solid3, component1:solid2

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.Insert "component1:solid3", "component1:solid2"

'@ define material: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Reset 
     .Name "MgO"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Celsius"
     .Epsilon "9.64"
     .Mu "1"
     .Sigma "0.0"
     .TanD "6E-6"
     .TanDFreq "10"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "True"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.501961", "0", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define material colour: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Name "MgO"
     .Folder ""
     .Colour "0.501961", "0", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.427" 
  .SetParameterMin "0.387" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.78" 
  .SetParameterMin "0.72" 
  .SetParameterMax "0.88" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "True" 
  .SetParameterInit "5.7" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "5" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Particle_Swarm" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ delete all optimizer goals

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Optimizer.DeleteAllGoals

'@ add optimizer goals: 0D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .AddGoal "0D Result" 
  .SetGoalOperator ">" 
  .SetGoalTarget "1.7E+07" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "0.4" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Shunt Impedance (Pertubation) beta=1 (Mode 1)" 
End With

'@ add optimizer goals: 0D Result / 1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .AddGoal "0D Result" 
  .SetGoalOperator "=" 
  .SetGoalTarget "5.71" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "0.6" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Frequency (Mode 1)" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Particle_Swarm" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.68" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Particle_Swarm" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.427" 
  .SetParameterMin "0.387" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.78" 
  .SetParameterMin "0.72" 
  .SetParameterMax "0.88" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "True" 
  .SetParameterInit "5.7" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "5" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer goals 0D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "0", "True" 
  .SetGoalOperator ">" 
  .SetGoalTarget "1.7E+07" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "0.8" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Shunt Impedance (Pertubation) beta=1 (Mode 1)" 
End With

'@ set optimizer goals 0D Result / 1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "1", "True" 
  .SetGoalOperator "=" 
  .SetGoalTarget "5.71" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "0.2" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Frequency (Mode 1)" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.41553333333333" 
  .SetParameterMin "0.387" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.75866666666667" 
  .SetParameterMin "0.72" 
  .SetParameterMax "0.88" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "True" 
  .SetParameterInit "5.3300000194422" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "5.1088888894902" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer goals 0D Result / 1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "1", "True" 
  .SetGoalOperator "=" 
  .SetGoalTarget "5.71E+9" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "0.2" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Frequency (Mode 1)" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.427" 
  .SetParameterMin "0.387" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.78" 
  .SetParameterMin "0.72" 
  .SetParameterMax "0.88" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "True" 
  .SetParameterInit "5.6" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "4.09" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.427" 
  .SetParameterMin "0.387" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.78" 
  .SetParameterMin "0.72" 
  .SetParameterMax "0.88" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "True" 
  .SetParameterInit "5.6" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "4.09" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer goals 0D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "0", "True" 
  .SetGoalOperator ">" 
  .SetGoalTarget "1.7E+07" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "0.5" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Shunt Impedance (Pertubation) beta=1 (Mode 1)" 
End With

'@ set optimizer goals 0D Result / 1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "1", "True" 
  .SetGoalOperator "=" 
  .SetGoalTarget "5.71E+9" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "0.5" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Frequency (Mode 1)" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.39743709983599" 
  .SetParameterMin "0.387" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.74720599590079" 
  .SetParameterMin "0.72" 
  .SetParameterMax "0.88" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "True" 
  .SetParameterInit "6.1591126061183" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "4" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer goals 0D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "0", "True" 
  .SetGoalOperator ">" 
  .SetGoalTarget "1.7E+07" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "336" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Shunt Impedance (Pertubation) beta=1 (Mode 1)" 
End With

'@ set optimizer goals 0D Result / 1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "1", "True" 
  .SetGoalOperator "=" 
  .SetGoalTarget "5.71E+9" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "1" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Frequency (Mode 1)" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.427" 
  .SetParameterMin "0.4" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.78" 
  .SetParameterMin "0.74" 
  .SetParameterMax "0.82" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "True" 
  .SetParameterInit "5.6" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "4" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Max_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer goals 0D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "0", "True" 
  .SetGoalOperator ">" 
  .SetGoalTarget "1.7E+07" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "1" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Shunt Impedance (Pertubation) beta=1 (Mode 1)" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.427" 
  .SetParameterMin "0.4" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.78" 
  .SetParameterMin "0.74" 
  .SetParameterMax "0.82" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "True" 
  .SetParameterInit "5.6" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "4.0000001026549" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer goals 0D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "0", "True" 
  .SetGoalOperator ">" 
  .SetGoalTarget "1.7E+07" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "336" 
  .SetGoalNormNew "DiffSq" 
  .SetGoalTemplateBased0DResultName "Shunt Impedance (Pertubation) beta=1 (Mode 1)" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.427" 
  .SetParameterMin "0.4" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.78" 
  .SetParameterMin "0.74" 
  .SetParameterMax "0.82" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "True" 
  .SetParameterInit "5.6" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "4.0000001026549" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer goals 0D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "0", "True" 
  .SetGoalOperator ">" 
  .SetGoalTarget "1.7E+07" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "1" 
  .SetGoalNormNew "DiffSq" 
  .SetGoalTemplateBased0DResultName "Shunt Impedance (Pertubation) beta=1 (Mode 1)" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.42483703703704" 
  .SetParameterMin "0.4" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.78317037037037" 
  .SetParameterMin "0.74" 
  .SetParameterMax "0.82" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "True" 
  .SetParameterInit "5.63" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "4.0792593619142" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "5" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Nelder_Mead_Simplex" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer goals 0D Result / 0

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "0", "True" 
  .SetGoalOperator ">" 
  .SetGoalTarget "1.7E+07" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "0.8" 
  .SetGoalNormNew "DiffSq" 
  .SetGoalTemplateBased0DResultName "Shunt Impedance (Pertubation) beta=1 (Mode 1)" 
End With

'@ set optimizer goals 0D Result / 1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SelectGoal "1", "True" 
  .SetGoalOperator "=" 
  .SetGoalTarget "5.71E+9" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "0.2" 
  .SetGoalNormNew "Diff" 
  .SetGoalTemplateBased0DResultName "Frequency (Mode 1)" 
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.7" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define frequency range

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solver.FrequencyRange "5", "6.5"

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "periodic"
     .Zmax "periodic"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "180"
     .PeriodicUseConstantAngles "False"
End With

'@ define material: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Reset 
     .Name "MgO"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Celsius"
     .Epsilon "9.64"
     .Mu "1"
     .Sigma "0.0"
     .TanD "6E-6"
     .TanDFreq "5.7"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "True"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.501961", "0", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "periodic"
     .Zmax "periodic"
     .Xsymmetry "magnetic"
     .Ysymmetry "magnetic"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "0"
     .PeriodicUseConstantAngles "False"
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "5" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "4.6" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ define boundaries

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "periodic"
     .Zmax "periodic"
     .Xsymmetry "magnetic"
     .Ysymmetry "magnetic"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "-180"
     .PeriodicUseConstantAngles "False"
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.7" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.44" 
  .SetParameterMin "0.42" 
  .SetParameterMax "0.473" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.82" 
  .SetParameterMin "0.78" 
  .SetParameterMax "0.82" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.22" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "False" 
  .SetParameterInit "4" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "3.16" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Nelder_Mead_Simplex" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.65" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.44" 
  .SetParameterMin "0.42" 
  .SetParameterMax "0.46" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.82" 
  .SetParameterMin "0.80" 
  .SetParameterMax "0.84" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.22" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "False" 
  .SetParameterInit "4" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "3.16" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.44" 
  .SetParameterMin "0.42" 
  .SetParameterMax "0.46" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.8204" 
  .SetParameterMin "0.80" 
  .SetParameterMax "0.84" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.22" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "False" 
  .SetParameterInit "4" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "3.16" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Nelder_Mead_Simplex" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ define frequency range

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solver.FrequencyRange "5.7", "5.72"

'@ define material: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Reset 
     .Name "MgO"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Celsius"
     .Epsilon "9.64"
     .Mu "1"
     .Sigma "0.0"
     .TanD "6E-6"
     .TanDFreq "5.71"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "True"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.501961", "0", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.7" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.44" 
  .SetParameterMin "0.42" 
  .SetParameterMax "0.46" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.82" 
  .SetParameterMin "0.80" 
  .SetParameterMax "0.84" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.22" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "4" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "3.16" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Nelder_Mead_Simplex" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.6" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ set optimizer parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "¦Ë", "False" 
  .SetParameterInit "52.48" 
  .SetParameterMin "47.268" 
  .SetParameterMax "57.772" 
  .SetParameterAnchors "5" 
  .SelectParameter "aa", "True" 
  .SetParameterInit "0.44" 
  .SetParameterMin "0.42" 
  .SetParameterMax "0.46" 
  .SetParameterAnchors "5" 
  .SelectParameter "cc", "True" 
  .SetParameterInit "0.82" 
  .SetParameterMin "0.80" 
  .SetParameterMax "0.84" 
  .SetParameterAnchors "5" 
  .SelectParameter "D", "False" 
  .SetParameterInit "4.22" 
  .SetParameterMin "4" 
  .SetParameterMax "7" 
  .SetParameterAnchors "5" 
  .SelectParameter "mm", "True" 
  .SetParameterInit "4.2605027722331" 
  .SetParameterMin "4" 
  .SetParameterMax "6" 
  .SetParameterAnchors "5" 
  .SelectParameter "r", "False" 
  .SetParameterInit "3.16" 
  .SetParameterMin "4.5" 
  .SetParameterMax "5.5" 
  .SetParameterAnchors "5" 
  .SelectParameter "ww", "False" 
  .SetParameterInit "22.95" 
  .SetParameterMin "20.655" 
  .SetParameterMax "25.245" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Optimizer 
  .SetOptimizerType "Nelder_Mead_Simplex" 
  .SetSimulationType "Eigenmode Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "Automatic" 
  .SetOptionMoveMesh "True" 
End With

'@ define material: material1

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Reset 
     .Name "material1"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Celsius"
     .Epsilon "9.8"
     .Mu "1"
     .Sigma "0"
     .TanD "1E-5"
     .TanDFreq "5.712"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "True"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ rename material: material1 to: ALO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Material.Rename "material1", "ALO"

'@ change material: component1:solid2 to: ALO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.ChangeMaterial "component1:solid2", "ALO"

'@ define material colour: ALO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
With Material 
     .Name "ALO"
     .Folder ""
     .Colour "1", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ define eigenmode solver parameters

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Mesh.SetFlavor "High Frequency" 
Mesh.SetCreator "High Frequency" 
EigenmodeSolver.Reset 
With Solver
     .CalculationType "Eigenmode" 
     .AKSReset 
     .AKSPenaltyFactor "1" 
     .AKSEstimation "0" 
     .AKSAutomaticEstimation "True" 
     .AKSEstimationCycles "5" 
     .AKSIterations "2" 
     .AKSAccuracy "1e-12" 
End With
With EigenmodeSolver 
     .SetMethodType "AKS", "Hex" 
     .SetMethodType "Default", "Tet" 
     .SetMeshType "Tetrahedral Mesh" 
     .SetMeshAdaptationHex "False" 
     .SetMeshAdaptationTet "True" 
     .SetNumberOfModes "1" 
     .SetStoreResultsInCache "False" 
     .SetCalculateExternalQFactor "False" 
     .SetConsiderStaticModes "True" 
     .SetCalculateThermalLosses "True" 
     .SetModesInFrequencyRange "False" 
     .SetFrequencyTarget "True", "5.65" 
     .SetAccuracy "1e-6" 
     .SetQExternalAccuracy "1e-4" 
     .SetMaterialEvaluationFrequency "True", "" 
     .SetTDCompatibleMaterials "False" 
     .SetOrderTet "2" 
     .SetUseSensitivityAnalysis "False" 
     .SetConsiderLossesInPostprocessingOnly "True" 
     .SetMinimumQ "1.0" 
     .SetUseParallelization "True"
     .SetMaxNumberOfThreads "128"
     .MaximumNumberOfCPUDevices "2"
     .SetRemoteCalculation "False"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"

'@ change material: component1:solid2 to: MgO

'[VERSION]2020.0|29.0.1|20190925[/VERSION]
Solid.ChangeMaterial "component1:solid2", "MgO" 

