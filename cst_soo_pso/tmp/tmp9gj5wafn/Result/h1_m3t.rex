<?xml version="1.0" encoding="UTF-8"?>
<MetaResultFile creator="Solver HF TET FD" version="20170330">
  <SpecialMaterials>
    <Background type="FIELDFREE"/>
    <Material name="air_0" type="FIELDFREE"/>
  </SpecialMaterials>
  <SimulationProperties dB_Amplitude="20" encoded_unit="&amp;U:A^1.:m^-1" fieldname="Mode 1 H-Field" fieldtype="H-Field" frequency="5.7166583405399844509"/>
  <MetaGeometryFile filename="model.gex" lod="1"/>
  <ResultGroups num_steps="1" transformation="1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1">
    <Frame index="0">
      <FieldResultFile filename="h1.m3t" type="m3t"/>
    </Frame>
  </ResultGroups>
  <ResultDataType complex="1" timedomain="0" vector="1"/>
  <Symmetries>
    <SymmetryX type="mirror inverted inverted" offset="0 0 0"/>
    <SymmetryY type="inverted mirror inverted" offset="0 0 0"/>
  </Symmetries>
  <SimulationDomain min="-40.50931167603 -40.50931167603 0" max="40.50931167603 40.50931167603 26.23999977112"/>
  <PlotSettings Plot="4" ignore_symmetry="0" deformation="0"/>
  <Source type="SOLVER"/>
</MetaResultFile>
