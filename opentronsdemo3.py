from opentrons import protocol_api

metadata = {'apiLevel': '2.9'}

def run(protocol: protocol_api.ProtocolContext):
    plate = protocol.load_labware(
        load_name='corning_96_wellplate_360ul_flat',
        location=1)
    tiprack_1 = protocol.load_labware(
            load_name='opentrons_96_tiprack_1000ul',
            location=2)
    p300 = protocol.load_instrument(
            instrument_name='p1000_single',
            mount='right',
            tip_racks=[tiprack_1])

    p300.pick_up_tip()
    p300.aspirate(100, plate['A1'])
    p300.dispense(100, plate['B1'])
    p300.drop_tip()